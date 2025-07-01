import 'package:expans_traker/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  String _category = 'General';
  bool _isExpense = true;

  // ✅ Save the expense to Hive database
  void _saveExpense() async {
    if (_formKey.currentState!.validate()) {
      final expense = Expense(
        title: _titleController.text,
        amount: double.parse(_amountController.text),
        category: _category,
        date: DateTime.now(),
      );

      final box = Hive.box<Expense>('expenses');
      await box.add(expense);

      // Show confirmation and clear fields
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Expense Saved')));

      _titleController.clear();
      _amountController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F172A),
        elevation: 0,
        title: const Text("Add Expense"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Title input
              TextFormField(
                controller: _titleController,
                decoration: _inputDecoration("Title"),
                validator: (value) => value!.isEmpty ? 'Enter title' : null,
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 12),

              // Amount input
              TextFormField(
                controller: _amountController,
                decoration: _inputDecoration("Amount"),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Enter amount' : null,
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 12),

              // Dropdown for category
              DropdownButtonFormField<String>(
                value: _category,
                items: ['General', 'Food', 'Transport', 'Bills', 'Income']
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (val) => setState(() => _category = val!),
                decoration: _inputDecoration("Category"),
                dropdownColor: Colors.grey[900],
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 12),

              // Toggle for Expense / Income
              SwitchListTile(
                value: _isExpense,
                onChanged: (val) => setState(() => _isExpense = val),
                title: const Text(
                  'Is Expense?',
                  style: TextStyle(color: Colors.white),
                ),
                activeColor: Colors.redAccent,
              ),

              const SizedBox(height: 20),

              // Save button
              ElevatedButton(
                onPressed: _saveExpense,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber[600],
                  padding: const EdgeInsets.symmetric(
                    horizontal: 100,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text("Add", style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Input field decoration styling
  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.white70),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.white24),
        borderRadius: BorderRadius.circular(10),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.blueAccent),
        borderRadius: BorderRadius.circular(10),
      ),
      filled: true,
      fillColor: const Color(0xFF1E293B),
    );
  }
}
