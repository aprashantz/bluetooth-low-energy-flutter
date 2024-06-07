import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:learn_bluetooth/core/utils/bluetooth_utils.dart';

extension ScanResultExtension on ScanResult {
  String getName() {
    return advertisementData.advName.isNotEmpty
        ? advertisementData.advName
        : device.platformName.isNotEmpty
            ? device.platformName
            : BluetoothUtils.getNameFromManufacturerData(
                advertisementData.manufacturerData);
  }
}
