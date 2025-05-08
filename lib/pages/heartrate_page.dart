import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class HeartRatePage extends StatefulWidget {
  const HeartRatePage({super.key});

  @override
  HeartRatePageState createState() => HeartRatePageState();
}

class HeartRatePageState extends State<HeartRatePage> {
  List<FlSpot> heartRateData = [];

  @override
  void initState() {
    super.initState();
    _generateMockData(); // Replace this with actual data stream later
  }

  void _generateMockData() {
    // Mock data for demo
    heartRateData = List.generate(20, (index) {
      return FlSpot(index.toDouble(), 60 + Random().nextInt(40).toDouble());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Heart Rate Graph')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: LineChart(
          LineChartData(
            titlesData: FlTitlesData(show: true),
            borderData: FlBorderData(show: true),
            lineBarsData: [
              LineChartBarData(
                spots: heartRateData,
                isCurved: true,
              
                barWidth: 3,
                
              ),
            ],
          ),
        ),
      ),
    );
  }
}
