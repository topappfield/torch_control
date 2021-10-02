# torch_control

A Flutter plugin for torch/flashlight/lamp control. Includes support for Android (4 and 5+) and iOS.

## Install

Add  `torch_control: 0.1.0` to your pubspec.yaml file

## Usage

To check if a torch is available:

    bool hasTorch = TorchControl.hasTorch();

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

* In the beginning the torch state is initialized to off. To ensure correctness
    you should call `TorchControl.turnOff()`.

## Trivia

Why yet another torch plugin? I needed support for null safety, Dart 2, and a bit more
flexible interface. Moreover, I've never written a Flutter plugin as well as Kotlin code before.
