//
//  MyCustomNotificationCenter.swift
//  DesignPatternDemo
//
//  Created by Mr.LuDashi on 16/3/22.
//  Copyright © 2016年 ZeluLi. All rights reserved.
//

import Foundation

///通知
class MyCustomNotification : NSObject {
    let name: String
    let object: AnyObject?
    let userInfo: [NSObject : AnyObject]?
    
    init(name: String, object: AnyObject?, userInfo: [NSObject : AnyObject]?){
        self.name = name
        self.object = object
        self.userInfo = userInfo
    }
}


//观察者
class MyObserver: NSObject {
    let observer: AnyObject
    let selector: Selector
    
    init(observer: AnyObject, selector: Selector) {
        self.observer = observer
        self.selector = selector
    }
}

typealias ObserverArray = Array<MyObserver>
//主题
class MySubject: NSObject {
    var notification: MyCustomNotification?
    var observers: ObserverArray
    
    init(notification: MyCustomNotification!, observers: ObserverArray) {
        self.notification = notification
        self.observers = observers
    }
    
    //添加观察者
    func addCustomObserver(observe: MyObserver) {
        for var i = 0; i < observers.count; i++ {
            if observers[i].observer === observe.observer {
                return
            }
        }
        self.observers.append(observe)
    }
    
    //移除观察者
    func removeCustomObserver(observe: AnyObject) {
        for var i = 0; i < observers.count; i++ {
            if observers[i].observer === observe {
                observers.removeAtIndex(i);
                break;
            }
        }
    }
    
    //发送通知
    func postNotification() {
        for var i = 0; i < observers.count; i++ {
            let myObserver: MyObserver = self.observers[i]
            myObserver.observer.performSelector(myObserver.selector, withObject: self.notification)
        }
    }
}




typealias SubjectDictionary = Dictionary<String, MySubject>

class MyCustomNotificationCenter: NSObject {
    
    //================创建单例=============================
    private static let singleton = MyCustomNotificationCenter()
    static func defaultCenter() -> MyCustomNotificationCenter {
        return singleton
    }
    override private init() {
        super.init()
    }
    
    
    //================通知中心，存储的是Subject对象的集合============
    private var center: SubjectDictionary = SubjectDictionary()
    
    //发出通知
    func postNotification(notification: MyCustomNotification) {
        
        let subject = self.getSubjectWithNotifaction(notification)
        subject.postNotification()
        
    }
    
    //根据Notification获取相应的Subject对象，没有的话就创建
    func getSubjectWithNotifaction(notification: MyCustomNotification) -> MySubject {
        
        guard let subject: MySubject = center[notification.name] else {
            center[notification.name] = MySubject(notification: notification, observers: ObserverArray())
            return self.getSubjectWithNotifaction(notification)
        }
        
        if subject.notification == nil {
            subject.notification = notification
        }
        
        return subject
    }
    
    //添加监听者
    func addObserver(observer: AnyObject, aSelector: Selector, aName: String) {
        let myObserver = MyObserver(observer: observer, selector: aSelector)
        
        var subject: MySubject? = center[aName]
        
        if subject == nil {
            subject = MySubject(notification: nil, observers: ObserverArray())
            center[aName] = subject
        }
        
        subject!.addCustomObserver(myObserver)
    }
    
    //从通知中心移除Observe
    func removeObserver(observer: AnyObject,  name: String) {
        guard let subject: MySubject = center[name] else {
            return
        }
        subject.removeCustomObserver(observer)
        
    }
    
}



class Boss: NSObject {
    func sendMessage(message: String) {
        //1.创建消息字典
        let userInfo = ["message":message];
        //2.创建通知
        let notifaction = MyCustomNotification.init(name: "Boss", object:self, userInfo: userInfo)
        //3.发送通知
        MyCustomNotificationCenter.defaultCenter().postNotification(notifaction)
    }
    
}

//通知的接受者
class Coder: NSObject {
    func observeBoss() {
        MyCustomNotificationCenter.defaultCenter().addObserver(self, aSelector: "accepteNotificaton:", aName: "Boss")
    }
    
    func accepteNotificaton(notification: MyCustomNotification) {
        let info: Dictionary = notification.userInfo!
        print("收到老板的通知了：\(info["message"]!)")
    }
    
    deinit {
        MyCustomNotificationCenter.defaultCenter().removeObserver(self, name: "Boss")
    }
}


let boss = Boss()
let coder = Coder()
let coder1 = Coder()

coder.observeBoss()
coder1.observeBoss()

boss.sendMessage("涨工资啦")



