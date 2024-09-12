import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();
final formatter = DateFormat.yMd();

class NewExpense extends StatefulWidget {
  const NewExpense(this.onNewExpense, {super.key});
  final void Function(Expense expense) onNewExpense;

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedTime;
  Category _selectedCatagory = Category.leisure;

  @override
  void dispose() {
    _amountController.dispose();
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 50, 15, 15),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            maxLength: 50,
            decoration: const InputDecoration(
              label: Text('Title'),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: _amountController,
                  maxLength: 15,
                  decoration: const InputDecoration(
                    prefixText: "\$ ",
                    label: Text("Amount"),
                  ),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(_selectedTime == null
                        ? "No Time Selected"
                        : formatter.format(_selectedTime!)),
                    IconButton(
                      onPressed: () async {
                        final now = DateTime.now();

                        final firstDate =
                            DateTime(now.year - 1, now.month, now.day);
                        final pickedDate = await showDatePicker(
                            context: context,
                            firstDate: firstDate,
                            lastDate: now);
                        setState(() {
                          _selectedTime = pickedDate;
                        });
                      },
                      icon: const Icon(Icons.calendar_month),
                    ),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              DropdownButton(
                  value: _selectedCatagory,
                  items: Category.values
                      .map(
                        (catagory) => DropdownMenuItem(
                          value: catagory,
                          child: Text(catagory.name.toUpperCase()),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value == null) {
                      return;
                    }
                    setState(() {
                      _selectedCatagory = value;
                    });
                  }),
              const Spacer(),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: () {
                  final selectedAmount =
                      double.tryParse(_amountController.text);
                  final amountIsInvalid =
                      selectedAmount == null || selectedAmount <= 0;
                  if (amountIsInvalid ||
                      _amountController.text.trim().isEmpty ||
                      _selectedTime == null) {
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: const Text('Invalid input!'),
                        content: const Text('Please enter valid informations.'),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(ctx);
                              },
                              child: const Text('Okay'))
                        ],
                      ),
                    );
                    return;
                  }
                  widget.onNewExpense(
                    Expense(
                        title: _titleController.text,
                        amount: selectedAmount,
                        date: _selectedTime!,
                        category: _selectedCatagory),
                  );
                  Navigator.pop(context);
                },
                child: const Text("Save Expense"),
              ),
            ],
          )
        ],
      ),
    );
  }
}
