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

class WeaponUser {
    func fireWithType(weaponType: WeaponTypeEnumeration) {
        var weapon: WeaponType
        
        switch weaponType {
            case .AK:
                weapon = AK()
            case .HK:
                weapon = HK()
            case .AWP:
                weapon = AWP()
        }
        
        print(weapon.fire())
    }
}


let weaponUser: WeaponUser = WeaponUser()

weaponUser.fireWithType(.AK)
weaponUser.fireWithType(.AWP)


