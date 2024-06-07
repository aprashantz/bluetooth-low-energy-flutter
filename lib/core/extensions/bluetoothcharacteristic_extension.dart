import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:learn_bluetooth/core/utils/bluetooth_utils.dart';

extension BluetoothCharacteristicExtension on BluetoothCharacteristic {
  String getName() {
    String unknownName = "Unknown Char Name";
    try {
      Map<String, dynamic> charData = BluetoothUtils.getBluetoothChar(uuid.str);
      return charData['name'];
    } catch (e) {
      debugPrint("Error getting char name: ${e.toString()}");
      return unknownName;
    }
  }

  String getIdentifier() {
    String unknownIdentifier = "Unknown Identifier";
    try {
      Map<String, dynamic> charData = BluetoothUtils.getBluetoothChar(uuid.str);
      return charData['identifier'];
    } catch (e) {
      debugPrint("Error getting identifier name: ${e.toString()}");
      return unknownIdentifier;
    }
  }
}
