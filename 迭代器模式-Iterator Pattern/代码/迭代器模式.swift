//迭代器模式：提供一种方法顺序访问一个聚合对象中的每个元素，而又不暴漏其内部的表示。
protocol Iterator {
    func hasNext() -> Bool
    func next() -> AnyObject?
}

class ArrayIterator: Iterator {
    private let items: Array<AnyObject>
    private var position: Int = 0
    
    init(items: Array<AnyObject>) {
        self.items = items
    }
    
    func hasNext() -> Bool {
        return position < items.count
    }
    
    func next() -> AnyObject? {
        let item = items[position]
        position += 1
        return item
    }
}

class DictionaryIterator: Iterator {
    
    private let items: Dictionary<String, AnyObject>
    private var position: Int = 0
    private var allKeys: [String] {
        get{
            return Array(items.keys)
        }
    }
    
    init(items: Dictionary<String, AnyObject>) {
        self.items = items
    }
    
    func hasNext() -> Bool {
        return position < items.count
    }
    
    func next() -> AnyObject? {
        let item = items[allKeys[position]]
        position += 1
        return item
    }
}




protocol CinemaType {
    func createIterator() -> Iterator
    func iteratorItem()
}

extension CinemaType {
    func iteratorItem() {
        let iterator = createIterator()
        while iterator.hasNext() {
            guard let item = iterator.next() else {
                continue
            }
            print(item)
        }
    }
}


class Cinema01: CinemaType {
    let items = ["美人鱼", "夏洛特烦恼", "末日崩塌"]
    func createIterator() -> Iterator {
        return ArrayIterator(items: items)
    }
}

class Cinema02: CinemaType {
    let items = ["001": "老炮儿", "002": "疯狂动物城", "003": "泰囧"]
    func createIterator() -> Iterator {
        return DictionaryIterator(items: items)
    }
}

class Market {
    private var cinemas: Array<CinemaType> = Array<CinemaType>()
    
    func addCinema(cinema: CinemaType) {
        self.cinemas.append(cinema)
    }
    
    func display() {
        for i in 0..<cinemas.count {
            cinemas[i].iteratorItem()
        }
    }
    
}

let market = Market()
market.addCinema(Cinema01())
market.addCinema(Cinema02())
market.display()
