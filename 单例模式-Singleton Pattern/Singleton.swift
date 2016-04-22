//---单例模式0（Singleton Pattern）---
//单例模式：确保一个类只有一个实例，并提供一个全局访问点。

//使用GCD来创建单例
class SingletonManager {
    static private var onceToken: dispatch_once_t = 0
    static private var staticInstance: SingletonManager? = nil
    static func sharedInstance() -> SingletonManager {
        dispatch_once(&onceToken) {
            staticInstance = SingletonManager()
        }
        return staticInstance!
    }
    private init() {}
}

let single1 = SingletonManager.sharedInstance()
let single2 = SingletonManager.sharedInstance()
unsafeAddressOf(single1)
unsafeAddressOf(single2)



//静态变量进行创建
class SingletonManager1 {
    static private let staticInstance: SingletonManager1 = SingletonManager1()
    static func sharedInstance() -> SingletonManager1 {
        return staticInstance
    }
    private init() {}
}

let single01 = SingletonManager1.sharedInstance()
let single02 = SingletonManager1.sharedInstance()

unsafeAddressOf(single01)
unsafeAddressOf(single02)