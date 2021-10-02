import 'package:flutter/material.dart';

import 'package:torch_control/torch_control.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool hasTorch = false;
  bool isOn = true;
  bool isOff = true;

  @override
  void initState() {
    super.initState();
    checkState();
  }

  void checkState() async {
    hasTorch = await TorchControl.hasTorch;
    setState(() {
      isOn = TorchControl.isOn;
      isOff = TorchControl.isOff;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            children: [
              Text('hasTorch: $hasTorch\n'),
              Text('isOn: $isOn\n'),
              Text('isOff: $isOff\n'),
              TextButton(
                  onPressed: () {
                    TorchControl.turnOn();
                    checkState();
                  },
                  child: const Text('On')),
              TextButton(
                  onPressed: () {
                    TorchControl.turnOff();
                    checkState();
                  },
                  child: const Text('Off')),
              TextButton(
                  onPressed: () {
                    TorchControl.toggle();
                    checkState();
                  },
                  child: const Text('Toggle')),
              TextButton(
                  onPressed: () {
                    TorchControl.flash(const Duration(seconds: 1));
                    checkState();
                  },
                  child: const Text('Flash')),
            ],
          ),
        ),
      ),
    );
  }
}
