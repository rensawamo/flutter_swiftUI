import Flutter
import UIKit

public class NativesamplePlugin: NSObject, FlutterPlugin {
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "nativesample", binaryMessenger: registrar.messenger())
        let instance = NativesamplePlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
        
        // Pigeonによって生成されたMessagesImplを設定
        let messenger = registrar.messenger()
        
        if #available(iOS 13.0, *) {
            SwiftApiClassSetup.setUp(binaryMessenger: messenger, api: MessagesImpl())
        } else {
            print("iOS 13.0未満のデバイスではMessagesImplはサポートされていません。")
        }
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "getPlatformVersion":
            result("iOS " + UIDevice.current.systemVersion)
        default:
            result(FlutterMethodNotImplemented)
        }
    }
}



