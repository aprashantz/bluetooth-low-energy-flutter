import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:learn_bluetooth/business_logic/pair_device_cubit/pair_device_cubit.dart';
import 'package:learn_bluetooth/business_logic/pair_device_cubit/pair_device_state.dart';
import 'package:learn_bluetooth/core/extensions/scanresult_extension.dart';
import 'package:learn_bluetooth/core/routes/app_routes.dart';
import 'package:learn_bluetooth/core/utils/interpolation_utils.dart';
import 'package:learn_bluetooth/models/color_range_model.dart';

class AvailableDeviceTileWidget extends StatelessWidget {
  final ScanResult device;
  const AvailableDeviceTileWidget({super.key, required this.device});

  @override
  Widget build(BuildContext context) {
    bool canConnect = device.advertisementData.connectable;
    return ListTile(
      tileColor: InterpolationUtils.getInterpolatedColor(
          value: device.rssi,
          colorRange: ColorRangeModel(
              firstColor: const Color(0xFFF46666),
              midColor: const Color(0xFFF2CB44),
              lastColor: const Color(0xFF3BDE86))),
      // leading: Text("Id: ${device.}"),
      title: Text("${device.getName()} RSSI: ${device.rssi}"),
      subtitle: ElevatedButton(
        onPressed: () async {
          if (!canConnect) {
            Navigator.of(context)
                .pushNamed(AppRoutes.connectedDeviceScreen, arguments: device);
          }
          if (!device.device.isConnected) {
            debugPrint("debugCanConnect: Can be connected");
            BlocProvider.of<PairDeviceCubit>(context).tryConnect(device);
          }
          if (device.device.isConnected) {
            debugPrint("debugCanDisonnect: Can be disconnected");
            await device.device.disconnect();
          }
        },
        child: BlocBuilder<PairDeviceCubit, PairDeviceState>(
          builder: (context, state) {
            if (state is PairingDeviceState &&
                device.device.remoteId.str ==
                    state.device.device.remoteId.str) {
              return const Text("Pairing...");
            }
            //  else if (state is PairedState &&
            //     device.device.remoteId.str ==
            //         state.device.device.remoteId.str) {
            //   return const Text("Disconnect");
            // }
            return Text(device.device.isConnected
                ? "Disconnect"
                : canConnect
                    ? "Connect"
                    : "Cannot connect");
          },
          buildWhen: (previousState, state) {
            if (state is PairingDeviceState &&
                state.device.device.remoteId.str !=
                    device.device.remoteId.str) {
              return false;
            }
            return true;
          },
        ),
      ),
    );
  }
}
