import 'package:flutter/material.dart';

import 'package:expense_tracker/models/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense(this.addExpense, {super.key});

  final void Function(Expense newEpense) addExpense;

  @override
  State<StatefulWidget> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  ExpenseCategory _selectedCategory = ExpenseCategory.leisure;

  void _presentDatePicker() async {
    final todayDate = DateTime.now();
    final firstDate = DateTime(
      todayDate.year - 1,
      todayDate.month,
      todayDate.day,
    );

    final pickedDate = await showDatePicker(
      context: context,
      firstDate: firstDate,
      lastDate: todayDate,
    );

    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_amountController.text);
    if (_titleController.text.trim().isEmpty) {
      showErrorDialog(errorContent: 'Please Enter A Valid Title.');
      return;
    } else if (enteredAmount == null || enteredAmount <= 0) {
      showErrorDialog(errorContent: 'Please Enter A Valid Amount.');
      return;
    } else if (_selectedDate == null) {
      showErrorDialog(errorContent: 'Please Enter A Valid Date.');
      return;
    }

    final Expense newEpense = Expense(
      title: _titleController.text,
      amount: enteredAmount,
      date: _selectedDate!,
      category: _selectedCategory,
    );

    widget.addExpense(newEpense);
    Navigator.pop(context);
  }

  void showErrorDialog({required String errorContent}) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Could Not Save'),
        content: Text(errorContent),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Okay'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
      child: Column(
        children: [
          TextField(
            maxLength: 50,
            controller: _titleController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              label: Text(
                'Title',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    prefixText: '\$',
                    label: Text(
                      'Amount',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  controller: _amountController,
                ),
              ),
              SizedBox(width: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    _selectedDate == null
                        ? 'No Date Selected'
                        : formatter.format(_selectedDate!),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  IconButton(
                    onPressed: _presentDatePicker,
                    icon: const Icon(Icons.calendar_month),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              DropdownButton(
                value: _selectedCategory,
                items: ExpenseCategory.values
                    .map(
                      (category) => DropdownMenuItem(
                        value: category,
                        child: Text(
                          category.name.toUpperCase(),
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value == null) {
                    return;
                  }
                  setState(() {
                    _selectedCategory = value;
                  });
                },
              ),
              const Spacer(),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: _submitExpenseData,
                child: Text('Save Expense'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
