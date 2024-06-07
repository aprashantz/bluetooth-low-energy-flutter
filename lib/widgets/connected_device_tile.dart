import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:learn_bluetooth/core/routes/app_routes.dart';

class ConnectedDeviceTileWidget extends StatelessWidget {
  final BluetoothDevice device;
  const ConnectedDeviceTileWidget({super.key, required this.device});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(device.remoteId.str),
      subtitle: ElevatedButton(
          onPressed: () {
            Navigator.of(context)
                .pushNamed(AppRoutes.viewServicesScreen, arguments: device);
          },
          child: const Text("View Services")),
    );
  }
}
