//====装饰者模式（Decorate Pattern）====
//开放关闭原则：类应该对扩展开放，对修改关闭
//在不修改代码的情况下进行功能扩展
//装饰者模式：动态地将责任附加到对象上。若要扩展功能，装饰着提供了比继承更有弹性的替代方案。

///=================定义基类==========================
/// 饮料基类
class Beverage {
    var description: String
    
    init(description: String = "Unknown Beverage") {
        self.description = description
    }
    
    func getDescription() -> String {
        return description
    }
    
    func cost() -> Double {
        return 0.0
    }
}

/// 调料基类
class CondimentDecorator: Beverage {
    override func getDescription() -> String {
        return ""
    }
}



///=================实现不同的咖啡==============
/// 浓缩咖啡
class Espresso: Beverage {
    init() {
        super.init(description: "浓缩咖啡")
    }
    
    override func cost() -> Double {
        return 1.99
    }
}

class HouseBlend: Beverage {
    init() {
        super.init(description: "星巴克杜绝调配咖啡：综合咖啡")
    }
    
    override func cost() -> Double {
        return 0.99
    }
}



/// ============实现各种调料===========
///摩卡
class Mocha: CondimentDecorator {
    var beverage: Beverage
    init(beverage: Beverage) {
        self.beverage = beverage
    }
    
    override func getDescription() -> String {
        return "摩卡, " + beverage.getDescription()
    }
    
    override func cost() -> Double {
        return beverage.cost() + 0.29
    }
}

/// 牛奶
class Milk: CondimentDecorator {
    var beverage: Beverage
    init(beverage: Beverage) {
        self.beverage = beverage
    }
    
    override func getDescription() -> String {
        return "牛奶, " + beverage.getDescription()
    }
    
    override func cost() -> Double {
        return beverage.cost() + 0.59
    }
}



/**
 *  使用
 */
//创建浓缩咖啡
var espresso: Beverage = Espresso()

/**
 *  用户点了一杯牛奶摩卡浓缩咖啡
 */
espresso = Milk(beverage: espresso)     //加牛奶
espresso = Mocha(beverage: espresso)    //加Mocha

espresso.getDescription()
espresso.cost()




