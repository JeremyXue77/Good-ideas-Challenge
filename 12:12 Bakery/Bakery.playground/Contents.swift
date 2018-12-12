import UIKit

protocol Subscription {
    var barkerySubscriptionName: Notification.Name {get}
    var userInfoKey: String {get}
    func addObserver()
    func removeObserver()
    func received(notification: Notification)
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
            print("Hospital received: \(message)")
        }
    }
}

class JeremyHospital:Subscription {

}

class JeremyFireStation: Subscription {

}

class JeremySchool: Subscription {

}

class DonStudio: Subscription {
    
}

class JeremyBakery {
    private var barkerySubscriptionName = Notification.Name("barkerySubscription")
    private var userInfoKey = "message"
    
    func sendTodaySpecial(item: String) {
        NotificationCenter.default.post(name: barkerySubscriptionName, object: nil, userInfo: ["Message": item])
        print("Bakery post message：\(item)")
    }
}

let hospital = JeremyHospital()
hospital.addObserver()

let school = JeremySchool()
school.addObserver()

let fireStation = JeremyFireStation()
fireStation.addObserver()

let barkery = JeremyBakery()
barkery.sendTodaySpecial(item: "Banana")
