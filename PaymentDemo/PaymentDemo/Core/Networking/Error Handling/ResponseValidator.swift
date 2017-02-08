//
//  ResponseValidator.swift
//  StudyWiser
//
//  Created by Evgeniy Leychenko on 23.09.16.
//  Copyright © 2016 TheAppSolutions. All rights reserved.
//

import Foundation

final class DefaultResponseValidator {
    
}

extension DefaultResponseValidator: ResponseValidator {
    
    func validate(result: Result<AnyObject>) -> Result<AnyObject> {
        switch result {
        case .success(let value):
            if let error = ResponseError.parseError(JSON: value) {
                return .failure(error)
            } else {
                return result
            }
        case .failure(_):
            return .failure(ResponseError.unknown)
        }
    }
}
