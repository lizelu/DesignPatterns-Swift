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

//=======简单工厂模式（Simple Factory Pattern）========
//使用“简单工厂模式”将变化的部分进行提取

// WeaponFactory就是我们的简单工厂
class WeaponFactory {

    func createWeaponWithType(weaponType: WeaponTypeEnumeration) -> WeaponType {
        var weapon: WeaponType

        switch weaponType {
            case .AK:
                weapon = AK()
            case .HK:
                weapon = HK()
            case .AWP:
                weapon = AWP()
        }

        return weapon
    }
}

class WeaponUser {
    var weaponFactory: WeaponFactory

    init(weaponFactory: WeaponFactory) {
        self.weaponFactory = weaponFactory
    }

    func fireWithType(weaponType: WeaponTypeEnumeration) {
        let weapon: WeaponType = weaponFactory.createWeaponWithType(weaponType)
        print(weapon.fire())
    }
}
let weaponUser: WeaponUser = WeaponUser(weaponFactory: WeaponFactory())

weaponUser.fireWithType(.AK)
weaponUser.fireWithType(.AWP)



