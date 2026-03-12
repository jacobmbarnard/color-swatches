import UIKit
import CoreData
import OSLog

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Seed initial data if the store is empty
        DataSeeder.seedDataIfNeeded()
        return true
    }
}
