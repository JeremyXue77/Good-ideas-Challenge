import UIKit

protocol Subscription {
    var name: String {get}
    var barkerySubscriptionName: Notification.Name {get}
    var userInfoKey: String {get}
    func addObserver()
    func removeObserver()
    func received(notification: Notification)
}

protocol Poster {
    var barkerySubscriptionName: Notification.Name {get}
    var userInfoKey: String {get}
    func sendTodaySpecial(item: String)
}

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

extension Subscription {
    
    var barkerySubscriptionName: Notification.Name {
        return Notification.Name("barkerySubscription")
    }
    var userInfoKey: String {
        return "message"
    }

    func addObserver() {
        NotificationCenter.default.addObserver(forName: barkerySubscriptionName, object: nil, queue: nil) { (notification) in
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

// Subscriptions
class JeremyHospital:Subscription { var name = "Hospital" }
class JeremyFireStation: Subscription { var name = "FireStation" }
class JeremySchool: Subscription { var name = "School" }
class DonStudio: Subscription { var name = "Studio" }

// Posters
class JeremyBakery: Poster {}
class DonBakery: Poster {}

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

let barkery = JeremyBakery()
barkery.sendTodaySpecial(item: "Banana")
let donBakery = DonBakery()
donBakery.sendTodaySpecial(item: "Apple")
