
//炒菜的接口
protocol FryVegetablesType {
    func fry()                  //模板方法，在延展中给出默认实现
    func reportTheDishNames()   //报菜名，在子类中给出实现
    func putSomeOil()           //放油，在延展中给出默认实现
    func putSomeGreenOnion()    //放葱花，在延展中给出默认实现
    func putVegetables()        //放蔬菜，在子类中给出具体实现
    func putSpices()            //放调料，在子类中给出具体实现
    func outOfThePan()          //出锅，在延展中给出具体实现
}

//对炒菜接口提供的延展，给出了炒菜中共同的部分和“模板方法”
extension FryVegetablesType {
    func fry() {
        reportTheDishNames()
        putSomeOil()
        putSomeGreenOnion()
        putVegetables()
        putSpices()
        outOfThePan()
    }
    
    func putSomeOil() {
        print("往锅里放油！")
    }
    
    func putSomeGreenOnion() {
        print("放葱花爆香！")
    }
    
    func outOfThePan() {
        print("出锅！\n")
    }
}

//醋溜土豆丝
class FryShreddedPotatoes: FryVegetablesType {
    
    //报菜名
    func reportTheDishNames() {
        print("醋溜土豆丝：")
    }
    
    func putVegetables() {
        print("放土豆丝和青红椒丝！")
    }
    
    func putSpices() {
        print("放盐和醋！")
    }
}


//清炒苦瓜
class FryBitterGourd: FryVegetablesType  {
    func reportTheDishNames() {
        print("清炒苦瓜：")
    }
    
    func putVegetables() {
        print("放苦瓜片和青红椒片! ")
    }
    
    func putSpices() {
        print("放盐！")
    }
}



let fryShreddedPotatoes: FryShreddedPotatoes = FryShreddedPotatoes()
fryShreddedPotatoes.fry()

let fryBitterGourd: FryBitterGourd = FryBitterGourd()
fryBitterGourd.fry()
