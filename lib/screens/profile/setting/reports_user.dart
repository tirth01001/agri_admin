


import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class AdminAnalyticsReports extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Analytics & Reports")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("App Usage Analytics", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            SizedBox(height: 200, child: _buildLineChart()),
            
            SizedBox(height: 20),
            Text("User Growth Reports", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            SizedBox(height: 200, child: _buildBarChart()),
            
            SizedBox(height: 20),
            Text("Revenue & Transaction Reports", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            SizedBox(height: 200, child: _buildPieChart()),
          ],
        ),
      ),
    );
  }

  Widget _buildLineChart() {
    return LineChart(
      LineChartData(
        gridData: FlGridData(show: false),
        titlesData: FlTitlesData(show: false),
        borderData: FlBorderData(show: false),
        lineBarsData: [
          LineChartBarData(
            spots: [FlSpot(1, 2), FlSpot(2, 3), FlSpot(3, 5), FlSpot(4, 3.5)],
            isCurved: true,
            color: Colors.blue,
            dotData: FlDotData(show: false),
          )
        ],
      ),
    );
  }

  Widget _buildBarChart() {
    return BarChart(
      BarChartData(
        gridData: FlGridData(show: false),
        titlesData: FlTitlesData(show: false),
        borderData: FlBorderData(show: false),
        barGroups: [
          BarChartGroupData(x: 1, barRods: [BarChartRodData(toY: 5, color: Colors.green)]),
          BarChartGroupData(x: 2, barRods: [BarChartRodData(toY: 7, color: Colors.green)]),
          BarChartGroupData(x: 3, barRods: [BarChartRodData(toY: 3, color: Colors.green)]),
        ],
      ),
    );
  }

  Widget _buildPieChart() {
    return PieChart(
      PieChartData(
        sections: [
          PieChartSectionData(value: 40, color: Colors.blue, title: "Sales"),
          PieChartSectionData(value: 30, color: Colors.red, title: "Expenses"),
          PieChartSectionData(value: 30, color: Colors.green, title: "Profit"),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: AdminAnalyticsReports(),
  ));
}
