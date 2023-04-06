//
//  BasicServiceLocator.swift
//
//  Created by mbh on 6/4/23.
//

/// Registry record
fileprivate enum RegistryRec {

    case Instance(Any)
    case Recipe(() -> Any)

    func unwrap() -> Any {
        switch self {
            case .Instance(let instance):
                return instance
            case .Recipe(let recipe):
                return recipe()
        }
    }
}

/// Basic Service Locator is the container and resolver of the Services
final class BasicServiceLocator: ServiceLocator {
    /// Service registry
    private lazy var reg: Dictionary<String, RegistryRec> = [:]

    /// Resolve the instance name from its type
    /// - Parameter some: Instance of the service
    /// - Returns: Name of the instance
    private func typeName(_ some: Any) -> String {
        return (some is Any.Type) ? "\(some)" : "\(type(of: some))"
    }

    /// Register service that will be created lazily when called for the first time
    /// - Parameters:
    ///   - type: Service Type to help resolve the name of the service instance
    ///   - lazyInstance: Callback that will help the BasicServiceLocator create the instance
    func registerService<T>(_ type: T.Type, lazyInstance: @escaping () -> T) {
        let key = typeName(type)
        reg[key] = .Recipe(lazyInstance)
    }

    /// Register service that will be created on the call
    /// - Parameters:
    ///   - type: Service Type to help resolve the name of the service instance
    ///   - instance: The service instance
    func registerService<T>(_ type: T.Type, instance: T) {
        let key = typeName(type)
        reg[key] = .Instance(instance)
    }

    /// Get the registered service or throws error if Service error if not exists
    /// - Parameter type: Service Type for the service to be located
    /// - Returns: Return the service needed
    func getService<T>(_ type: T.Type) throws -> T{
        let key = typeName(T.self)
        var instance: T? = nil
        if let registryRec = reg[key] {
            instance = registryRec.unwrap() as? T
            // Replace the recipe with the produced instance if this is the case
            switch registryRec {
                case .Recipe:
                    if let instance = instance {
                        registerService(type, instance: instance)
                    }
                default:
                    break
            }
        }
        guard let instance = instance else {
            throw ServiceLocatorError.serviceNotFound(serviceType: type)
        }
        return instance
    }

    /// Clear the service instance from the entries dictionary
    /// - Parameter type: Service Type
    func clear<T>(_ type: T.Type) {
        let key = typeName(type)
        reg.removeValue(forKey: key)
    }
}
