import 'package:fit_sync/Widget/user_information.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fit_sync/Provider/bluetooth_provider.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bluetoothProvider = Provider.of<BluetoothProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //
            UserInfoWidget(),

            SizedBox(height: 60,),
            // Heart Rate Section
            CustomHeartRateWidget(
              heartRate: bluetoothProvider.heartRate,
              isConnected: bluetoothProvider.isConnected,
            ),
            SizedBox(height: 30),

            // Steps Section
            CustomStepsWidget(
              steps: bluetoothProvider.steps,
              isConnected: bluetoothProvider.isConnected,
            ),
            SizedBox(height: 30),

            // Additional Widgets (you can add more here)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  'Health Data Overview',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            // Example additional content can go here
            // You can add charts, graphs, or more data displays.
          ],
        ),
      ),
    );
  }
}

class CustomHeartRateWidget extends StatelessWidget {
  final int heartRate;
  final bool isConnected;

  const CustomHeartRateWidget({
    Key? key,
    required this.heartRate,
    required this.isConnected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(seconds: 1),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isConnected ? Colors.green : Colors.grey.shade300,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(0, 4),
            blurRadius: 6,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Heart Rate',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: isConnected ? Colors.white : Colors.black,
                ),
              ),
              Icon(Icons.favorite, color: Colors.red,size: 50,),
            ],
          ),
          SizedBox(height: 10),
          TweenAnimationBuilder<int>(
            tween: IntTween(begin: 0, end: heartRate),
            duration: Duration(seconds: 2),
            builder: (context, value, child) {
              return Text(
                '$value BPM',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: isConnected ? Colors.white : Colors.black,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class CustomStepsWidget extends StatelessWidget {
  final int steps;
  final bool isConnected;

  const CustomStepsWidget({
    Key? key,
    required this.steps,
    required this.isConnected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(seconds: 1),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isConnected ? Colors.amberAccent : Colors.grey.shade300,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(0, 4),
            blurRadius: 6,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Steps',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: isConnected ? Colors.white : Colors.black,
                ),
              ),
              Icon(Icons.directions_walk_outlined, color: Colors.blue, size: 50,)
            ],
          ),
          SizedBox(height: 10),
          TweenAnimationBuilder<int>(
            tween: IntTween(begin: 0, end: steps),
            duration: Duration(seconds: 2),
            builder: (context, value, child) {
              return Text(
                '$value Steps',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: isConnected ? Colors.white : Colors.black,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
