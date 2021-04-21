import Flutter
import UIKit

public class SwiftMyHelloPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "my_hello", binaryMessenger: registrar.messenger())
    let instance = SwiftMyHelloPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result("call.method: \(call.method), iOS : " + UIDevice.current.systemVersion)
  }
}
