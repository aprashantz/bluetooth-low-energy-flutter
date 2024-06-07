import 'package:flutter/material.dart';
import 'package:learn_bluetooth/core/utils/bluetooth_companies.dart';

import 'bluetooth_characteristics_uuids.dart';
import 'bluetooth_services_uuids.dart';

class BluetoothUtils {
  static String getNameFromManufacturerData(
      Map<int, List<int>> manufacturerData) {
    String unknownDevice = "Unknown Device";
    try {
      List<Map<String, dynamic>> companies = listOfCompanies;
      for (Map<String, dynamic> company in companies) {
        int companyNumber = company['code'];
        int? numberInDevice = manufacturerData.keys.toList().first;
        if (numberInDevice == companyNumber) {
          return company['name'];
        }
      }
      return unknownDevice;
    } catch (e) {
      debugPrint("Error getting manufacturer data: $manufacturerData");
      return unknownDevice;
    }
  }

  static Map<String, dynamic> getBluetoothChar(String uuid) {
    List<Map<String, dynamic>> bluetoothChars = listOfBluetoothCharacteristics;
    Map<String, dynamic> charData = {};
    for (Map<String, dynamic> eachChar in bluetoothChars) {
      if (uuid.toLowerCase() == eachChar['uuid'].toLowerCase()) {
        return eachChar;
      }
    }
    return charData;
  }

  static Map<String, dynamic> getBluetoothService(String uuid) {
    List<Map<String, dynamic>> bluetoothServices = listOfBluetoothServices;
    Map<String, dynamic> charData = {};
    for (Map<String, dynamic> eachChar in bluetoothServices) {
      if (uuid.toLowerCase() == eachChar['uuid'].toLowerCase()) {
        return eachChar;
      }
    }
    return charData;
  }
}
