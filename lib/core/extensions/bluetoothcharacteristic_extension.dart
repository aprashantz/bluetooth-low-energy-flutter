import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:learn_bluetooth/core/utils/bluetooth_utils.dart';

extension SplitWrite on BluetoothCharacteristic {
  Future<void> splitWrite(List<int> value,
      {int timeout = 15, bool withoutResponse = true}) async {
    int chunk = device.mtuNow - 3; // 3 bytes ble overhead
    for (int i = 0; i < value.length; i += chunk) {
      List<int> subvalue = value.sublist(i, min(i + chunk, value.length));
      await write(subvalue, withoutResponse: withoutResponse, timeout: timeout);
    }
  }
}

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
