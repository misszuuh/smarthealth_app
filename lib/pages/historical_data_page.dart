import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HistoricalDataPage extends StatelessWidget {
  const HistoricalDataPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Historical Data'),
          backgroundColor: const Color(0xFFE75480),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Heart Rate'),
              Tab(text: 'Blood Pressure'),
              Tab(text: 'Medications'),
            ],
            indicatorColor: Colors.white,
          ),
        ),
        body: const TabBarView(
          children: [
            HeartRateHistory(),
            BloodPressureHistory(),
            MedicationHistory(),
          ],
        ),
      ),
    );
  }
}

class HeartRateHistory extends StatelessWidget {
  const HeartRateHistory({super.key});

  @override
  Widget build(BuildContext context) {
    final List<HeartRateData> data = [
      HeartRateData(DateTime(2023, 1, 1), 72),
      HeartRateData(DateTime(2023, 1, 2), 75),
      HeartRateData(DateTime(2023, 1, 3), 78),
      HeartRateData(DateTime(2023, 1, 4), 71),
      HeartRateData(DateTime(2023, 1, 5), 74),
      HeartRateData(DateTime(2023, 1, 6), 76),
      HeartRateData(DateTime(2023, 1, 7), 73),
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          SizedBox(
            height: 300,
            child: SfCartesianChart(
              primaryXAxis: DateTimeAxis(),
              series: <CartesianSeries<HeartRateData, DateTime>>[
                LineSeries<HeartRateData, DateTime>(
                  dataSource: data,
                  xValueMapper: (HeartRateData hr, _) => hr.date,
                  yValueMapper: (HeartRateData hr, _) => hr.rate,
                  dataLabelSettings: const DataLabelSettings(isVisible: true),
                  color: Colors.red,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text('Recent Measurements',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          ...data.reversed.map((hr) => ListTile(
            leading: const Icon(Icons.favorite, color: Colors.red),
            title: Text('${hr.rate} BPM'),
            subtitle: Text('${hr.date.day}/${hr.date.month}/${hr.date.year}'),
          )),
        ],
      ),
    );
  }
}

class BloodPressureHistory extends StatelessWidget {
  const BloodPressureHistory({super.key});

  @override
  Widget build(BuildContext context) {
    final List<BloodPressureData> data = [
      BloodPressureData(DateTime(2023, 1, 1), 120, 80),
      BloodPressureData(DateTime(2023, 1, 2), 118, 78),
      BloodPressureData(DateTime(2023, 1, 3), 122, 82),
      BloodPressureData(DateTime(2023, 1, 4), 125, 85),
      BloodPressureData(DateTime(2023, 1, 5), 119, 79),
      BloodPressureData(DateTime(2023, 1, 6), 121, 80),
      BloodPressureData(DateTime(2023, 1, 7), 117, 77),
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          SizedBox(
            height: 300,
            child: SfCartesianChart(
              primaryXAxis: DateTimeAxis(),
              series: <CartesianSeries<BloodPressureData, DateTime>>[
                LineSeries<BloodPressureData, DateTime>(
                  dataSource: data,
                  xValueMapper: (BloodPressureData bp, _) => bp.date,
                  yValueMapper: (BloodPressureData bp, _) => bp.systolic,
                  name: 'Systolic',
                  color: Colors.red,
                  dataLabelSettings: const DataLabelSettings(isVisible: true),
                ),
                LineSeries<BloodPressureData, DateTime>(
                  dataSource: data,
                  xValueMapper: (BloodPressureData bp, _) => bp.date,
                  yValueMapper: (BloodPressureData bp, _) => bp.diastolic,
                  name: 'Diastolic',
                  color: Colors.blue,
                  dataLabelSettings: const DataLabelSettings(isVisible: true),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text('Recent Measurements',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          ...data.reversed.map((bp) => ListTile(
            leading: const Icon(Icons.monitor_heart, color: Colors.pink),
            title: Text('${bp.systolic}/${bp.diastolic} mmHg'),
            subtitle: Text('${bp.date.day}/${bp.date.month}/${bp.date.year}'),
          )),
        ],
      ),
    );
  }
}

class MedicationHistory extends StatelessWidget {
  const MedicationHistory({super.key});

  @override
  Widget build(BuildContext context) {
    final List<MedicationData> data = [
      MedicationData('Ibuprofen', '200mg', DateTime(2023, 1, 1, 8, 0), true),
      MedicationData('Vitamin D', '1000IU', DateTime(2023, 1, 1, 12, 0), true),
      MedicationData('Ibuprofen', '200mg', DateTime(2023, 1, 2, 8, 0), true),
      MedicationData('Vitamin D', '1000IU', DateTime(2023, 1, 2, 12, 0), false),
      MedicationData('Ibuprofen', '200mg', DateTime(2023, 1, 3, 8, 0), true),
      MedicationData('Vitamin D', '1000IU', DateTime(2023, 1, 3, 12, 0), true),
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: data.length,
      itemBuilder: (context, index) {
        final med = data[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: ListTile(
            leading: Icon(
              med.taken ? Icons.check_circle : Icons.error,
              color: med.taken ? Colors.green : Colors.orange,
            ),
            title: Text(med.name),
            subtitle: Text(
              '${med.dosage} - ${med.time.hour}:${med.time.minute.toString().padLeft(2, '0')}'),
            trailing: Text(
              '${med.time.day}/${med.time.month}/${med.time.year}'),
          ),
        );
      },
    );
  }
}

class HeartRateData {
  final DateTime date;
  final int rate;

  HeartRateData(this.date, this.rate);
}

class BloodPressureData {
  final DateTime date;
  final int systolic;
  final int diastolic;

  BloodPressureData(this.date, this.systolic, this.diastolic);
}

class MedicationData {
  final String name;
  final String dosage;
  final DateTime time;
  final bool taken;

  MedicationData(this.name, this.dosage, this.time, this.taken);
}