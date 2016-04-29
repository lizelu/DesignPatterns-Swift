//插排接口
protocol SocketType {
    func on() -> Void
    func off() -> Void
}
//公牛插排
class OXSocket: SocketType {
    func on() {
        print("公牛开关已打开")
    }
    
    func off() {
        print("公牛开关已关闭")
    }
}

//笔记本接口
protocol ComputerType {
    func startUp() -> Void
    func shutdown() -> Void
}

//MacBookPro
class MacBookPro: ComputerType {
    func startUp() {
        print("OS X 已启动")
    }
    
    func shutdown() {
        print("OS X 已关闭")
    }
}


//显示器接口
protocol DisplayDeviceType {
    func on() -> Void
    func off() -> Void
}

//三星显示器
class SamsungDisplay: DisplayDeviceType {
    func on() {
        print("三星显示器已打开")
    }
    
    func off() {
        print("三星显示器已关闭")
    }
}


//创建所需的对象
let oxSocket: SocketType = OXSocket()
let macBookPro: ComputerType = MacBookPro()
let samsungDisplay: DisplayDeviceType = SamsungDisplay()


print("每天上班要做的三件事情:")
oxSocket.on()
macBookPro.startUp()
samsungDisplay.on()

print("\n每天下班要做的事情:")
samsungDisplay.off()
macBookPro.shutdown()
oxSocket.off()

