import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:learn_bluetooth/core/extensions/bluetoothservice_extension.dart';
import 'package:learn_bluetooth/widgets/char_detail_widget.dart';

class ServiceTileWidget extends StatelessWidget {
  final BluetoothService service;
  const ServiceTileWidget({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("ServiceName: ${service.getName()}"),
          Text("ServiceIdentifier: ${service.getIdentifier()}"),
          Text("ServiceUUID: ${service.uuid}"),
        ],
      ),
      subtitle: Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: service.characteristics.length,
            itemBuilder: (context, index) {
              BluetoothCharacteristic char = service.characteristics[index];
              return CharDetailWidget(char: char);
            },
          ),
          const Divider(),
        ],
      ),
      // trailing: Text("Services Count: ${service.includedServices.length}"),
      // leading: Text("Chars Count: ${service.characteristics.length}"),
      // subtitle: ListView.builder(
      //   shrinkWrap: true,
      //   physics: const NeverScrollableScrollPhysics(),
      //   itemCount: service.characteristics.length,
      //   itemBuilder: (context, index) {
      //     BluetoothCharacteristic char = service.characteristics[index];
      //     return Column(
      //       crossAxisAlignment: CrossAxisAlignment.start,
      //       children: [
      //         Text('Name: ${char.getName()}'),
      //         Text('Identifier: ${char.getIdentifier()}'),
      //       ],
      //     );
      //   },
      // ),
    );
  }
}
