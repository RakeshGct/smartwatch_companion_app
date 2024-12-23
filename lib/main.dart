import 'package:firebase_core/firebase_core.dart';
import 'package:fit_sync/Authentication/check_user.dart';
import 'package:fit_sync/Authentication/login_page.dart';
import 'package:fit_sync/Provider/bluetooth_provider.dart';
import 'package:fit_sync/Provider/hist_provider.dart';
import 'package:fit_sync/Provider/profile_provider.dart';
import 'package:fit_sync/Screens/dashboard.dart';
import 'package:fit_sync/Screens/hist_screen.dart';
import 'package:fit_sync/Screens/profile.dart';
import 'package:fit_sync/Screens/setting.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BluetoothProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
        ChangeNotifierProvider(create: (_) => HistoryProvider()),
          ],child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: false,
      ),
      home: CheckUser(),
    );
  }
}

class MainScreen extends StatelessWidget {
  final List<Widget> _screens = [
    DashboardScreen(),
    HistoryScreen(),
    SettingScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<BluetoothProvider>(
      builder: (context, bluetoothProvider, child) {
        //print("Current Index: ${bluetoothProvider.currentIndex}");
        return Scaffold(
          body: _screens[bluetoothProvider.currentIndex], // Current screen
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: bluetoothProvider.currentIndex, // Selected index
            onTap: (index) {
              bluetoothProvider.setIndex(index); // Update index
            },
            backgroundColor: Colors.blue,
            unselectedItemColor: Colors.black,
            selectedItemColor: Colors.black,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home, color: Colors.black,),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.history, color: Colors.black),
                label: 'History',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings, color: Colors.black,),
                label: 'Settings',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outlined, color: Colors.black),
                label: 'Profile',
              ),
            ],
          ),
        );
      },
    );
  }
}
