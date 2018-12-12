import UIKit

protocol Subscription {
    var barkerySubscription: Notification.Name {get}
    var userInfoKey: String {get}
    func addObserver()
    func removeObserver()
//    func cancelObserver()
//    func received(notification: Notification)
}

extension Subscription {
    var barkerySubscription: Notification.Name {
        return Notification.Name("barkerySubscription")
    }
    var userInfoKey: String {
        return "Message"
    }
    
    func removeObserver() {
        NotificationCenter.default.removeObserver(self, name: barkerySubscription, object: nil)
    }
}

class JeremyHospital:Subscription {
    
    func addObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(recived(notification:)), name: barkerySubscription, object: nil)
    }
    
    @objc func recived(notification: Notification) {
        if let message = notification.userInfo?[userInfoKey] as? String {
            print("Hospital received: \(message)")
        }
    }
}

class JeremyFireStation: Subscription {
    func addObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(recived(notification:)), name: barkerySubscription, object: nil)
    }
    
    @objc func recived(notification: Notification) {
        if let message = notification.userInfo?[userInfoKey] as? String {
            print("FireStation received: \(message)")
        }
    }
}

class JeremySchool: Subscription {
    func addObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(recived(notification:)), name: barkerySubscription, object: nil)
    }
    
    @objc func recived(notification: Notification) {
        if let message = notification.userInfo?[userInfoKey] as? String {
            print("School received: \(message)")
        }
    }
}

//

class JeremyBakery {
    private var barkerySubscription: Notification.Name {
        return Notification.Name("barkerySubscription")
    }
    
    private var userInfoKey: String {
        return "Message"
    }
    
    func sendTodaySpecial(item: String) {
        NotificationCenter.default.post(name: barkerySubscription, object: nil, userInfo: ["Message": item])
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
