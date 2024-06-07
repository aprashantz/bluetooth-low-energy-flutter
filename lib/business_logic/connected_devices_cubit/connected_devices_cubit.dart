import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:learn_bluetooth/business_logic/connected_devices_cubit/connected_devices_state.dart';

class ConnectedDevicesCubit extends Cubit<ConnectedDevicesState> {
  ConnectedDevicesCubit() : super(LoadingState());

  void fetchConnectedDevices() async {
    emit(LoadingState());

    List<BluetoothDevice> connectedAppDevices =
        FlutterBluePlus.connectedDevices;
    List<BluetoothDevice> connectedSystemDevices =
        await FlutterBluePlus.systemDevices;
    List<BluetoothDevice> allDevices =
        connectedAppDevices + connectedSystemDevices;

    emit(ConnectedDevicesLoadedState(connectedDevices: allDevices));
  }
}
