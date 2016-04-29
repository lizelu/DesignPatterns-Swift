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


//将上面的内容使用外观模式进行简化
class EveryDayWorking {
    private var socket: SocketType = OXSocket()
    private var cumputer: ComputerType = MacBookPro()
    private var display: DisplayDeviceType = SamsungDisplay()
    
    func setSocket(socket: SocketType) {
        self.socket = socket
    }
    
    func setCumputer(cumputer: ComputerType) {
        self.cumputer = cumputer
    }
    
    func setDisplay(display: DisplayDeviceType) {
        self.display = display
    }
    
    func startWorking() {
        print("开始工作：")
        socket.on()
        cumputer.startUp()
        display.on()
    }
    
    func endWorking() {
        print("结束工作：")
        display.off()
        cumputer.shutdown()
        socket.off()
    }
}



let everyDayWorking = EveryDayWorking()
everyDayWorking.startWorking()
print("\n")
everyDayWorking.endWorking()
