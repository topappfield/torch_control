import Flutter
import UIKit
import AVFoundation

public class SwiftTorchControlPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "torch_control", binaryMessenger: registrar.messenger())
        let instance = SwiftTorchControlPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if (call.method == "turn") {
            let state = call.arguments("state") ?: false
            result.success( turn(state) )
        } else if (call.method == "hasTorch")
            result( hasTorch() )
        else
            result(FlutterMethodNotImplemented)
    }

    func hasTorch() -> Bool {
        guard let device = AVCaptureDevice.default(for: .video) else { return false }
        return device.hasFlash && device.hasTorch
    }

    func turn(state: Bool) -> Bool {
        guard hasTorch() else { return false }
        try! device.lockForConfiguration()
        device.torchMode = state ? .on : .off
        device.unlockForConfiguration()
        return state
    }
}
