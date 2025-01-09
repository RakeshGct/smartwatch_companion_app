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
        centerTitle: true,
      ),
      body: Column(
        spacing: 30,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 50,),
          Text('Bluetooth Status', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
          Text('${bluetoothProvider.isConnected ? 'Connected' : 'Disconnected'}',
            style: TextStyle(
              color: bluetoothProvider.isConnected
                  ? Colors.green
                  : Colors.red,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
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
