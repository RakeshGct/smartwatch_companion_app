import 'package:flutter/material.dart';
import 'package:fit_sync/Database/database_helper.dart';

class HistoryProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _records = [];

  List<Map<String, dynamic>> get records => _records;

  Future<void> loadRecords() async {
    final data = await DatabaseHelper.instance.fetchRecords();
    _records = data;
    notifyListeners();
  }

  Future<void> addRecord(String date, int heartRate, int steps) async {
    final record = {'date': date, 'heartRate': heartRate, 'steps': steps};
    await DatabaseHelper.instance.addRecord(record);
    await loadRecords();
  }
}
