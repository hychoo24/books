import 'package:books/providers/stat_provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookStat extends StatelessWidget {
  const BookStat({super.key});

  @override
  Widget build(BuildContext context) {
    final stats = Provider.of<StatProvider>(context).stats;

    if (stats == null) {
      return const Center(child: CircularProgressIndicator());
    }

    final maxY = stats.dataBook
        .map((e) => e.total)
        .fold<int>(0, (prev, el) => el > prev ? el : prev);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Book per Category", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 12),
        SizedBox(
          height: 200,
          child: LineChart(
            LineChartData(
              maxY: maxY.toDouble() + 1,
              minY: 0,
              lineBarsData: [
                LineChartBarData(
                  spots: stats.dataBook.asMap().entries.map((e) {
                    return FlSpot(e.key.toDouble(), e.value.total.toDouble());
                  }).toList(),
                  isCurved: true,
                  color: Colors.teal,
                  barWidth: 3,
                  dotData: FlDotData(show: true),
                ),
              ],
              titlesData: FlTitlesData(
                show: true,
                topTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    interval: 1,
                    getTitlesWidget: (value, _) {
                      final index = value.toInt();
                      if (index < stats.dataBook.length) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            stats.dataBook[index].categoryName,
                            style: const TextStyle(
                              fontSize: 12, 
                              fontWeight: FontWeight.bold
                              ),
                            ),
                          );
                        }
                      return const Text('');
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    interval: 1,
                    reservedSize: 28,
                    getTitlesWidget: (value, _) => Text(
                      value.toInt().toString(),
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                ),
                rightTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    interval: 1,
                    reservedSize: 36,
                    getTitlesWidget: (value, _) => Padding(
                      padding: const EdgeInsets.only(left: 4.0),
                      child: Text(
                      value.toInt().toString(),
                      style: const TextStyle(fontSize: 14),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
