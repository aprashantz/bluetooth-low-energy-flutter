import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:learn_bluetooth/core/extensions/scanresult_extension.dart';

class ConnectedDeviceScreen extends StatefulWidget {
  final ScanResult device;
  const ConnectedDeviceScreen({super.key, required this.device});

  @override
  State<ConnectedDeviceScreen> createState() => _ConnectedDeviceScreenState();
}

class _ConnectedDeviceScreenState extends State<ConnectedDeviceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.device.getName()),
      ),
      body: Column(
        children: [Text(widget.device.toString())],
      ),
    );
  }
}
