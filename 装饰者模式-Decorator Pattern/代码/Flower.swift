/// 花瓶的基类
class VaseComponent {
    
    private var description: String         //对花瓶进行描述
    
    init(description: String = "花瓶") {
        self.description = description
    }
    
    func getDescription() -> String {
        return self.description
    }
    
    func display() {
        print(getDescription())             //打印描述信息
    }
}


/// 鲜花的父类，因为装饰者就是最新的花瓶组件，所以要继承自VaseComponent
class FlowerDecorator: VaseComponent {
    var vase: VaseComponent
    
    init(vase: VaseComponent) {
        self.vase = vase
    }
}


/// 创建特定的花瓶
class Porcelain: VaseComponent {
    init() {
        super.init(description: "瓷花瓶：")
    }
}

class Glass: VaseComponent {
    init() {
        super.init(description: "玻璃花瓶：")
    }
}



//往花瓶里加入特定的化进行装饰
/// 玫瑰花
class Rose: FlowerDecorator{
    override func getDescription() -> String {
        return vase.getDescription() + "玫瑰 "
    }
}

//百合花
class Lily: FlowerDecorator {
    override func getDescription() -> String {
        return vase.getDescription() + "百合 "
    }
}

var porcelain: VaseComponent = Porcelain()  //创建空花瓶
porcelain.display()                         //打印最新的描述信息

porcelain = Rose(vase: porcelain)           //插入玫瑰
porcelain = Lily(vase: porcelain)           //插入百合

porcelain.display()                         //打印最新的描述信息



//var glass: VaseComponent = Glass()
//glass = Lily(vase: glass)
//glass.display()
//
