# BasicServiceLocator
Very BasicServiceLocator for Swift


## Installation

### CocoaPods

`pod 'BasicServiceLocator'`


### Swift Package Manager

Once you have your Swift package set up, adding SwiftyTimber as a dependency is as easy as adding it to the dependencies value of your Package.swift.

```swift
dependencies: [
    .package(url: "https://github.com/iballan/BasicServiceLocator.git", .upToNextMajor(from: "0.0.2"))
]
```


## USAGE

```swift
// Protocols
protocol ServiceA {}
protocol ServiceB {}

// Implementation
class ServiceAA: ServiceA {}
class ServiceBB: ServiceB {}

// Fake or Debug Implementation
class FakeServiceB: ServiceB{}

// Service Resolver and Container
let serviceLocator : ServiceLocator = BasicServiceLocator()

// Registering
serviceLocator.registerService(ServiceA.self, instance: ServiceAA())
serviceLocator.registerService(ServiceB.self) {
    #if DEBUG
        return FakeServiceB()
    #else
        return ServiceBB()
    #endif
}

// Fetching and using service
let serviceA = try? serviceLocator.getService(ServiceA.self)
let serviceB = try! serviceLocator.getService(ServiceB.self)
```

