import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    // Register the Flutter plugins
    GeneratedPluginRegistrant.register(with: self)

    // Set up the MethodChannel
    if let controller = window?.rootViewController as? FlutterViewController {
      let channel = FlutterMethodChannel(name: "cash.etisalat.dev",
                                         binaryMessenger: controller.binaryMessenger)
      channel.setMethodCallHandler { (call: FlutterMethodCall, result: @escaping FlutterResult) in
        if call.method == "sendEvent" {
          // Handle the "sendEvent" method call here
          self.handleSendEvent(call: call, result: result)
        } else {
          result(FlutterMethodNotImplemented)
        }
      }
    }

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  private func handleSendEvent(call: FlutterMethodCall, result: @escaping FlutterResult) {
    // Implement your event handling logic here
    result("Event sent") // Example response
  }
}
