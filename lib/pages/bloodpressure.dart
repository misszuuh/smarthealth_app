import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math';

class BloodPressurePage extends StatefulWidget {
  const BloodPressurePage({super.key});

  @override
  State<BloodPressurePage> createState() => _BloodPressurePageState();
}

class _BloodPressurePageState extends State<BloodPressurePage> {
  List<FlSpot> systolicData = [];
  List<FlSpot> diastolicData = [];

  @override
  void initState() {
    super.initState();
    _generateMockData();
  }

  void _generateMockData() {
    for (int i = 0; i < 15; i++) {
      systolicData.add(FlSpot(i.toDouble(), 100 + Random().nextInt(40).toDouble()));
      diastolicData.add(FlSpot(i.toDouble(), 60 + Random().nextInt(30).toDouble()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Blood Pressure')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: LineChart(
          LineChartData(
            minY: 40,
            maxY: 160,
            titlesData: FlTitlesData(
              leftTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: true),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: true),
              ),
            ),
            lineBarsData: [
              LineChartBarData(
                spots: systolicData,
                isCurved: true,
                barWidth: 3,
                color: Colors.red,
                belowBarData: BarAreaData(
                  show: true,
                  color: Colors.red.withAlpha((0.3 * 255).toInt()), // Fixed deprecated withOpacity
                ),
              ),
              LineChartBarData(
                spots: diastolicData,
                isCurved: true,
                barWidth: 3,
                color: Colors.blue,
                belowBarData: BarAreaData(
                  show: true,
                  color: Colors.blue.withAlpha((0.3 * 255).toInt()), // Fixed deprecated withOpacity
                ),
              ),
            ],
            gridData: FlGridData(show: true),
            borderData: FlBorderData(show: true),
          ),
        ),
      ),
    );
  }
}