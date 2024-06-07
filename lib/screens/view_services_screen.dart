import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:learn_bluetooth/business_logic/discover_services_cubit/discover_services_cubit.dart';
import 'package:learn_bluetooth/business_logic/discover_services_cubit/discover_services_state.dart';
import 'package:learn_bluetooth/core/routes/app_routes.dart';
import 'package:learn_bluetooth/widgets/list_of_services_widget.dart';

class ViewServiceScreen extends StatefulWidget {
  final BluetoothDevice device;
  const ViewServiceScreen({super.key, required this.device});

  @override
  State<ViewServiceScreen> createState() => _ViewServiceScreenState();
}

class _ViewServiceScreenState extends State<ViewServiceScreen> {
  @override
  void initState() {
    BlocProvider.of<DiscoverServicesCubit>(context)
        .discoverServices(widget.device);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).pushNamed(AppRoutes.receivedMessagesScreen,
              arguments: BlocProvider.of<DiscoverServicesCubit>(context));
        },
        label: ValueListenableBuilder(
          valueListenable: BlocProvider.of<DiscoverServicesCubit>(context)
              .receivedMessagesFromBLE,
          builder: (context, value, child) {
            return Text("View Received Messages (${value.length})");
          },
        ),
      ),
      appBar: AppBar(
        title: const Text('Available Services'),
      ),
      body: BlocBuilder<DiscoverServicesCubit, DiscoverServiceState>(
        builder: (context, state) {
          if (state is ErrorLoadingServiceState) {
            return Center(
              child: Text(state.errorData.msg),
            );
          } else if (state is ServicesLoadedState) {
            return ListOfServicesWidget(services: state.services);
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
