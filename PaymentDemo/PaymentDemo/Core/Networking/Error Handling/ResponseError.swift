//
//  ResponseError.swift
//  StudyWiser
//
//  Created by Evgeniy Leychenko on 22.09.16.
//  Copyright © 2016 TheAppSolutions. All rights reserved.
//

import Foundation

protocol ServerError: Error {
    
    var messages: [String] { get }
}

class ResponseError: ServerError {
    
    static var unknown: ResponseError { return ResponseError(["Unknown error"]) }
    
    var messages: [String]
    
    init(_ errorMessages: [String]) {
        messages = errorMessages
    }
    
    static func parseError(JSON: AnyObject) -> ResponseError? {
        guard let errorJSON = JSON as? [String: AnyObject],
            let errors = errorJSON["errors"] as? [[String: AnyObject]]  else {
                return nil
        }
        
        let errorMessages = errors.flatMap { (error) -> String? in
            return error["message"] as? String
        }
        
        return ResponseError(errorMessages)
    }
}
