import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:learn_bluetooth/models/failure_model.dart';

abstract class ConnectedDevicesState {}

class LoadingState extends ConnectedDevicesState {}

class ConnectedDevicesLoadedState extends ConnectedDevicesState {
  final List<BluetoothDevice> connectedDevices;

  ConnectedDevicesLoadedState({required this.connectedDevices});
}

class ErrorState extends ConnectedDevicesState {
  final FailureModel failData;

  ErrorState({required this.failData});
}
