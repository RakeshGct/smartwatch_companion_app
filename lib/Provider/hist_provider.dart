import 'package:fit_sync/Database/database_helper.dart';
import 'package:flutter/material.dart';


class HistoryProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _records = [];

  List<Map<String, dynamic>> get records => _records;

  Future<void> loadRecords() async {
    try {
      _records = await DatabaseHelper.instance.fetchRecords();
      notifyListeners();
    } catch (e) {
      print('Error loading records: $e');
    }
  }

  Future<void> addRecord(String date, int heartRate, int steps) async {
    try {
      final record = {'date': date, 'heartRate': heartRate, 'steps': steps};
      await DatabaseHelper.instance.addRecord(record);
      await loadRecords(); // Reload after adding
    } catch (e) {
      print('Error adding record: $e');
    }
  }
}
