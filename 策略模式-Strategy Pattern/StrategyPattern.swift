//实现角色可以使用的不同的攻击行为，也就是不同的攻击策略
//武器策略
protocol WeaponBehavior {
    func useWeapon();
}

class AWPBehavior: WeaponBehavior {
    func useWeapon() {
        print("大狙---biu~biu~")
    }
}

class HK48Behavior: WeaponBehavior {
    func useWeapon() {
        print("HK48---tu~tu~tu~")
    }
}

class PistolBehavior: WeaponBehavior {
    func useWeapon() {
        print("手枪--pa~pa~pa~")
    }
}

//上面定义了一系列的武器策略
//下面是用户=================

class Character {
    //默认是配备的是手枪
    private var weapon: WeaponBehavior! = PistolBehavior()
    
    func setWeapon(weapon: WeaponBehavior) {
        self.weapon = weapon
    }
    
    //换手枪
    func changePistol() {
        self.setWeapon(PistolBehavior());
    }
    
    func fire() {
        guard self.weapon != nil else {
            return
        }
        self.weapon.useWeapon()
    }
}

//中尉只配备了手枪和HK48
class Lieutenant: Character {
    
    override init() {
        super.init();
    }
    
    //切换武器（策略）：换HK
    func changeHK() {
        self.setWeapon(HK48Behavior());
    }
}

//上尉尉只配备了手枪和大狙
class Captain: Character {
    
    override init() {
        super.init();
    }
    //切换武器（策略）：换大狙
    func changeAWP() {
        self.setWeapon(AWPBehavior());
    }
}



//中尉
let lieutenant: Lieutenant = Lieutenant()
lieutenant.fire()

print("\n手枪火力不行，得换HK48\n")

lieutenant.changeHK()
lieutenant.fire()
