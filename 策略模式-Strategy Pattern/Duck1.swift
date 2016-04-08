class Duck {
    func swim() {
        print("鸭子游泳喽~")
    }

    func quack() {
        print("鸭子呱呱叫")
    }

    func display(){
    }
}

class MallarDuck: Duck {
    override func display() {
        print("我是绿头鸭子")
    }
}

class RedHeadDuck: Duck {
    override func display() {
        print("我是红头鸭子")
    }
}

class RubberDuck: Duck {


    override func display() {
        print("橡皮鸭")
    }
}



/**
* 现在要为某些鸭子添加上飞的方法，该如何去做呢？
* 一些假的鸭子是不能飞的
* 1、在基类中添加fly()，在不会飞的鸭子中重新fly， 但是这样的话，子类中会有些无用的方法
2.使用接口，需要实现fly()的鸭子，实现接口即可，但是会产生重复的带。
*/
