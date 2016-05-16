//代理模式：为另一个对象提供一个替身或占位符以控制对这个对象的访问。
//远程代理：控制访问远程对象
//保护代理：基于权限的资源访问
//虚拟代理：控制访问创建开销大的资源



protocol InternetAccessProtocol {
    func response()
    func getId() -> String
}

class Facebook: InternetAccessProtocol {
    func response() {
        print("你好，欢迎访问脸书 ")
    }
    
    func getId() -> String {
        return "FaceBook"
    }
}

class Twitter: InternetAccessProtocol  {
    func response() {
        print("你好，欢迎访问推特")
    }
    
    func getId() -> String {
        return "FaceBook"
    }
}

class Cnblogs: InternetAccessProtocol  {
    func response() {
        print("你好，欢迎访问博客园")
    }
    
    func getId() -> String {
        return "Cnblogs"
    }
}






protocol ProxyType: InternetAccessProtocol {
    func setDelegate(delegate: InternetAccessProtocol)
}


//==========远程代理========

class ShadowsocksProxy: ProxyType {
    private var delegate: InternetAccessProtocol? = nil
    
    init(delegate: InternetAccessProtocol? = nil) {
        self.delegate = delegate
    }
    
    func setDelegate(delegate: InternetAccessProtocol) {
        self.delegate = delegate
    }
    
    func response() {
        delegate?.response()
    }
    
    func getId() -> String {
        return "ShadowsocksProxy"
    }
}

//=======保护代理============
class GreatFirewall: ProxyType {
    //黑名单
    private var blackList: Array<String> = [Facebook().getId(), Twitter().getId()]
    
    private var delegate: InternetAccessProtocol? = nil
    
    func setDelegate(delegate: InternetAccessProtocol) {
        if hasInTheBlackList(delegate) {
            print("你访问的\(delegate.getId())不可用")
            self.delegate = nil
        } else {
            self.delegate = delegate
        }
    }
    
    func response() {
        delegate?.response()
    }
    
    func getId() -> String {
        return (delegate?.getId())!
    }
    
    //判断是否被墙
    func hasInTheBlackList(webSite: InternetAccessProtocol) -> Bool {
        return blackList.contains { (item) -> Bool in
            if webSite.getId() == item {
                return true
            } else {
                return false
            }
        }
    }
}


class Client {
    private var shadowsocksProxy: ProxyType = ShadowsocksProxy()
    private var greatFirewall: ProxyType  = GreatFirewall()
    
    func useProxyAcccessWebSite(webSite: InternetAccessProtocol) {
        shadowsocksProxy.setDelegate(webSite)   //为代理指定代理对象，也就是要访问的网站
        shadowsocksProxy.response()
    }
    
    func useGreatFirewall(webSite: InternetAccessProtocol)  {
        greatFirewall.setDelegate(webSite)
        greatFirewall.response()
    }
}

let client = Client()

print("使用远程代理直接访问Facebook：")
client.useProxyAcccessWebSite(Facebook())

print("\n经过防火墙直接访问FaceBook：")
client.useGreatFirewall(Facebook())

print("\n经过防火墙访问远程代理，然后使用远程代理来访问Facebook：")
client.useGreatFirewall(ShadowsocksProxy(delegate: Facebook()))

print("\n经过防火墙直接访问博客园：")
client.useGreatFirewall(Cnblogs())




