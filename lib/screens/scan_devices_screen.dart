import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_bluetooth/business_logic/bluetooth_on_off_cubit/bluetooth_on_off_cubit.dart';
import 'package:learn_bluetooth/business_logic/bluetooth_on_off_cubit/bluetooth_on_off_state.dart';
import 'package:learn_bluetooth/business_logic/connected_devices_cubit/connected_devices_cubit.dart';
import 'package:learn_bluetooth/business_logic/scan_devices_cubit/scan_devices_cubit.dart';
import 'package:learn_bluetooth/business_logic/scan_devices_cubit/scan_devices_state.dart';
import 'package:learn_bluetooth/widgets/list_of_scanned_devices_widget.dart';

class ScanDevicesScreen extends StatelessWidget {
  const ScanDevicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<BluetoothOnOffCubit, BluetoothOnOffState>(
          builder: (context, onOffState) {
            if (onOffState is BluetoothOnState) {
              return BlocBuilder<ScanDevicesCubit, ScanDevicesState>(
                builder: (context, state) {
                  return RefreshIndicator(
                    onRefresh: () async => scanDevices(context),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          color: Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Center(
                                child: Text(
                                  "${state.getTitle()}${state is ScanSuccessState ? ": ${state.scannedDevices.length}" : ""}",
                                ),
                              ),
                              if (state is ScanSuccessState ||
                                  state is ScanFailState)
                                ElevatedButton(
                                    onPressed: () {
                                      scanDevices(context);
                                    },
                                    child: const Text("Scan Again"))
                            ],
                          ),
                        ),
                        if (state is InitialState)
                          ElevatedButton(
                              onPressed: () {
                                scanDevices(context);
                              },
                              child: const Text("Scan Devices"))
                        else if (state is ScanningState)
                          const Center(child: CircularProgressIndicator())
                        else if (state is ScanSuccessState)
                          Expanded(
                            child: ListOfScannedDevicesWidget(
                                connectedDevices: state.scannedDevices),
                          )
                        else if (state is ScanFailState)
                          Text(state.failData.msg)
                      ],
                    ),
                  );
                },
              );
            } else if (onOffState is BluetoothOffState) {
              return const Center(
                child: Text("Bluetooth is turned off"),
              );
            } else if (onOffState is BluetoothNotSupportedState) {
              return Center(
                child: Text(onOffState.failData.msg),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

  void scanDevices(BuildContext context) {
    BlocProvider.of<ScanDevicesCubit>(context).scanDevices();
    BlocProvider.of<ConnectedDevicesCubit>(context).fetchConnectedDevices();
  }
}
