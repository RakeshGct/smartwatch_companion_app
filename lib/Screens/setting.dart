import 'package:fit_sync/Provider/bluetooth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bluetoothProvider = Provider.of<BluetoothProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Setting"),
      ),
      body: Column(
        children: [
          Text(
            'Bluetooth Status: ${bluetoothProvider.isConnected ? 'Connected' : 'Disconnected'}',
            style: TextStyle(
              color: bluetoothProvider.isConnected
                  ? Colors.green
                  : Colors.red,
            ),
          ),
          SizedBox(height: 20),
          Row(
            children: [
              ElevatedButton(
                onPressed: bluetoothProvider.connect,
                child: Text('Connect'),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: bluetoothProvider.disconnect,
                child: Text('Disconnect'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
