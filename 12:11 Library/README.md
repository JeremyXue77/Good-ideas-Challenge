# 新手村 Code Level 1

## 今天為你自己開一個餅乾店。

### 餅乾店有三種產品：

|   產品類型   | 餅乾數量（片） | 包裝費 |
| :----------: | :------------: | :----: |
| SmallProduct |     1 ~ 5      |  $10   |
|  BigProduct  |      6~10      |  $20   |
| LargeProduct |     11~15      |  $30   |

> 一片餅乾的價格為 $10



#### 問題：

今天店裏收到一系列訂單：

`input orders = [1, 3, 7, 12]`

#### 需求：

請 `print` 出對應的價格：
`output prices  = [20, 50, 90, 150]`

---

## 實作規劃

定義一個 `enum` 來區分不同數量的物件：

```swift
enum ProductSize: Int {
    // 使用 rawValue 來當作包裝價格
    case small = 10
    case big = 20
    case large = 30
    case none = 0
}
```

這邊我以一個產品（餅乾）作為一個物件，並使用 `ProductSize`來區分三個不同產品：

```swift
struct Product {
    var amount:Int
    var price:Int
    var size:ProductSize
    
    // 初始化 Product
    init(amount: Int) {
        self.amount = amount
        // 根據 amount 回傳一個 ProductSize
        self.size = Product.checkSize(amount: amount)
        // 計算包裝價格(size.rawValue) + 餅乾總價 (amount * 10)
        self.price = size.rawValue + amount * 10
        print("Amount:\(amount)，Price:\(price)")
    }
    
    // 計算產品 Size
    static func checkSize(amount: Int) -> ProductSize {
        // 根據 amount 計算 ProductSize
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

```

最後我們創建一個商店的 `class`，並且在其中加入兩個方法：

* `getOrders(orders: [Int])` 用來獲取訂單，並將其轉換成 `Order` 物件存入 `orders`。
* `getPriceDetail()` 用來獲取每個訂單的價格以及總價格。

```swift
class Store {
    // 用來儲存轉換後的 Order 物件
    var orders = [Product]()
    
    // 獲取訂單
    func getOrders(orders: [Int]) {
        orders.forEach { (amount) in
            // 透過訂單的餅乾數量，初始化一個 Order 物件
            let product = Product(amount: amount)
            // 加入 orders            
            self.orders.append(product)
        }
    }
    
    // 獲取明細
    func getPriceDetail() {
        var totalPrice = 0
        var priceList = [Int]()
        // 輸出每筆訂單的價格到 priceList 以及計算總價
        for order in orders {
            totalPrice += order.price
            priceList.append(order.price)
        }
        // 印出明細
        print("Price List:\(priceList), Total Price:\(totalPrice)")
    }
}
```

