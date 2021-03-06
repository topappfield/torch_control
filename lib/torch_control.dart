import 'dart:async';

import 'package:flutter/services.dart';

class TorchControl {
  static const MethodChannel _channel = MethodChannel('torch_control');

  /// Is the flashlight available?
  static Future<bool> ready() async {
    return await _channel.invokeMethod('ready');
  }

  static bool _isOn = false;

  /// Is the flashlight on?
  static bool get isOn => _isOn;

  /// Is the flashlight off?
  static bool get isOff => !_isOn;

  /// Turn the flashlight on or off.
  static Future<bool> turn(bool state) async {
    _isOn = await _channel.invokeMethod('turn', {'state': state});
    return _isOn;
  }

  /// Turn the flashlight on.
  static Future<bool> turnOn() async => turn(true);

  /// Turn the flashlight off.
  static Future<bool> turnOff() async => turn(false);

  /// Toggle the flashlight (on goes to off and vice versa).
  static Future<bool> toggle() async => turn(!isOn);

  /// Flash the flashlight for the specified duration.
  static Future<void> flash(Duration duration) =>
      turnOn().whenComplete(() => Future.delayed(duration, turnOff));
}
