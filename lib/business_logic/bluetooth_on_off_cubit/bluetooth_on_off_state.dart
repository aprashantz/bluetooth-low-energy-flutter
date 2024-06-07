import 'package:learn_bluetooth/models/failure_model.dart';

abstract class BluetoothOnOffState {}

class LoadingState extends BluetoothOnOffState {}

class BluetoothOnState extends BluetoothOnOffState {}

class BluetoothOffState extends BluetoothOnOffState {}

class BluetoothNotSupportedState extends BluetoothOnOffState {
  final FailureModel failData;

  BluetoothNotSupportedState({required this.failData});
}
