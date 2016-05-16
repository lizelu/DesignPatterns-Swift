//代理模式：为另一个对象提供一个替身或占位符以控制对这个对象的访问。
//远程代理：控制访问远程对象
//保护代理：基于权限的资源访问
//虚拟代理：控制访问创建开销大的资源


//===虚拟代理=======
//给大对象创建替身，以图片的占位图为例

protocol ImageType {
    func imageLoad()
}


class BigImage: ImageType {
    func imageLoad() {
        print("大图片")
    }
}

class SmallImage: ImageType {
    func imageLoad() {
        print("小占位图片")
    }
}


//图片虚拟代理
class BigImageProxy: ImageType {
    var bigImage: ImageType? = nil
    var bigImageNoInit: Bool = true
    var smallImage: ImageType = SmallImage()
    
    func imageLoad() {
        if bigImage != nil {
            bigImage?.imageLoad()
        } else {
            smallImage.imageLoad()
            
            if bigImageNoInit {
                self.bigImage = BigImage() //模拟长时间的初始化
                bigImageNoInit = false
            }
            
        }
    }
}

class ImageClient {
    var image: ImageType?
    
    func setImage(image: ImageType) -> Void {
        self.image = image
    }
    
    func imageLoad() {
        image?.imageLoad()
    }
}

let imageClient = ImageClient()
imageClient.setImage(BigImageProxy())
imageClient.imageLoad()
imageClient.imageLoad()

