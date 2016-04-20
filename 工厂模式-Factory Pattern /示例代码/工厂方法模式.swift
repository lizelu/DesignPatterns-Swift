//
//  DesignPatternDemo
//
//  Created by Mr.LuDashi on 16/4/12.
//  Copyright © 2016年 ZeluLi. All rights reserved.
//

import Foundation

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

//=========工厂方法模式(Factory Method Pattern)========
/// 工厂方法模式：定义了一个创建对象的接口，但由子类决定要实例化的类是哪一个。工厂方法让类把实例化推迟到子类。
//依赖倒置原则：要依赖抽象，不要依赖具体类

///使用“装饰者模式”为武器添加不同的装饰（生产厂商）

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
 *  武器用户的接口
 */

protocol WeaponUser {
    func fireWithType(weaponType: WeaponTypeEnumeration)
    func createWeaponWithType(weaponType: WeaponTypeEnumeration) -> WeaponType!
}

// MARK: - 为fireWithType方法添加默认实现
extension WeaponUser {
    func fireWithType(weaponType: WeaponTypeEnumeration) {
        let weapon: WeaponType = createWeaponWithType(weaponType)
        print(weapon.fire())
    }
}


/// 德国用户：使用德国造
class GermanyWeaponUser: WeaponUser {
    func createWeaponWithType(weaponType: WeaponTypeEnumeration) -> WeaponType! {
        var weapon: WeaponType

        switch weaponType {
            case .AK:
                weapon = GermanyDecorator(weapon: AK())
            case .HK:
                weapon = GermanyDecorator(weapon: HK())
            case .AWP:
                weapon = GermanyDecorator(weapon: AWP())
        }
        return weapon
    }
}

/// 美国用户：使用美国造
class AmericaWeaponUser: WeaponUser {
    func createWeaponWithType(weaponType: WeaponTypeEnumeration) -> WeaponType! {
        var weapon: WeaponType

        switch weaponType {
        case .AK:
            weapon = AmericaDecorator(weapon: AK())
        case .HK:
            weapon = AmericaDecorator(weapon: HK())
        case .AWP:
            weapon = AmericaDecorator(weapon: AWP())
        }
        return weapon
    }
}

var user: WeaponUser = GermanyWeaponUser()
user.fireWithType(.AK)

user = AmericaWeaponUser()
user.fireWithType(.AK)



