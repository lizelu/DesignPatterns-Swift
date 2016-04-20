//使用Foundation中自带的通知模式

//Subject
class Boss: NSObject {
    func sendMessage(message: String) {
        //1.创建消息字典
        let userInfo = ["message":message];
        //2.创建通知
        let notifaction = NSNotification.init(name: "Boss", object:self, userInfo: userInfo)
        //3.发送通知
        NSNotificationCenter.defaultCenter().postNotification(notifaction)
    }
    
}

//Observer
class Coder: NSObject {
    func observeBoss() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"accepteNotificaton:", name: "Boss", object: nil)
    }
    
    func accepteNotificaton(notification: NSNotification) {
        let info: Dictionary = notification.userInfo!
        print("收到老板的通知了：\(info["message"]!)")
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "Boss", object: nil)
    }
}


let boss = Boss()

let coder = Coder()
coder.observeBoss()

boss.sendMessage("涨工资啦")
