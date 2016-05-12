//状态模式：允许对象在内部状态改变时改变它的行为，对象看起来好像修够了它的类。

enum ATMState {
    case NoBankCardState            //无卡
    case HasBankCardState           //有卡
    case DecodingState              //解密
    case FetchMoneyState            //可取款状态
    case OutMoneyState              //取款
    case InsufficientBalanceState   //余额不足
}


class ATM {
    var state: ATMState = .NoBankCardState      //ATM的状态默认是无卡状态
    var money: UInt = 0
    var inputMoney: UInt = 0

    //插卡动作
    func insertBankCard() {
        switch state {
            case .NoBankCardState:
                state = .HasBankCardState
                money = 10_000
                print("已插入银行卡, 现在可以输入密码或者退卡")

            case .HasBankCardState:
                print("目前已有银行卡，可以输入密码进行取款")

            case .DecodingState:
                print("目前处于解密状态，可输入金额进行取款")

            case .FetchMoneyState:
                print("目前处于可取款状态，请点击确认按钮进行取款")

            case .OutMoneyState:
                print("已取款，你可以选择输入密码再次取款，或者退卡")

            case .InsufficientBalanceState:
                print("余额不足，你可以选择输入密码再次取款，或者退卡")
        }
    }

    //退卡动作
    func backBankCard() {
        switch state {
            case .NoBankCardState:
                print("无银行卡，无法退卡")
            case .HasBankCardState:
                fallthrough
            case .DecodingState:
                fallthrough
            case .FetchMoneyState:
                fallthrough
            case .InsufficientBalanceState:
                fallthrough
            case .OutMoneyState:
                state = .NoBankCardState
                print("已退卡")
        }
    }

    func inputPassword() {
        switch state {
            case .NoBankCardState:
                print("无银行卡，无法进行输入密码操作，请插入银行卡")

            case .HasBankCardState:
                state = .DecodingState
                print("密码校验成功，现在可以输入金额进行取款")

            case .DecodingState:
                print("已输入密码，现在可以输入金额进行取款")
            case .FetchMoneyState:
                print("已输入取款金额，现在可进行取款")

            case .OutMoneyState:
                state = .DecodingState
                print("已取款，再次输入密码进行取款")

            case .InsufficientBalanceState:
                state = .DecodingState
                print("余额不足，再次输入密码进行取款")
        }
    }           //输入密码动作
    func inputMoney(money: UInt) {
        switch state {
            case .NoBankCardState:
                print("无银行卡，无法进行输入取款金额，请插入银行卡")

            case .HasBankCardState:
                print("请输入密码后方可进行取款操作")

            case .DecodingState:
                self.state = .FetchMoneyState
                self.inputMoney = money
                print("输入金额成功")

            case .FetchMoneyState:
                print("已输入取款金额，现在可进行取款")
            case .OutMoneyState:
                print("已取款，你可以选择输入密码再次取款，或者退卡")
            case .InsufficientBalanceState:
                print("余额不足，你可以选择输入密码再次取款，或者退卡")
        }
    }   //输入金额动作
    func tapOkButton() {
        switch state {
            case .NoBankCardState:
                print("无银行卡，请插入银行卡")
            case .HasBankCardState:
                print("请输入密码后方可进行取款操作")
            case .DecodingState:
                print("已输入密码，现在可以输入金额进行取款")

            case .FetchMoneyState:
                if inputMoney > money {
                    state = .InsufficientBalanceState
                    print("余额不足，你可以选择输入密码再次取款，或者退卡")
                } else {
                    state = .OutMoneyState
                    print("已取款，你可以选择输入密码再次取款，或者退卡")
                }

            case .OutMoneyState:
                print("已取款，你可以选择输入密码再次取款，或者退卡")
            case .InsufficientBalanceState:
                print("余额不足，你可以选择输入密码再次取款，或者退卡")
        }

    }             //确认提款动作
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
