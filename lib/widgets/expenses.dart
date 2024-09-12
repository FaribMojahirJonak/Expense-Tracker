import 'package:expense_tracker/widgets/chart/chart.dart';
import 'package:expense_tracker/widgets/expense_list/expenses_list.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});
  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(newExpense),
    ); //opens a sidebar to add a new expense
  }

  void newExpense(Expense expense) {
    setState(() {
      _expenseList.add(expense);
    });
  }

  void deleteExpense(Expense expense) {
    final curentIndex = _expenseList.indexOf(expense);
    setState(() {
      _expenseList.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 5),
        content: const Text('Expense Deleted.'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _expenseList.insert(curentIndex, expense);
            });
          },
        ),
      ),
    );
  }

  final List<Expense> _expenseList = [
    Expense(
        title: "Courses",
        amount: 10.99,
        date: DateTime.now(),
        category: Category.work),
    Expense(
        title: "Burger",
        amount: 5.99,
        date: DateTime.now(),
        category: Category.food),
    Expense(
        title: "Movie",
        amount: 60.00,
        date: DateTime.now(),
        category: Category.leisure),
  ];
  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(
      child: Text('No expense found, try adding some now'),
    );
    if (_expenseList.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _expenseList,
        onRemoveExpense: deleteExpense,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracker'),
        actions: [
          IconButton(
              onPressed: _openAddExpenseOverlay, icon: const Icon(Icons.add)),
        ],
      ),
      body: Column(
        children: [
          Chart(expenses: _expenseList),
          Expanded(
            child:
                mainContent, //column inside a column throws an error. to fix Expanded() is used
          )
        ],
      ),
    );
  }
}
