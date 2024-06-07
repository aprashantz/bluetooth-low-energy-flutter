import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:learn_bluetooth/business_logic/discover_services_cubit/discover_services_state.dart';
import 'package:learn_bluetooth/core/extensions/bluetoothcharacteristic_extension.dart';
import 'package:learn_bluetooth/core/utils/bluetooth_utils.dart';

class MsgAndCharModel {
  final String msg;
  final String char;

  MsgAndCharModel({required this.msg, required this.char});
}

class DiscoverServicesCubit extends Cubit<DiscoverServiceState> {
  DiscoverServicesCubit() : super(InitialState());

  ValueNotifier<List<MsgAndCharModel>> receivedMessagesFromBLE =
      ValueNotifier<List<MsgAndCharModel>>([]);

  void clearMessages() {
    receivedMessagesFromBLE.value = [];
  }

  void addMsgFromNotif(MsgAndCharModel msgAndChar) {
    List<MsgAndCharModel> msgsTillNow = receivedMessagesFromBLE.value;
    msgsTillNow.add(msgAndChar);
    receivedMessagesFromBLE.value = msgsTillNow;
  }

  void discoverServices(BluetoothDevice device) async {
    emit(InitialState());

    try {
      List<BluetoothService> services = await device.discoverServices();

      // listen for notifications from all the characteristics of all services
      for (BluetoothService service in services) {
        for (BluetoothCharacteristic characteristic
            in service.characteristics) {
          try {
            if (characteristic.properties.write ||
                characteristic.properties.read) {
              await characteristic.setNotifyValue(true);

              characteristic.lastValueStream.listen((event) {
                String notifInString = String.fromCharCodes(event);
                debugPrint("debugBluetoothNotification*************");
                debugPrint(
                    "debugBluetoothNotification: charName: ${BluetoothUtils.getBluetoothChar(characteristic.characteristicUuid.str)}");
                addMsgFromNotif(MsgAndCharModel(
                    msg: notifInString, char: characteristic.getName()));
                debugPrint(
                    "debugBluetoothNotification: stringNotif: $notifInString");
                debugPrint(
                    "debugBluetoothNotification: jsonNotif: ${jsonDecode(notifInString)}");
                debugPrint("debugBluetoothNotification*************");
              });
            }
          } catch (e) {
            debugPrint(
                "debugBluetoothNotification: error in char loop: ${e.toString()}");
          }
        }
      }
      emit(ServicesLoadedState(services: services));
    } catch (e) {
      debugPrint("debugBluetoothNotification: error: ${e.toString()}");
      // emit(
      //     ErrorLoadingServiceState(errorData: FailureModel(msg: e.toString())));
    }
  }
}
