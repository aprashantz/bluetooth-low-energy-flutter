import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:learn_bluetooth/models/failure_model.dart';

abstract class DiscoverServiceState {}

class InitialState extends DiscoverServiceState {}

class ServicesLoadedState extends DiscoverServiceState {
  final List<BluetoothService> services;

  ServicesLoadedState({required this.services});
}

class ErrorLoadingServiceState extends DiscoverServiceState {
  final FailureModel errorData;

  ErrorLoadingServiceState({required this.errorData});
}
