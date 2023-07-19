// import Cocoa
// import FlutterMacOS
//
// public class FlutterLiblelantusPlugin: NSObject, FlutterPlugin {
//   public static func register(with registrar: FlutterPluginRegistrar) {
//     let channel = FlutterMethodChannel(name: "flutter_liblelantus", binaryMessenger: registrar.messenger)
//     let instance = FlutterLiblelantusPlugin()
//     registrar.addMethodCallDelegate(instance, channel: channel)
//   }
//
//   public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
//     switch call.method {
//     case "getPlatformVersion":
//       result("macOS " + ProcessInfo.processInfo.operatingSystemVersionString)
//     default:
//       result(FlutterMethodNotImplemented)
//     }
//   }
// }
