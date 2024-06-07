import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_bluetooth/business_logic/bluetooth_on_off_cubit/bluetooth_on_off_cubit.dart';
import 'package:learn_bluetooth/business_logic/bluetooth_on_off_cubit/bluetooth_on_off_state.dart';
import 'package:learn_bluetooth/business_logic/connected_devices_cubit/connected_devices_cubit.dart';
import 'package:learn_bluetooth/screens/scan_devices_screen.dart';
import 'package:learn_bluetooth/widgets/bluetooth_on_off_toggle_widget.dart';
import 'connected_devices_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  ValueNotifier<int> navAt = ValueNotifier<int>(0);
  PageController pageController = PageController(initialPage: 0);
  final ScrollController scanDevicesScreenController = ScrollController();
  final ScrollController connectedDevicesScreenController = ScrollController();
  @override
  void initState() {
    if (BlocProvider.of<BluetoothOnOffCubit>(context).state
        is BluetoothOnState) {
      BlocProvider.of<ConnectedDevicesCubit>(context).fetchConnectedDevices();
    }
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: const BluetoothToggleWidget(),
        bottomNavigationBar: ValueListenableBuilder(
          valueListenable: navAt,
          builder: (context, currentIndex, child) {
            return CupertinoTabBar(
                currentIndex: currentIndex,
                onTap: (value) {
                  if (navAt.value != value) {
                    pageController.jumpToPage(value);
                  }
                },
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(CupertinoIcons.bluetooth),
                      label: "Discover Devices"),
                  BottomNavigationBarItem(
                      icon: Icon(CupertinoIcons.home),
                      label: "Connected Devices"),
                ]);
          },
        ),
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: pageController,
          onPageChanged: (newPage) => navAt.value = newPage,
          children: const [
            ScanDevicesScreen(),
            ConnectedDevicesScreen(),
          ],
        ));
  }
}
