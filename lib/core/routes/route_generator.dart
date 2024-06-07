import 'package:flutter/cupertino.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:learn_bluetooth/business_logic/discover_services_cubit/discover_services_cubit.dart';
import 'package:learn_bluetooth/core/routes/app_routes.dart';
import 'package:learn_bluetooth/screens/connected_device_screen.dart';
import 'package:learn_bluetooth/screens/dashboard_screen.dart';
import 'package:learn_bluetooth/screens/received_messages_screen.dart';
import 'package:learn_bluetooth/screens/scan_devices_screen.dart';
import 'package:learn_bluetooth/screens/view_services_screen.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  Object? argument = settings.arguments;
  switch (settings.name) {
    case AppRoutes.dashboardScreen:
      return CupertinoPageRoute(builder: (context) => const DashboardScreen());
    case AppRoutes.scanDevicesScreen:
      return CupertinoPageRoute(
          builder: (context) => const ScanDevicesScreen());
    case AppRoutes.connectedDeviceScreen:
      return CupertinoPageRoute(
          builder: (context) =>
              ConnectedDeviceScreen(device: argument as ScanResult));

    case AppRoutes.viewServicesScreen:
      return CupertinoPageRoute(
          builder: (context) =>
              ViewServiceScreen(device: argument as BluetoothDevice));
    case AppRoutes.receivedMessagesScreen:
      return CupertinoPageRoute(
          builder: (context) => ReceivedMessagesScreen(
              servicesCubit: argument as DiscoverServicesCubit));
    default:
      return CupertinoPageRoute(builder: (context) => const DashboardScreen());
  }
}
