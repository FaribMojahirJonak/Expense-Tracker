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
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            child: Text(expenses.title),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text('\$${expenses.amount.toStringAsFixed(2)}'),
              ),
              const Spacer(),
              Icon(categoryIcons[expenses.category]),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Text(expenses.formattedDate),
              ),
              
            ],
          ),
        ],
      ),
    );
  }
}
