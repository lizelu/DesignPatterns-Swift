//
//  DesignPatternDemo
//
//  Created by Mr.LuDashi on 16/4/12.
//  Copyright © 2016年 ZeluLi. All rights reserved.
//

import Foundation

/**
 *  抽象工厂模式(Abstract Factory)
 *  提供一个接口，用于创建相关或者依赖对象的家族，而不需要明确指向具体类
 */
enum WeaponTypeEnumeration {
    case AK, HK, AWP
}

protocol WeaponType {
    func fire() -> String
}

class AK: WeaponType {
    func fire() -> String {
        return "AK: Fire"
    }
}

class AWP: WeaponType {
    func fire() -> String {
        return "AWP: Fire"
    }
}

class HK: WeaponType {
    func fire() -> String {
        return "HK: Fire"
    }
}


class WeaponDecorator: WeaponType {
    var weapon: WeaponType! = nil
    init(weapon: WeaponType) {
        self.weapon = weapon
    }
    
    func fire() -> String {
        return weapon.fire()
    }
    
}
///添加德国厂商装饰
class GermanyDecorator: WeaponDecorator {
    override func fire() -> String {
        return "德国造：" + self.weapon.fire()
    }
}

/// 添加美国厂商装饰
class AmericaDecorator: WeaponDecorator {
    override func fire() -> String {
        return "美国造：" + weapon.fire()
    }
}



/**
 *  创建抽象工厂（工厂接口）
 */
protocol WeaponFactoryType {
    func createAK() -> WeaponType
    func createAWP() -> WeaponType
    func createHK() -> WeaponType
    
}

/// 美国兵工厂：生产”美国造“系列的武器
class AmericanWeaponFactory: WeaponFactoryType {
    func createAK() -> WeaponType {
        return AmericaDecorator(weapon: AK())
    }
    
    func createAWP() -> WeaponType {
        return AmericaDecorator(weapon: AWP())
    }
    
    func createHK() -> WeaponType {
        return AmericaDecorator(weapon: HK())
    }
}

/// 德国兵工厂：生产”德国造“系列的武器
class GermanyWeaponFactory: WeaponFactoryType {
    
    func createAK() -> WeaponType {
        return GermanyDecorator(weapon: AK())
    }
    
    func createAWP() -> WeaponType {
        return GermanyDecorator(weapon: AWP())
    }
    
    func createHK() -> WeaponType {
        return GermanyDecorator(weapon: HK())
    }
}



/// 对用户进行重写
class WeaponUser {
    
    private var factory: WeaponFactoryType
    
    init(factory: WeaponFactoryType) {
        self.factory = factory
    }
    
    func setFactory(factory: WeaponFactoryType) {
        self.factory = factory
    }
    
    
    func fireWithType(weaponType: WeaponTypeEnumeration) {
        var weapon: WeaponType
        
        switch weaponType {
        case .AK:
            weapon = factory.createAK()
        case .AWP:
            weapon = factory.createAWP()
        case .HK:
            weapon = factory.createHK()
        }
        
        print(weapon.fire())
    }
}

var user: WeaponUser = WeaponUser(factory: AmericanWeaponFactory())
user.fireWithType(.AK)
user.fireWithType(.AWP)
user.fireWithType(.HK)

user.setFactory(GermanyWeaponFactory())
user.fireWithType(.AK)
user.fireWithType(.AWP)
user.fireWithType(.HK)
