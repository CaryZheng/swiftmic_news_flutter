import Flutter
import UIKit
import SwiftyJSON

public class SwiftMyHelloPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "my_hello", binaryMessenger: registrar.messenger())
    let instance = SwiftMyHelloPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    let jsonStr = """
        {
            "name": "Tony",
            "age": 18
        }
    """
    
    var name = "Unknown"
    
    do {
        let json = try JSON(data: jsonStr.data(using: .utf8)!)
        name = json["name"].stringValue
    } catch {
        print("error = \(error)")
    }
    
    
    result("name = \(name), call.method: \(call.method), iOS : " + UIDevice.current.systemVersion)
  }
}
