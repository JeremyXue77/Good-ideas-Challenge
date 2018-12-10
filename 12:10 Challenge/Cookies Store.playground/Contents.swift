
import Foundation

enum ProductSize: Int {
    case small = 10
    case big = 20
    case large = 30
    case none = 0
}

class Store {
    var orders = [Product]()
    var priceList = [Int]()
    func getOrders(orders: [Int]) {
        orders.forEach { (amount) in
            let product = Product(amount: amount)
            self.orders.append(product)
        }
    }
    
    func getPriceDetail() {
        var totalPrice = 0
        var priceList = [Int]()
        for order in orders {
            totalPrice += order.price
            priceList.append(order.price)
        }
        print("Price List:\(priceList), Total Price:\(totalPrice)")
    }
}

struct Product {
    var amount:Int
    var price:Int
    var size:ProductSize
    
    init(amount: Int) {
        self.amount = amount
        self.size = Product.checkSize(amount: amount)
        self.price = size.rawValue + amount * 10
        print("Amount:\(amount)，Price:\(price)")
    }
    
    static func checkSize(amount: Int) -> ProductSize {
        switch amount {
        case 1...5:
            return ProductSize.small
        case 6...10:
            return ProductSize.big
        case 11...15:
            return ProductSize.large
        default:
            return ProductSize.none
        }
    }
}

// Result
let orders = [1, 3, 7, 12]
let cookieStore = Store()
cookieStore.getOrders(orders: orders)
cookieStore.getPriceDetail()

