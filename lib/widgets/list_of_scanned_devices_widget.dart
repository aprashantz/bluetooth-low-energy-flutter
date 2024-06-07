import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:learn_bluetooth/widgets/available_device_tile.dart';

class ListOfScannedDevicesWidget extends StatelessWidget {
  final List<ScanResult> connectedDevices;
  const ListOfScannedDevicesWidget({super.key, required this.connectedDevices});

  @override
  Widget build(BuildContext context) {
    return connectedDevices.isEmpty
        ? const Center(child: Text("No devices were found at the moment."))
        : ListView.builder(
            itemCount: connectedDevices.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child:
                    AvailableDeviceTileWidget(device: connectedDevices[index]),
              );
            },
          );
  }
}
