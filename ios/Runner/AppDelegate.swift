import UIKit
import Flutter
// import BluetoothHelper
import AVFoundation

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    //     let controller: FlutterViewController = window?.rootViewController as! FlutterViewController
    //     let CHANNEL = "com.example.learnBluetooth"

    //     let bluetoothHelper = BluetoothHelper()

    //     let methodChannel = FlutterMethodChannel(name: CHANNEL, binaryMessenger: controller.binaryMessenger)
    // methodChannel.setMethodCallHandler { (call: FlutterMethodCall, result: FlutterResult) in
    //   if call.method == "connectToAudioDevice" {
    //     if let args = call.arguments as? Dictionary<String, Any>,
    //        let deviceId = args["deviceId"] as? String {
    //       bluetoothHelper.connectToAudioDevice(deviceId: deviceId)
    //       result(nil)
    //     } else {
    //       result(FlutterError(code: "INVALID_ARGUMENT", message: "Invalid argument", details: nil))
    //     }
    //   } else {
    //     result(FlutterMethodNotImplemented)
    //   }
    // }


    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
