import 'package:expans_traker/Screen/home/home.dart';
import 'package:expans_traker/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class History extends StatelessWidget {
  const History({super.key});

  @override
  Widget build(BuildContext context) {
    final box = Hive.box<Expense>('expenses');
    final List<Expense> expenses = box.values.toList();
    final grouped = _groupByDate(expenses);

    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F172A),
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          "Expense History",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: grouped.isEmpty
          ? const Center(
              child: Text(
                "No expenses yet",
                style: TextStyle(color: Colors.white54),
              ),
            )
          : ListView.builder(
              itemCount: grouped.length,
              itemBuilder: (context, index) {
                final date = grouped.keys.elementAt(index);
                final items = grouped[date]!;

                return Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 6,
                    horizontal: 12,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        date,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 6),
                      ...items.map(
                        (e) => Slidable(
                          key: Key(e.key.toString()),
                          endActionPane: ActionPane(
                            motion: const DrawerMotion(),
                            extentRatio: 0.35,
                            children: [
                              SlidableAction(
                                onPressed: (_) => confirmDelete(context, e),
                                backgroundColor: Colors.red,
                                foregroundColor: Colors.white,
                                icon: Icons.delete,
                                label: 'Delete',
                              ),
                            ],
                          ),
                          child: Card(
                            color: const Color(0xFF1E293B),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ListTile(
                              title: Text(
                                e.title,
                                style: const TextStyle(color: Colors.white),
                              ),
                              subtitle: Text(
                                e.category,
                                style: const TextStyle(color: Colors.white54),
                              ),
                              trailing: Text(
                                'Rs. ${e.amount.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  color: Colors.amber,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }

  // Group expenses by date
  Map<String, List<Expense>> _groupByDate(List<Expense> expenses) {
    Map<String, List<Expense>> grouped = {};
    for (var expense in expenses) {
      final formattedDate = _formatDate(expense.date);
      grouped.putIfAbsent(formattedDate, () => []).add(expense);
    }

    final sorted = Map.fromEntries(
      grouped.entries.toList()..sort((a, b) => b.key.compareTo(a.key)),
    );
    return sorted;
  }

  // Format as "Today", "Yesterday", or full date
  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final d = DateTime(date.year, date.month, date.day);

    if (d == today) return "Today";
    if (d == yesterday) return "Yesterday";
    return DateFormat('MMMM dd, yyyy').format(date);
  }
}

// Confirm delete dialog
Future<void> confirmDelete(BuildContext context, Expense item) async {
  showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      backgroundColor: const Color(0xFF1E293B),
      title: const Text(
        "Delete Expense",
        style: TextStyle(color: Colors.white),
      ),
      content: const Text(
        "Are you sure you want to delete this expense?",
        style: TextStyle(color: Colors.white70),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text("Cancel", style: TextStyle(color: Colors.white)),
        ),
        TextButton(
          onPressed: () {
            final box = Hive.box<Expense>('expenses');
            box.delete(item.key); // Delete using Hive key
            Navigator.of(context).pop();
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text("${item.title} deleted")));
          },
          child: const Text("Delete", style: TextStyle(color: Colors.red)),
        ),
      ],
    ),
  );
}
