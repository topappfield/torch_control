import 'dart:async';

import 'package:flutter/services.dart';

class TorchControl {
  static const MethodChannel _channel = MethodChannel('torch_control');

  static Future<bool> get hasTorch async =>
      await _channel.invokeMethod('hasTorch');

  static bool _isOn = false;

  static bool get isOn => _isOn;

  static bool get isOff => !_isOn;

  static Future<bool> turn(bool state) async {
    _isOn = await _channel.invokeMethod('turn', {'state': state});
    return _isOn;
  }

  static Future<bool> turnOn() async => turn(true);

  static Future<void> turnOff() async => turn(false);

  static Future<bool> toggle() async => turn(!isOn);

  static Future flash(Duration duration) =>
      turnOn().whenComplete(() => Future.delayed(duration, () => turnOff()));
}
