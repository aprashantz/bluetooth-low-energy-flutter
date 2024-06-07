import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:learn_bluetooth/business_logic/bluetooth_on_off_cubit/bluetooth_on_off_cubit.dart';
import 'package:learn_bluetooth/business_logic/bluetooth_on_off_cubit/bluetooth_on_off_state.dart';

class BluetoothToggleWidget extends StatelessWidget {
  const BluetoothToggleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BluetoothOnOffCubit, BluetoothOnOffState>(
      builder: (context, state) {
        if (state is BluetoothOffState || state is BluetoothOnState) {
          return CupertinoSwitch(
            value: state is BluetoothOffState ? false : true,
            onChanged: (makeOn) async {
              if (Platform.isAndroid) {
                makeOn ? FlutterBluePlus.turnOn() : FlutterBluePlus.turnOff();
              } else {
                showDialog(
                  context: context,
                  builder: (context) {
                    return const AlertDialog(
                      title: Text(
                          "In iOS, On/Off cannot be performed from the app itself."),
                    );
                  },
                );
              }
            },
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
