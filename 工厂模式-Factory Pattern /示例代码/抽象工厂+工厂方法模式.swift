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


/**
 *  抽象工厂 + 工厂方法， 使用工厂方法模式重写WeaponUser类的结构
 */


protocol WeaponUserType {
    
    func fireWithType(weaponType: WeaponTypeEnumeration)
    func createWeaponWithType(weaponType: WeaponTypeEnumeration) -> WeaponType!
    
    //工厂方法
    func createWeaponFactory() -> WeaponFactoryType
    
}

// MARK: - 为fireWithType方法添加默认实现
extension WeaponUserType {
    func fireWithType(weaponType: WeaponTypeEnumeration) {
        let weapon: WeaponType = createWeaponWithType(weaponType)
        print(weapon.fire())
    }
    
    func createWeaponWithType(weaponType: WeaponTypeEnumeration) -> WeaponType! {
        var weapon: WeaponType
        
        switch weaponType {
        case .AK:
            weapon = createWeaponFactory().createAK()
        case .AWP:
            weapon = createWeaponFactory().createAWP()
        case .HK:
            weapon = createWeaponFactory().createHK()
        }
        return weapon
    }
    
}


class AmericanWeaponUser: WeaponUserType {
    func createWeaponFactory() -> WeaponFactoryType {
        return AmericanWeaponFactory()
    }
}

class GermanyWeaponUser: WeaponUserType {
    func createWeaponFactory() -> WeaponFactoryType {
        return GermanyWeaponFactory()
    }
}

var  user: WeaponUserType = AmericanWeaponUser()
user.fireWithType(.AK)
user.fireWithType(.AWP)
user.fireWithType(.HK)

user = GermanyWeaponUser()
user.fireWithType(.AK)
user.fireWithType(.AWP)
user.fireWithType(.HK)

