import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_bluetooth/business_logic/bluetooth_on_off_cubit/bluetooth_on_off_cubit.dart';
import 'package:learn_bluetooth/business_logic/bluetooth_on_off_cubit/bluetooth_on_off_state.dart';
import 'package:learn_bluetooth/business_logic/connected_devices_cubit/connected_devices_cubit.dart';
import 'package:learn_bluetooth/business_logic/connected_devices_cubit/connected_devices_state.dart'
    as connectedDevicesState;
import 'package:learn_bluetooth/business_logic/scan_devices_cubit/scan_devices_cubit.dart';
import 'package:learn_bluetooth/widgets/list_of_connected_devices_widget.dart';

class ConnectedDevicesScreen extends StatefulWidget {
  const ConnectedDevicesScreen({super.key});

  @override
  State<ConnectedDevicesScreen> createState() => _ConnectedDevicesScreenState();
}

class _ConnectedDevicesScreenState extends State<ConnectedDevicesScreen> {
  @override
  void initState() {
    BlocProvider.of<ConnectedDevicesCubit>(context).fetchConnectedDevices();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          SafeArea(child: BlocBuilder<BluetoothOnOffCubit, BluetoothOnOffState>(
        builder: (context, onOffState) {
          if (onOffState is BluetoothOnState) {
            return BlocBuilder<ConnectedDevicesCubit,
                connectedDevicesState.ConnectedDevicesState>(
              builder: (context, state) {
                if (state
                    is connectedDevicesState.ConnectedDevicesLoadedState) {
                  return RefreshIndicator(
                    onRefresh: () async => scanDevices(context),
                    child: ListOfConnectedDevicesWidget(
                        connectedDevices: state.connectedDevices),
                  );
                } else if (state is connectedDevicesState.LoadingState) {
                  return const Center(child: CircularProgressIndicator());
                }
                return const SizedBox();
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
      )),
    );
  }

  void scanDevices(BuildContext context) {
    BlocProvider.of<ScanDevicesCubit>(context).scanDevices();
    BlocProvider.of<ConnectedDevicesCubit>(context).fetchConnectedDevices();
  }
}
