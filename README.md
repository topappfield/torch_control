# torch_control

A Flutter plugin for torch/flashlight/lamp control. Includes support for Android (4 and 5+) and iOS.

## Install

Add  `torch_control: 0.1.0` to your pubspec.yaml file

Set permissions

    <uses-permission android:name="android.permission.CAMERA"/>
    <uses-permission android:name="android.permission.FLASHLIGHT"/>

    <uses-permission android:name="android.permission.CAMERA" />
    <uses-feature android:name="android.hardware.camera" />

## Usage

To check if a torch is available and ready to use:

    await TorchControl.ready();

To turn on and off the torch:

    TorchControl.turnOn();
    TorchControl.turnOff();
    TorchControl.turn(true);
    TorchControl.turn(false);

To toggle the torch:

    TorchControl.toggle();        // if is on it is turned off an vice versa

To check the torch state:

    TorchControl.isOn();
    TorchControl.isOff();

* In the beginning the torch state is initialized to off. To ensure correctness of the on/off status
    you should call `TorchControl.turnOff()` (or `TorchControl.turnOn()`) somewhere at the beginning.

To flash the torch for a given duration:

    TorchControl.flash(const Duration(seconds: 1));

## Trivia

Why yet another torch plugin? I needed support for null safety, Dart 2, and a bit more
flexible interface. Moreover, I've never written a Flutter plugin as well as Kotlin code before.
