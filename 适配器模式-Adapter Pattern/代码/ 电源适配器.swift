//家用插座协议
protocol SocketType {
    func socketOutputVoltage() -> Float
}

///家用插座输出电压为220V
class Socket: SocketType {
    func socketOutputVoltage() -> Float {
        return 220.0
    }
}


//========计算机电源接口================
protocol ComputerPowerSourceType {
    func outputVoltage() -> Float
}

//MacBookPro的电池(自带电源)
class MacBookProBattery: ComputerPowerSourceType{
    func outputVoltage() -> Float {
        return 16.5
    }
}

class MacBookPro {
    //电源
    private var powerSource: ComputerPowerSourceType? = nil
    
    //连接电源
    func connectPowerSource(powerSource: ComputerPowerSourceType) {
        self.powerSource = powerSource
    }
    
    //电源输入电压
    func inputVoltage() {
        if powerSource != nil {
            print("输入电压为：\(powerSource!.outputVoltage())")
        }
    }
}

//如果没有适配器，MacBookPro就只能使用MacBookProBattery（自带电池），而无法使用Socket（插座），要想MacBookPro也可以使用Socket进行供电就必须有“适配器”进行转换



//计算机连接插座的适配器

//对象适配器：包含某个插座类型
class MacPowerObjectAdapter: ComputerPowerSourceType {
    var socketPower: SocketType? = nil     //电源接口对象
    
    //适配器的一端插入插座
    func insertSocket(socketPower: SocketType) {
        self.socketPower = socketPower
    }
    
    //电流通过适配器后进行输出，输出规则要遵循ComputerPowerSourceType协议
    func outputVoltage() -> Float {
        //通过各种电路将电压进行转换
        guard let  voltage = socketPower?.socketOutputVoltage() else {
            return 0
        }
        
        if voltage > 16.5 {
            return 16.5
        } else {
            return 0
        }
    }
}

//类适配器：继承自某个特定插座并实现计算机电源协议
class MacPowerClassAdapter: Socket, ComputerPowerSourceType {
    func outputVoltage() -> Float {
        if self.socketOutputVoltage() > 16.5 {
            return 16.5
        } else {
            return 0
        }
    }
}



let macBookPro: MacBookPro = MacBookPro()       //创建笔记本对象
let macBookProBattery = MacBookProBattery()     //创建MacBookPro所用电池的对象
let socket: SocketType = Socket()               //创建电源对象

//创建适配器“对象适配器”的对象
let macBookProObjectAdapter: MacPowerObjectAdapter = MacPowerObjectAdapter()

//创建“类适配器”对象
let macBookProClassAdapter: MacPowerClassAdapter = MacPowerClassAdapter()


print("笔记本使用电池")
macBookPro.connectPowerSource(macBookProBattery)
macBookPro.inputVoltage()

print("\n电池没电了，使用对象适配器")
macBookProObjectAdapter.insertSocket(socket)              //1.适配器插入插座
macBookPro.connectPowerSource(macBookProObjectAdapter)    //2.MacBookPro连接适配器
macBookPro.inputVoltage()                                 //3.电流输出

print("\n使用类适配器")
macBookPro.connectPowerSource(macBookProClassAdapter)
macBookPro.inputVoltage()