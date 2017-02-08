//
//  ApiManager.swift
//  HIYR
//
//  Created by Evgeniy Leychenko on 06.12.16.
//  Copyright © 2016 theappsolutions.com. All rights reserved.
//

import Foundation

typealias SuccessResponse = (AnyObject) -> Void
typealias ErrorResponse = (ResponseError) -> Void
typealias ResultResponse = (Any?, ResponseError?) -> Void

protocol Networking {
    
    var authToken: String { get set }
    init(withRequestManager manager: RequestManager)
    func performRequest(request: RequestConfiguration,
                        usingValidator validator: ResponseValidator?,
                        success: SuccessResponse?,
                        failure: ErrorResponse?)
}

final class APIManager: Networking {
    
    var authToken = ""
    
    private let requestManager: RequestManager
    
    init(withRequestManager manager: RequestManager) {
        requestManager = manager
    }
    
    // MARK: - Public -
    
    func performRequest(request: RequestConfiguration,
                        usingValidator validator: ResponseValidator? = nil,
                        success: SuccessResponse? = nil,
                        failure: ErrorResponse? = nil) {
        let responseValidator = validator ?? DefaultResponseValidator()
        
        if request.multipartImages != nil {
            performMultipartRequest(request: request, usingValidator: responseValidator, success: success, failure: failure)
        } else {
            performDataRequest(request: request, usingValidator: responseValidator, success: success, failure: failure)
        }
    }
    
    // MARK: - Private -
    
    private func performDataRequest(request: RequestConfiguration,
                        usingValidator validator: ResponseValidator,
                        success: SuccessResponse? = nil,
                        failure: ErrorResponse? = nil) {
        let _ = requestManager.performRequest(request)
            .validateResult(withValidator: validator)
            .onSuccess({ value in
                DispatchQueue.main.async {
                    success?(value)
                }
            }).onFailure({ error in
                DispatchQueue.main.async {
                    if let responseError = error as? ResponseError {
                        failure?(responseError)
                    } else {
                        failure?(ResponseError.unknown)
                    }
                }
            })
    }
    
    private func performMultipartRequest(request: RequestConfiguration,
                                 usingValidator validator: ResponseValidator,
                                 success: SuccessResponse? = nil,
                                 failure: ErrorResponse? = nil) {
        let _ = requestManager.performMultipartImagesRequest(request)
            .validateResult(withValidator: validator)
            .onSuccess({ (value) in
                DispatchQueue.main.async {
                    success?(value)
                }
            }).onFailure { (error) in
                DispatchQueue.main.async {
                    if let responseError = error as? ResponseError {
                        failure?(responseError)
                    } else {
                        failure?(ResponseError.unknown)
                    }
                }
        }
    }
}

extension APIManager {
    static var shared: APIManager!
}
