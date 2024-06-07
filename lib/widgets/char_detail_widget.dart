import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:learn_bluetooth/core/extensions/bluetoothcharacteristic_extension.dart';

class CharDetailWidget extends StatefulWidget {
  final BluetoothCharacteristic char;
  const CharDetailWidget({super.key, required this.char});

  @override
  State<CharDetailWidget> createState() => _CharDetailWidgetState();
}

class _CharDetailWidgetState extends State<CharDetailWidget> {
  ValueNotifier<List<int>> readCharValue = ValueNotifier([]);
  TextEditingController textToWrite = TextEditingController();

  @override
  void initState() {
    readChar();
    super.initState();
  }

  void readChar() async {
    // readCharValue.value = await widget.char.read();
    if (widget.char.properties.read) {
      try {
        readCharValue.value = await widget.char.read();
      } catch (e) {
        debugPrint("debugReadChar: ${e.toString()}");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Name: ${widget.char.getName()}'),
        Text('Identifier: ${widget.char.getIdentifier()}'),
        Text('CharId: ${widget.char.uuid}'),
        Text("canWrite: ${widget.char.properties.write}"),
        if (widget.char.properties.read)
          ValueListenableBuilder(
            valueListenable: readCharValue,
            builder: (context, updatedChar, child) {
              String manuName = String.fromCharCodes(updatedChar);
              return manuName.isNotEmpty
                  ? Text('CharRead: $updatedChar\n ManuName: $manuName')
                  : const SizedBox();
            },
          ),
        if (widget.char.properties.write)
          Column(
            children: [
              TextFormField(
                controller: textToWrite,
                decoration: const InputDecoration(
                    hintText: "Enter text for write operation"),
              ),
              ElevatedButton(
                  onPressed: () async {
                    if (textToWrite.text.trim().isNotEmpty) {
                      widget.char.write(textToWrite.text.trim().codeUnits,
                          allowLongWrite: true);
                      debugPrint("debugBluetoothNotification: writeDone");
                    }
                  },
                  child: const Text("Write")),
            ],
          )
      ],
    );
  }
}
