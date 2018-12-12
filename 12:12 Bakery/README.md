# 新手村 Code Level 3

## 描述

今天我們要打造一個城鎮的生態系。
在這個城鎮裡面會有 **Hospital, School, FireStation** 這三種機構。
還有一家非常有名的 **Bakery**.

這家 Bakery 每天都會發表一個每日特色並且通知到三個機構。
三個機構收到以後會大喊收到：

例子：「Hospital received Today’s Special」

* Stage - 1
  只需要使用 function 來實現。

* Stage - 2
  將所有機構都以 class 的方式呈現。

### Stage - 1 加強版

- 準備 10 個產品，每次通知都是隨機的「今日特色」
- 這 10 個商品需要 3 種分類。
- 大喊的內容變為「Hospital received today’s special `Fruit` Banana」

### Stage - 3

- 今天 DonStudio 進駐了我們的城市，他也想要收到「今日特色」的消息。
- 如何做到未來機構名單變動的情況下，也不用修改 class Bakery

---



## 實作

今天我將這個範例想像成一個訂閱系統，所有有訂閱的人會有一些訂閱跟退訂閱等等方法，因此使用 `Protocol` 方式來實現：

```swift
protocol Subscription {
    // 這邊定義一個 name 是為了回傳訊息需要店家名稱，若題目沒有需則不會定義
    var name: String {get}
    var barkerySubscriptionName: Notification.Name {get}
    var userInfoKey: String {get}
    func addObserver()
    func received(notification: Notification)
    // 這邊也新增了一個取消訂閱的方法
    func removeObserver()
}
```

這邊我們為了讓每個訂閱者實作的方法以及 `Notification.Name` 跟 `userInfo` 的`key` 都一樣，因此我們用 `Protocol Extension` 的方式來定義 `Subscription` 中的方法：

```swift
extension Subscription {
    
    var barkerySubscriptionName: Notification.Name {
        return Notification.Name("barkerySubscription")
    }
    var userInfoKey: String {
        return "message"
    }

    func addObserver() {
        NotificationCenter.default.addObserver(forName: barkerySubscriptionName, object: nil, queue: nil) { (notification) in
           // 收到消息則執行 received 方法                                                                                              
           self.received(notification: notification)
        }
    }
    
    func removeObserver() {
        NotificationCenter.default.removeObserver(self, name: barkerySubscriptionName, object: nil)
    }
    
    func received(notification: Notification) {
        if let message = notification.userInfo?[userInfoKey] as? String {
            print("\(name) received: \(message)")
        }
    }
}
```

當然我們也能綁訂一個 `Poster` 的 `Protocol` ，作為發送者的協定：

```swift
protocol Poster {
    var barkerySubscriptionName: Notification.Name {get}
    var userInfoKey: String {get}
    func sendTodaySpecial(item: String)
}
```

一樣 `extension` 實作 `Poster` 裡面的 function：

```swift
extension Poster {
    var barkerySubscriptionName: Notification.Name {
        return Notification.Name("barkerySubscription")
    }
    var userInfoKey: String {
        return "message"
    }
    func sendTodaySpecial(item: String) {
        NotificationCenter.default.post(name: barkerySubscriptionName, object: nil, userInfo: [userInfoKey: item])
        print("Bakery post message：\(item)")
    }
}
```

接著分別讓我們的訂閱者跟發送者遵循 `Poster` 跟 `Subscription` 這兩個 `protocol`：

```swift
// Subscriptions
class JeremyHospital:Subscription { var name = "Hospital" }
class JeremyFireStation: Subscription { var name = "FireStation" }
class JeremySchool: Subscription { var name = "School" }
class DonStudio: Subscription { var name = "Studio" }

// Posters
class JeremyBakery: Poster {}
class DonBakery: Poster {}
```

實例化訂閱者並且執行 `addObserver()` 加入監聽 `barkerySubscription`事件：

```swift
// MARK: Test
let hospital = JeremyHospital()
let fireStation = JeremyFireStation()
let school = JeremySchool()
let stuido = DonStudio()

// Add Observer
hospital.addObserver()
fireStation.addObserver()
school.addObserver()
stuido.addObserver()
```

實例化發送者發送通知：

```swift
let barkery = JeremyBakery()
barkery.sendTodaySpecial(item: "Banana")
let donBakery = DonBakery()
donBakery.sendTodaySpecial(item: "Apple")
```

