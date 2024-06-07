import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:learn_bluetooth/core/utils/bluetooth_utils.dart';

extension BluetoothServiceExtension on BluetoothService {
  String getName() {
    String unknownName = "Unknown Service Name";
    try {
      Map<String, dynamic> charData = BluetoothUtils.getBluetoothChar(uuid.str);
      return charData['name'];
    } catch (e) {
      debugPrint("Error getting service name: ${e.toString()}");
      return unknownName;
    }
  }

  String getIdentifier() {
    String unknownIdentifier = "Unknown Service Identifier";
    try {
      Map<String, dynamic> charData =
          BluetoothUtils.getBluetoothService(uuid.str);
      return charData['identifier'];
    } catch (e) {
      debugPrint("Error getting service identifier name: ${e.toString()}");
      return unknownIdentifier;
    }
  }
}
