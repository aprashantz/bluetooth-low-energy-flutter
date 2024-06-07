import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:learn_bluetooth/business_logic/scan_devices_cubit/scan_devices_state.dart';
import 'package:learn_bluetooth/models/failure_model.dart';

class ScanDevicesCubit extends Cubit<ScanDevicesState> {
  ScanDevicesCubit() : super(InitialState());

  void scanDevices() async {
    emit(ScanningState());

    await FlutterBluePlus.startScan();

    FlutterBluePlus.onScanResults.listen((List<ScanResult> results) {
      emit(ScanSuccessState(
          scannedDevices: getDevicesWithManufactorerData(results)));
    }, onDone: () {
      debugPrint("Scan Done");
    }, onError: (e) {
      emit(ScanFailState(failData: FailureModel(msg: "Failed to Scan")));
    });
  }

  List<ScanResult> getDevicesWithManufactorerData(List<ScanResult> results) {
    List<ScanResult> devicesWithName = [];
    for (ScanResult result in results) {
      // if (result.advertisementData.manufacturerData.isNotEmpty) {
      devicesWithName.add(result);
      // }
    }
    // Sort devicesWithName based on RSSI in descending order
    devicesWithName.sort((a, b) => b.rssi.compareTo(a.rssi));
    return devicesWithName;
  }
}
