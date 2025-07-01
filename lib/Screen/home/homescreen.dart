import 'package:expans_traker/Screen/home/AddExpenseScreen.dart';
import 'package:expans_traker/models/expense.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  int currentIndex = 0;

  // final screen = [Home(), History(), Statistics()];
  final screen = [home(), sttings(), chat()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screen[currentIndex],
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        items: [
          SalomonBottomBarItem(
            icon: const Icon(Icons.home),
            title: const Text("Home"),
            selectedColor: Colors.blue,
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.history),
            title: const Text("History"),
            selectedColor: Colors.orange,
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.pie_chart),
            title: const Text("Stats"),
            selectedColor: Colors.teal,
          ),
        ],
      ),
    );
  }
}

class chat extends StatelessWidget {
  const chat({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF0F172A),
      child: Center(
        child: Text(
          "Stats Screen",
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
    );
  }
}

class sttings extends StatelessWidget {
  const sttings({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF0F172A),
      child: Center(
        child: Text(
          "History Screen",
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
    );
  }
}

class home extends StatelessWidget {
  const home({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF0F172A),
      child: Center(
        child: Text(
          "Home Screen",
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
    );
  }
}

// class Statistics extends StatelessWidget {
//   const Statistics({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final expenses = Hive.box<Expense>('expenses').values.toList();

//     final Map<String, double> categoryTotals = {};
//     for (var e in expenses) {
//       if (e.isExpense) {
//         categoryTotals[e.category] =
//             (categoryTotals[e.category] ?? 0) + e.amount;
//       }
//     }

//     final total = categoryTotals.values.fold(0.0, (a, b) => a + b);

//     final colors = [
//       Colors.amber,
//       Colors.blue,
//       Colors.green,
//       Colors.red,
//       Colors.purple,
//       Colors.grey,
//     ];

//     final List<PieChartSectionData> sections = [];
//     int index = 0;
//     categoryTotals.forEach((category, amount) {
//       final percentage = (amount / total) * 100;
//       sections.add(
//         PieChartSectionData(
//           color: colors[index % colors.length],
//           value: percentage,
//           title: "${percentage.toStringAsFixed(0)}%",
//           titleStyle: const TextStyle(
//             fontSize: 14,
//             fontWeight: FontWeight.bold,
//             color: Colors.white,
//           ),
//         ),
//       );
//       index++;
//     });

//     return Scaffold(
//       backgroundColor: const Color(0xFF0F172A),
//       appBar: AppBar(
//         backgroundColor: const Color(0xFF0F172A),
//         title: const Text("Statistics"),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           children: [
//             AspectRatio(
//               aspectRatio: 1.2,
//               child: PieChart(
//                 PieChartData(
//                   sections: sections,
//                   centerSpaceRadius: 50,
//                   sectionsSpace: 2,
//                   borderData: FlBorderData(show: false),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 30),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class History extends StatelessWidget {
//   const History({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final box = Hive.box<Expense>('expenses');
//     final List<Expense> expenses = box.values.toList();
//     final grouped = _groupByDate(expenses);

//     return Scaffold(
//       backgroundColor: const Color(0xFF0F172A),
//       appBar: AppBar(
//         backgroundColor: const Color(0xFF0F172A),
//         elevation: 0,
//         title: const Text("Expense History"),
//         centerTitle: true,
//       ),
//       body: grouped.isEmpty
//           ? const Center(
//               child: Text(
//                 "No expenses yet",
//                 style: TextStyle(color: Colors.white54),
//               ),
//             )
//           : ListView.builder(
//               itemCount: grouped.length,
//               itemBuilder: (context, index) {
//                 final date = grouped.keys.elementAt(index);
//                 final items = grouped[date]!;

//                 return Padding(
//                   padding: const EdgeInsets.symmetric(
//                     vertical: 6,
//                     horizontal: 12,
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         date,
//                         style: const TextStyle(
//                           color: Colors.white70,
//                           fontSize: 14,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                       const SizedBox(height: 6),
//                       ...items.map(
//                         (e) => Card(
//                           color: const Color(0xFF1E293B),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           child: ListTile(
//                             title: Text(
//                               e.title,
//                               style: const TextStyle(color: Colors.white),
//                             ),
//                             subtitle: Text(
//                               e.category,
//                               style: const TextStyle(color: Colors.white54),
//                             ),
//                             trailing: Text(
//                               'Rs. ${e.amount.toStringAsFixed(2)}',
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//     );
//   }

//   Map<String, List<Expense>> _groupByDate(List<Expense> expenses) {
//     Map<String, List<Expense>> grouped = {};
//     for (var expense in expenses) {
//       final formattedDate = _formatDate(expense.date);
//       grouped.putIfAbsent(formattedDate, () => []).add(expense);
//     }
//     final sorted = Map.fromEntries(
//       grouped.entries.toList()..sort((a, b) => b.key.compareTo(a.key)),
//     );
//     return sorted;
//   }

//   String _formatDate(DateTime date) {
//     final now = DateTime.now();
//     final today = DateTime(now.year, now.month, now.day);
//     final yesterday = today.subtract(const Duration(days: 1));
//     final d = DateTime(date.year, date.month, date.day);
//     if (d == today) return "Today";
//     if (d == yesterday) return "Yesterday";
//     return DateFormat('MMMM dd, yyyy').format(date);
//   }
// }

// class Home extends StatefulWidget {
//   const Home({super.key});

//   @override
//   State<Home> createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   double _balance = 1250.0;

//   @override
//   Widget build(BuildContext context) {
//     final expenses = Hive.box<Expense>(
//       'expenses',
//     ).values.toList().reversed.toList();

//     return Scaffold(
//       backgroundColor: const Color(0xFF0F172A),
//       appBar: AppBar(
//         backgroundColor: const Color(0xFF0F172A),
//         elevation: 0,
//         title: const Text(
//           "Home",
//           style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//         ),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               padding: const EdgeInsets.all(20),
//               decoration: BoxDecoration(
//                 color: const Color(0xFF1E293B),
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   const Text(
//                     "Balance",
//                     style: TextStyle(color: Colors.white70, fontSize: 16),
//                   ),
//                   Row(
//                     children: [
//                       Text(
//                         'Rs. ${_balance.toStringAsFixed(2)}',
//                         style: const TextStyle(
//                           color: Colors.white,
//                           fontSize: 22,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       IconButton(
//                         icon: const Icon(
//                           Icons.edit,
//                           color: Colors.white70,
//                           size: 20,
//                         ),
//                         onPressed: () => _editBalanceDialog(context),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 20),
//             const Text(
//               "Expenses",
//               style: TextStyle(color: Colors.white70, fontSize: 16),
//             ),
//             const SizedBox(height: 10),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: expenses.length,
//                 itemBuilder: (context, index) {
//                   final item = expenses[index];
//                   return Card(
//                     color: const Color(0xFF1E293B),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     margin: const EdgeInsets.symmetric(vertical: 8),
//                     child: ListTile(
//                       title: Text(
//                         item.title,
//                         style: const TextStyle(color: Colors.white),
//                       ),
//                       subtitle: Text(
//                         item.category,
//                         style: const TextStyle(color: Colors.white54),
//                       ),
//                       trailing: Text(
//                         'Rs. ${item.amount}',
//                         style: const TextStyle(
//                           color: Colors.amber,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: Colors.amber[600],
//         child: const Icon(Icons.add),
//         onPressed: () async {
//           await Navigator.push(
//             context,
//             MaterialPageRoute(builder: (_) => const AddExpenseScreen()),
//           );
//           setState(() {});
//         },
//       ),
//     );
//   }

//   void _editBalanceDialog(BuildContext context) {
//     final TextEditingController balanceController = TextEditingController(
//       text: _balance.toString(),
//     );
//     showDialog(
//       context: context,
//       builder: (_) => AlertDialog(
//         backgroundColor: const Color(0xFF1E293B),
//         title: const Text(
//           "Edit Balance",
//           style: TextStyle(color: Colors.white),
//         ),
//         content: TextField(
//           controller: balanceController,
//           keyboardType: TextInputType.number,
//           style: const TextStyle(color: Colors.white),
//           decoration: const InputDecoration(
//             hintText: "Enter new balance",
//             hintStyle: TextStyle(color: Colors.white54),
//             enabledBorder: UnderlineInputBorder(
//               borderSide: BorderSide(color: Colors.white24),
//             ),
//           ),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () {
//               setState(() {
//                 _balance = double.tryParse(balanceController.text) ?? _balance;
//               });
//               Navigator.pop(context);
//             },
//             child: const Text("Save", style: TextStyle(color: Colors.amber)),
//           ),
//         ],
//       ),
//     );
//   }
// }
