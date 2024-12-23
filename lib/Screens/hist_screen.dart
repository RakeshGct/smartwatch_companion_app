import 'package:fit_sync/Provider/hist_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final historyProvider = Provider.of<HistoryProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
      ),
      body: FutureBuilder(
        future: historyProvider.loadRecords(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (historyProvider.records.isEmpty) {
            return Center(
              child: Text(
                'No health records found.',
                style: TextStyle(fontSize: 16),
              ),
            );
          }
          return ListView.builder(
            itemCount: historyProvider.records.length,
            itemBuilder: (context, index) {
              final record = historyProvider.records[index];
              return ListTile(
                leading: Icon(Icons.favorite, color: Colors.red),
                title: Text('Heart Rate: ${record['heartRate']} bpm'),
                subtitle: Text(
                  'Steps: ${record['steps']}\nDate: ${record['date']}',
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Example to add a record (you can remove this after testing)
          await historyProvider.addRecord(
            DateTime.now().toIso8601String(),
            72, // Example heart rate
            1000, // Example steps
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
