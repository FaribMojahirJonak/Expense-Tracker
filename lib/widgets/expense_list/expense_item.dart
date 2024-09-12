import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem(this.expenses, {super.key});

  final Expense expenses;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Text(expenses.title),
          ),
          Row(
            children: [
              Text('\$${expenses.amount.toStringAsFixed(2)}'),
              const Spacer(),
              Icon(categoryIcons[expenses.category]),
              Text(expenses.formattedDate),
              
            ],
          ),
        ],
      ),
    );
  }
}
