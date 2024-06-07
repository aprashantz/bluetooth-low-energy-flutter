import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:learn_bluetooth/core/utils/clear_focus.dart';
import 'package:learn_bluetooth/widgets/service_tile.dart';

class ListOfServicesWidget extends StatelessWidget {
  final List<BluetoothService> services;
  const ListOfServicesWidget({super.key, required this.services});

  @override
  Widget build(BuildContext context) {
    return services.isEmpty
        ? const Center(child: Text("No services were found at the moment."))
        : Listener(
            onPointerDown: (event) {
              clearFocus();
            },
            onPointerUp: (event) {
              clearFocus();
            },
            child: GestureDetector(
              onTap: () => clearFocus(),
              child: ListView.builder(
                itemCount: services.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  BluetoothService service = services[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: ServiceTileWidget(service: service),
                  );
                },
              ),
            ),
          );
  }
}
