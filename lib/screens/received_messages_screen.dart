import 'package:flutter/material.dart';
import 'package:learn_bluetooth/business_logic/discover_services_cubit/discover_services_cubit.dart';

class ReceivedMessagesScreen extends StatelessWidget {
  final DiscoverServicesCubit servicesCubit;
  const ReceivedMessagesScreen({super.key, required this.servicesCubit});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            servicesCubit.clearMessages();
          },
          label: const Text("Clear All Messages")),
      appBar: AppBar(
        title: const Text("Received Messages"),
      ),
      body: ValueListenableBuilder(
        valueListenable: servicesCubit.receivedMessagesFromBLE,
        builder: (context, updatedMsgs, child) {
          return ListView.builder(
            itemCount: updatedMsgs.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Text("Char: ${updatedMsgs[index].char}"),
                  Text("Msg: ${updatedMsgs[index].msg}"),
                  const Divider()
                ],
              );
            },
          );
        },
      ),
    );
  }
}
