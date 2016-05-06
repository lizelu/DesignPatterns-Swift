protocol CinemaType01 {
    func display()
}

class Cinema01: CinemaType01 {
    private let items = ["美人鱼", "夏洛特烦恼", "末日崩塌"]
    func display() {
        print("\n第一电影院：")
        for i in 0..<items.count {
            print(items[i])
        }
    }
}

class Cinema02: CinemaType01 {
    private let items = ["001": "老炮儿", "002": "疯狂动物城", "003": "泰囧"]
    func display() {
        print("\n第二电影院：")
        let allKeys = Array(items.keys)
        for i in 0..<allKeys.count {
            
            guard let item = items[allKeys[i]] else {
                continue
            }
            
            print(item)
        }
    }
}

class Market {
    private var cinemas: Array<CinemaType01> = Array<CinemaType01>()

    func addCinema(cinema: CinemaType01) {
        self.cinemas.append(cinema)
    }

    func display() {
        for  i in 0..<cinemas.count {
            let cinema = cinemas[i]
            cinema.display()
        }
    }

}

let market = Market()
market.addCinema(Cinema01())
market.addCinema(Cinema02())
market.display()

