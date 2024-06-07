import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:learn_bluetooth/models/failure_model.dart';
import 'bluetooth_on_off_state.dart';

class BluetoothOnOffCubit extends Cubit<BluetoothOnOffState> {
  BluetoothOnOffCubit() : super(LoadingState()) {
    checkBluetoothStatus();
  }

  void checkBluetoothStatus() async {
    emit(LoadingState());

    if (!await FlutterBluePlus.isSupported) {
      emit(BluetoothNotSupportedState(
          failData:
              FailureModel(msg: "Bluetooth is not supported in this device")));
      return;
    }
    FlutterBluePlus.adapterState.listen((BluetoothAdapterState state) {
      if (state == BluetoothAdapterState.on) {
        emit(BluetoothOnState());
      } else if (state == BluetoothAdapterState.off) {
        emit(BluetoothOffState());
      } else {
        emit(BluetoothNotSupportedState(
            failData: FailureModel(msg: "Bluetooth State: ${state.name}")));
        return;
      }
    });
  }
}
