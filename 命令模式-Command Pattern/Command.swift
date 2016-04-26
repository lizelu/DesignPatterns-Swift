//--命令模式: 将“请求”封装成对象，以便使用不同的请求、队列或者日志来参数化其他对象。命令模式也支持可撤销的操作。

//外设
class Light {
    func on() {
        print("电灯已打开")
    }

    func off() {
        print("电灯已关闭")
    }
}

class Computer {
    func start() {
        print("计算机正在启动")
    }

    func screenLight() {
        print("屏幕已经点亮")
    }

    func load() {
        print("计算机正在加载系统")
    }

    func startOver() {
        print("计算机启动完毕")
    }

    func off() {
        print("计算机已关闭")
    }
}


//命令
protocol Command {
    func execute() -> Void
}


class LightOnCommand: Command {
    private let light = Light()
    func execute() {
        light.on()
    }
}

class LightOffCommand: Command {
    private let light = Light()
    func execute() {
        light.off()
    }
}

class ComputerStartCommand: Command {
    private let computer = Computer()
    func execute() {
        computer.start()
        computer.screenLight()
        computer.load()
        computer.startOver()
    }
}

//控制台
class Console {
    private var command: Command? = nil

    func setCommand(command: Command) {
        self.command = command
    }

    func action() {
        command?.execute()
    }
}



var console: Console = Console()

console.setCommand(LightOnCommand())
console.action()

console.setCommand(LightOffCommand())
console.action()

console.setCommand(ComputerStartCommand())
console.action()

