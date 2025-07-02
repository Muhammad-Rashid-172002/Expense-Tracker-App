import 'package:expans_traker/Screen/home/AddExpenseScreen.dart';
import 'package:expans_traker/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double _balance = 1250.0;

  @override
  Widget build(BuildContext context) {
    final expenses = Hive.box<Expense>(
      'expenses',
    ).values.toList().reversed.toList();

    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF0F172A),
        elevation: 0,
        title: const Text(
          "Home",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Balance card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF1E293B),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Balance",
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                  Row(
                    children: [
                      Text(
                        'Rs. ${_balance.toStringAsFixed(2)}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.white70,
                          size: 20,
                        ),
                        onPressed: () => _editBalanceDialog(context),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Expenses",
              style: TextStyle(color: Colors.white70, fontSize: 16),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: expenses.isEmpty
                  ? const Center(
                      child: Text(
                        "No expenses yet",
                        style: TextStyle(color: Colors.white38),
                      ),
                    )
                  : ListView.builder(
                      itemCount: expenses.length,
                      itemBuilder: (context, index) {
                        final item = expenses[index];

                        return Slidable(
                          key: Key(item.key.toString()),
                          endActionPane: ActionPane(
                            motion: const DrawerMotion(),
                            extentRatio: 0.34,
                            children: [
                              SlidableAction(
                                onPressed: (_) => _confirmDelete(context, item),
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
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            child: ListTile(
                              title: Text(
                                item.title,
                                style: const TextStyle(color: Colors.white),
                              ),
                              subtitle: Text(
                                item.category,
                                style: const TextStyle(color: Colors.white54),
                              ),
                              trailing: Text(
                                'Rs. ${item.amount}',
                                style: const TextStyle(
                                  color: Colors.amber,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber[600],
        child: const Icon(Icons.add),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddExpenseScreen()),
          );
          setState(() {}); // Refresh screen
        },
      ),
    );
  }

  // Edit balance dialog
  void _editBalanceDialog(BuildContext context) {
    final TextEditingController balanceController = TextEditingController(
      text: _balance.toString(),
    );
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: const Color(0xFF1E293B),
        title: const Text(
          "Edit Balance",
          style: TextStyle(color: Colors.white),
        ),
        content: TextField(
          controller: balanceController,
          keyboardType: TextInputType.number,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            hintText: "Enter new balance",
            hintStyle: TextStyle(color: Colors.white54),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white24),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                _balance = double.tryParse(balanceController.text) ?? _balance;
              });
              Navigator.pop(context);
            },
            child: const Text("Save", style: TextStyle(color: Colors.amber)),
          ),
        ],
      ),
    );
  }

  // Confirm delete dialog
  void _confirmDelete(BuildContext context, Expense item) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
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
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text("Cancel", style: TextStyle(color: Colors.white)),
          ),
          TextButton(
            onPressed: () {
              item.delete(); // Delete from Hive
              Navigator.of(ctx).pop();
              setState(() {}); // Refresh UI
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
}
