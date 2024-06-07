import 'package:flutter_blue_plus/flutter_blue_plus.dart';

abstract class PairDeviceState {}

class InitialState extends PairDeviceState {}

class PairingDeviceState extends PairDeviceState {
  final ScanResult device;

  PairingDeviceState({required this.device});
}

class PairedState extends PairDeviceState {
  final ScanResult device;

  PairedState({required this.device});
}

class PairFailState extends PairDeviceState {
  final ScanResult device;

  PairFailState({required this.device});
}
