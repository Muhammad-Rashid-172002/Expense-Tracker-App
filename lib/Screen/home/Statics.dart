import 'package:collection/collection.dart';
import 'package:expans_traker/models/expense.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class Statistics extends StatelessWidget {
  const Statistics({super.key});

  @override
  Widget build(BuildContext context) {
    final expenses = Hive.box<Expense>('expenses').values.toList();

    final Map<String, double> categoryTotals = {};
    for (var e in expenses) {
      if (e.isExpense) {
        categoryTotals[e.category] =
            (categoryTotals[e.category] ?? 0) + e.amount;
      }
    }

    final total = categoryTotals.values.fold(0.0, (a, b) => a + b);

    final colors = [
      Colors.amber,
      Colors.blue,
      Colors.green,
      Colors.red,
      Colors.purple,
      Colors.grey,
    ];

    final List<PieChartSectionData> sections = [];
    int index = 0;
    categoryTotals.forEach((category, amount) {
      final percentage = (amount / total) * 100;
      sections.add(
        PieChartSectionData(
          color: colors[index % colors.length],
          value: percentage,
          title: "${percentage.toStringAsFixed(0)}%",
          titleStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      );
      index++;
    });

    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF0F172A),
        title: const Text(
          "Statistics",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              AspectRatio(
                aspectRatio: 1.2,
                child: PieChart(
                  PieChartData(
                    sections: sections,
                    centerSpaceRadius: 50,
                    sectionsSpace: 2,
                    borderData: FlBorderData(show: false),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              const SizedBox(height: 20),
              Text(
                "Category Breakdown",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: categoryTotals.entries.mapIndexed((i, entry) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor:
                              colors[i %
                                  colors.length], // Color for this category
                          radius: 6,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          entry.key, // Category name like Food, Travel, etc.
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              Text(
                "Total Expenses: Rs. ${total.toStringAsFixed(2)}",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
