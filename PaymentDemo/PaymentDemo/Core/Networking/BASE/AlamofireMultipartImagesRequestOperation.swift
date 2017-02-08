//
//  AlamofireMultipartRequestOperation.swift
//  HIYR
//
//  Created by Evgeniy Leychenko on 19.12.16.
//  Copyright © 2016 theappsolutions.com. All rights reserved.
//

import UIKit
import Alamofire

public final class AlamofireMultipartImagesRequestOperation: NetworkRequestOperation {
    
    private struct Constants {
        static let maxFileSize: Int = 1 * 1024 * 1024 // 1 MB
    }
    
    var request: Alamofire.Request?
    
    // MARK: - Public -
    
    override func startRequest(withCompletionHandler completion: ((Result<AnyObject>) -> Void)?) {
        Alamofire.upload(multipartFormData: { [weak self] (multipartFormData) in
            if let parameters = self?.configuration.parameters as? [String: String] {
                for (key, value) in parameters {
                    multipartFormData.append(value.data(using: .utf8)!, withName: key)
                }
            }
            
            if let multipart = self?.configuration.multipartImages {
                for (index, image) in multipart.images.enumerated() {
                    if let imageData = self?.data(from: image, constrainedTo: Constants.maxFileSize) {
                        multipartFormData.append(imageData, withName: multipart.parameterName, fileName: "image\(index).png", mimeType: "image/png")
                    }
                }
            }
        }, to: buildURL(),
           method: HTTPMethod(rawValue: configuration.method.rawValue)!,
           headers: configuration.headers) { (result) in
            switch result {
            case .success(let upload, _, _):
                
                upload.responseJSON { response in
                    completion?(response.internalResult())
                }
                
            case .failure(let encodingError):
                completion?(Result.failure(encodingError))
            }
        }
    }
    
    override public var isCancelled: Bool {
        didSet {
            request?.cancel()
        }
    }
    
    // MARK: - Private -
    
    private func data(from image: UIImage, constrainedTo size: Int) -> Data? {
        guard let imageData = UIImageJPEGRepresentation(image, 1) else {
            return nil
        }
        
        if imageData.count < size {
            return imageData
        } else {
            let compression = CGFloat(size) / CGFloat(imageData.count)
            return UIImageJPEGRepresentation(image, compression)
        }
    }
}

private extension DataResponse {
    func internalResult() -> Result<AnyObject> {
        switch self.result {
        case .success(let value):
            return Result.success(value as AnyObject)
        case .failure(let error):
            print(error)
            return Result.failure(error)
        }
    }
}
