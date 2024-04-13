import UIKit
import Flutter
import FirebaseCore
import FirebaseMessaging

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    FirebaseApp.configure()
    GeneratedPluginRegistrant.register(with: self)
    requestPermission()
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}

func requestPermission() -> Void {
let notificationsCenter = UNUserNotificationCenter.current()
notificationsCenter.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
if let error = error {
print("error while requesting permission: \(error.localizedDescription)")
}
if granted {
print("permission granted")
} else {
print("permission denied")
}
}
}
