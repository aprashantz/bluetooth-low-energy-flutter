import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:learn_bluetooth/business_logic/pair_device_cubit/pair_device_state.dart';

class PairDeviceCubit extends Cubit<PairDeviceState> {
  PairDeviceCubit() : super(InitialState());

  void tryConnect(ScanResult device) async {
    emit(PairingDeviceState(device: device));

    device.device.connectionState
        .listen((BluetoothConnectionState state) async {
      if (state == BluetoothConnectionState.disconnected) {
        await device.device.connect();

        if (device.device.isConnected) {
          emit(PairedState(device: device));
        } else {
          emit(PairFailState(device: device));
        }
      } else if (state == BluetoothConnectionState.connected) {
        emit(PairedState(device: device));
      }
    });
  }
}
