//==========观察者模式=============================================
//设计原则：为了交互对象之间的松耦合设计而努力
class ObserverType {
    var info: String = ""
    func update(info: String) {}
    func display(){}
}

class SubjectType {
    private var observersArray: Array<ObserverType> = Array<ObserverType>()
    private var info: String = ""
    func registerObserver(observer: ObserverType){}
    func removeObserver(observer: ObserverType){}
    func notifyObservers(){}
}


//发出通知的人，也就是通知中心，大Boss
class Boss: SubjectType {

    func setInfo(info: String) {
        if info != self.info {
            self.info = info
            self.notifyObservers()
        }
    }

    override func registerObserver(observer: ObserverType) {
        self.removeObserver(observer)
        self.observersArray.append(observer)
    }

    override func removeObserver(observer: ObserverType) {
        for var i = 0; i < self.observersArray.count; i++ {
            if observersArray[i] === observer {
                self.observersArray.removeAtIndex(i);
                break
            }
        }
    }

    override func notifyObservers() {
        for observer:ObserverType  in self.observersArray {
            observer.update(self.info)
        }
    }
}


//程序员
class Coder: ObserverType {

    override func update(info: String) {
        self.info = info
        display()
    }

    override func display() {
        print("程序员收到：\(self.info)")
    }
}

//产品经理
class PM: ObserverType {

    override func update(info: String) {
        self.info = info
        display()
    }

    override func display() {
        print("产品经理收到收到：\(self.info)")
    }
}


//创建Boss
let bossSubject: Boss = Boss()

//创建观察者
let coderObserver: Coder = Coder()
let pmObserver: PM = PM()

//添加观察着
bossSubject.registerObserver(coderObserver)
bossSubject.registerObserver(pmObserver)
bossSubject.setInfo("第一次通知")

//程序员走出了会议室（移除观察者）
bossSubject.removeObserver(coderObserver)
bossSubject.setInfo("第二次通知")
