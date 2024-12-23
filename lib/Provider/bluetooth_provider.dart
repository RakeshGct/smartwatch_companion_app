import 'dart:async';
import 'package:flutter/material.dart';

class BluetoothProvider extends ChangeNotifier {
  bool _isConnected = false;
  int _heartRate = 0;
  int _steps = 0;
  int _currentIndex = 0;

  bool get isConnected => _isConnected;
  int get heartRate => _heartRate;
  int get steps => _steps;
  int get currentIndex => _currentIndex;

  Timer? _timer;


  void setIndex(int index) {
    _currentIndex = index;
    notifyListeners(); // Notify listeners to update UI
  }

  void connect() {
    _isConnected = true;
    notifyListeners();
    _startFetchingData();
  }

  void disconnect() {
    _isConnected = false;
    _timer?.cancel();
    notifyListeners();
  }

  void _startFetchingData() {
    _timer = Timer.periodic(Duration(seconds: 10), (timer) {
      if (!_isConnected) {
        timer.cancel();
        return;
      }

      _heartRate = 60 + (30 * (timer.tick % 2)); // Simulate heart rate
      _steps += 10; // Simulate step count
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
