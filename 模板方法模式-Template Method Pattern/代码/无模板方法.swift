//模板方法模式
//模板方法定义了一个算法的步骤，并允许子类为一个或者多个步骤提供实现
//模板方法模式：在一个方法中定义了一个算法的骨架，而将一些步骤延迟到子类中。模板方法使得子类可以在不改变算法结构的情况下，重新定义算法中的某些步骤。

//醋溜土豆丝
class FryShreddedPotatoes {
    func fryShreddedPotatoes() {
        reportTheDishNames()
        putSomeOil()
        putSomeGreenOnion()
        putPotatoes()
        putSaltAndVinegar()
        outOfThePan()
    }

    //报菜名
    func reportTheDishNames() {
        print("醋溜土豆丝：")
    }

    func putSomeOil() {
        print("往锅里放油！")
    }

    func putSomeGreenOnion() {
        print("放葱花爆香！")
    }

    func putPotatoes() {
        print("放土豆丝和青红椒丝！")
    }

    func putSaltAndVinegar() {
        print("放盐和醋！")
    }

    func outOfThePan() {
        print("出锅！\n")
    }
}


//清炒苦瓜
class FryBitterGourd {

    func fryBitterGourd() {
        reportTheDishNames()
        putSomeOil()
        putSomeGreenOnion()
        putBitterGourd()
        putSalt()
        outOfThePan()
    }

    //报菜名
    func reportTheDishNames() {
        print("清炒苦瓜：")
    }

    func putSomeOil() {
        print("往锅里放油！")
    }

    func putSomeGreenOnion() {
        print("放葱花爆香！")
    }

    func putBitterGourd() {
        print("放苦瓜片和青红椒片！")
    }

    func putSalt() {
        print("放盐！")
    }

    func outOfThePan() {
        print("出锅！\n")
    }
}



let fryShreddedPotatoes: FryShreddedPotatoes = FryShreddedPotatoes()
fryShreddedPotatoes.fryShreddedPotatoes()

let fryBitterGourd: FryBitterGourd = FryBitterGourd()
fryBitterGourd.fryBitterGourd()

