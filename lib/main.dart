import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_bluetooth/business_logic/discover_services_cubit/discover_services_cubit.dart';
import 'package:learn_bluetooth/business_logic/pair_device_cubit/pair_device_cubit.dart';
import 'package:learn_bluetooth/business_logic/scan_devices_cubit/scan_devices_cubit.dart';
import 'business_logic/bluetooth_on_off_cubit/bluetooth_on_off_cubit.dart';
import 'business_logic/connected_devices_cubit/connected_devices_cubit.dart';
import 'core/routes/route_generator.dart';

void main() {
  runApp(MultiBlocProvider(
      providers: [
        BlocProvider(create: ((context) => BluetoothOnOffCubit())),
        BlocProvider(create: ((context) => ScanDevicesCubit())),
        BlocProvider(create: ((context) => ConnectedDevicesCubit())),
        BlocProvider(create: ((context) => PairDeviceCubit())),
        BlocProvider(create: ((context) => DiscoverServicesCubit())),
      ],
      child: const MaterialApp(
        onGenerateRoute: onGenerateRoute,
      )));
}
