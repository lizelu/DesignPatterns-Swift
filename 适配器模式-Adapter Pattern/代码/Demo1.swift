protocol AType {
    func functionA();
}

class A: AType {
    func functionA() {
        print("我是AAA")
    }
}


protocol BType {
    func functionB()
}

class B: BType {
    func functionB() {
        print("我是BBBB")
    }
}


//对象适配器
class AdapterA: BType {
    var a: AType
    init(a: AType) {
        self.a = a
    }
    
    func functionB() {
        a.functionA()
    }
}

//类适配器
class AdapterAA: A, BType{
    func functionB() {
        self.functionA()
    }
}


func driverB(b: BType) {
    b.functionB()
}
