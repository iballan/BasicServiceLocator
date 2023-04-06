//
//  ServiceLocator.swift
//
//  Created by mbh on 6/4/23.
//

/// Service Locator Protocol
public protocol ServiceLocator {
    func registerService<T>(_ type: T.Type, lazyInstance: @escaping () -> T)
    func registerService<T>(_ type: T.Type, instance: T)
    func getService<T>(_ type: T.Type) throws -> T
    func clear<T>(_ type: T.Type)
}
