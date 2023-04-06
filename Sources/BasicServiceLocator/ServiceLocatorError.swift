//
//  ServiceLocatorError.swift
//  
//
//  Created by mbh on 6/4/23.
//

import Foundation

public enum ServiceLocatorError<T>: LocalizedError, CustomStringConvertible {
    case serviceNotFound(serviceType: T.Type)

    public var description: String {
        switch self {
        case .serviceNotFound(let serviceType):
            return "Service of type \(serviceType) not registered"
        }
    }

    public var errorDescription: String? {
        description
    }
}
