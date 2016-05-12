//==================使用状态模式进行重构======
//状态模式：允许对象在内部状态改变时改变它的行为，对象看起来好像修够了它的类。

enum ATMState {
    case NoBankCardState            //无卡
    case HasBankCardState           //有卡
    case DecodingState              //解密
    case FetchMoneyState            //可取款状态
    case OutMoneyState              //取款
    case InsufficientBalanceState   //余额不足
}

protocol StateType {
    func insertBankCard()
    func backBankCard()
    func inputPassword()
    func inputMoney(money: UInt)
    func tapOkButton()
}

protocol ATMType: StateType {
    func getCardMoney() -> UInt
    func getInputMoney() -> UInt
    func changeState(state: ATMState)
}


class BaseStateClass: StateType {
    private var atm: ATMType
    
    init(atm: ATMType) {
        self.atm = atm
    }
    
    func insertBankCard() {}
    func backBankCard() {}
    func inputPassword() {}
    func inputMoney(money: UInt) {}
    func tapOkButton() {}
    
}

//无卡状态类
class NoBankCardState: BaseStateClass {
    
    override func insertBankCard() {
        print("已插入银行卡, 现在可以输入密码或者退卡")
        atm.changeState(.HasBankCardState)
    }
    
    override func backBankCard() {
        print("无银行卡，无法退卡")
    }
    
    override func inputPassword() {
        print("无银行卡，无法进行输入密码操作，请插入银行卡")
    }
    override func inputMoney(money: UInt) {
        print("无银行卡，无法进行输入取款金额，请插入银行卡")
    }
    
    override func tapOkButton() {
        print("无银行卡，无法进行取款操作，请插入银行卡")
    }
}

//有卡状态类
class HasBankCardState: BaseStateClass {
    
    override func insertBankCard() {
        print("目前已经插入了一张银行卡，不可以再次插入，现在可以输入密码进行取款")
    }
    
    override func backBankCard() {
        print("已退卡")
    }
    
    override func inputPassword() {
        atm.changeState(.DecodingState)
        print("密码校验成功，现在可以输入金额进行取款")
    }
    
    override func inputMoney(money: UInt) {
        print("你还没有进行密码验证，请输入密码后方可输入取款金额")
    }
    
    override func tapOkButton() {
        print("你还没有进行密码验证以及输入金额操作，请输入上述步骤后方可进行取款操作")
    }
}
//解密状态类
class DecodingState: BaseStateClass {
    
    override func insertBankCard() {
        print("目前已经插入了一张银行卡，不可以再次插入，现在可以输入金额进行取款")
    }
    
    override func backBankCard() {
        print("已退卡")
    }
    
    override func inputPassword() {
        print("你的密码已经校验成功，请不要重复提交密码，现在可以输入金额进行取款")
    }
    
    override func inputMoney(money: UInt) {
        atm.changeState(.FetchMoneyState)
        print("输入金额成功，现在可点击确认按钮进行取款操作")
    }
    
    override func tapOkButton() {
        print("你还没有输入金额操作，请输入上述步骤后方可进行取款操作")
    }
}
//取款状态类
class FetchMoneyState: BaseStateClass {
    
    override func insertBankCard() {
        print("目前已经插入了一张银行卡，不可以再次插入，现在可以点击按钮进行取款")
    }
    
    override func backBankCard() {
        print("已退卡")
    }
    
    override func inputPassword() {
        print("你的密码已经校验成功，请不要重复提交密码，现在可以点击按钮进行取款")
    }
    
    override func inputMoney(money: UInt) {
        print("已输入提款金额，请不要重复提交，现在可点击确认按钮进行取款操作")
    }
    
    override func tapOkButton() {
        if atm.getInputMoney() > atm.getCardMoney() {
            atm.changeState(.InsufficientBalanceState)
            print("余额不足，你可以选择输入密码再次取款，或者退卡")
        } else {
            atm.changeState(.OutMoneyState)
            print("已取款，你可以选择输入密码再次取款，或者退卡")
        }
        
    }
}
//已取款状态类
class OutMoneyState: BaseStateClass {
    
    override func insertBankCard() {
        print("目前已经插入了一张银行卡，不可以再次插入，现在可以退卡或再次输入密码进行取款操作")
    }
    
    override func backBankCard() {
        print("已退卡")
    }
    
    override func inputPassword() {
        atm.changeState(.DecodingState)
        print("密码校验成功，现在可以输入金额进行取款")
        
    }
    
    override func inputMoney(money: UInt) {
        print("已输入提款金额，请不要重复提交，现在可点击确认按钮进行取款操作")
    }
    
    override func tapOkButton() {
        print("取款成功，现在可以退卡或再次输入密码进行取款操作")
    }
}
//余额不足状态类
class InsufficientBalanceState: BaseStateClass {
    
    override func insertBankCard() {
        print("目前已经插入了一张银行卡，不可以再次插入，现在可以退卡或再次输入密码进行取款操作")
    }
    
    override func backBankCard() {
        print("已退卡")
    }
    
    override func inputPassword() {
        atm.changeState(.DecodingState)
        print("密码校验成功，现在可以输入金额进行取款")
        
    }
    
    override func inputMoney(money: UInt) {
        print("已输入提款金额，请不要重复提交，现在可点击确认按钮进行取款操作")
    }
    
    override func tapOkButton() {
        print("余额不足，无法取款，现在可以退卡或再次输入密码进行取款操作")
    }
}

class ATM: ATMType {
    private var stateObject: StateType?
    private var cardMoney: UInt = 0
    private var inputMoney: UInt = 0
    
    init() {
        self.changeState(.NoBankCardState)
    }
    
    func getCardMoney() -> UInt {
        return cardMoney
    }
    func getInputMoney() -> UInt {
        return inputMoney
    }
    func changeState(state: ATMState) {
        switch state {
        case .NoBankCardState:
            stateObject = NoBankCardState(atm: self)
        case .HasBankCardState:
            stateObject = HasBankCardState(atm: self)
        case .DecodingState:
            stateObject = DecodingState(atm: self)
        case .FetchMoneyState:
            stateObject = FetchMoneyState(atm: self)
        case .OutMoneyState:
            stateObject = OutMoneyState(atm: self)
        case .InsufficientBalanceState:
            stateObject = InsufficientBalanceState(atm: self)
        }
    }
    
    func insertBankCard() {
        self.cardMoney = 20000
        stateObject?.insertBankCard()
    }
    
    func backBankCard() {
        stateObject?.backBankCard()
    }
    
    func inputPassword() {
        stateObject?.inputPassword()
    }
    
    func inputMoney(money: UInt) {
        inputMoney = money
        stateObject?.inputMoney(money)
    }
    
    func tapOkButton() {
        stateObject?.tapOkButton()
    }
}











let atm = ATM()

print("=======无卡状态下插入银行卡========")
atm.insertBankCard()

print("\n=======有卡状态下再次插入卡========")
atm.insertBankCard()

print("\n=======有卡状态输入密码========")
atm.inputPassword()
atm.inputMoney(100)
atm.tapOkButton()

print("\n=======取款后再次输入密码进行提款========")
atm.inputPassword()
atm.inputMoney(100000)
atm.tapOkButton()


print("\n=======退卡========")
atm.backBankCard()

print("\n====无卡时调用输入密码操作=====")
atm.inputPassword()
