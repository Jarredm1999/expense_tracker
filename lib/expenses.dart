import 'package:expense_tracker/widgets/expenses_list.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
      title: 'Flutter Course',
      amount: 19.99,
      date: DateTime.now(),
      category: ExpenseCategory.work,
    ),
    Expense(
      title: 'Gym Membership',
      amount: 34.99,
      date: DateTime.now(),
      category: ExpenseCategory.leisure,
    ),
  ];

  void _addExpense(Expense newEpense) {
    _registeredExpenses.add(newEpense);
    setState(() {
      _registeredExpenses;
    });
  }

  void _removeExpense(Expense removedExpense) {
    final removedItemIndex = _registeredExpenses.indexOf(removedExpense);
    setState(() {
      _registeredExpenses.remove(removedExpense);
    });

    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 3),
        content: Text('Expense Deleted'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(removedItemIndex, removedExpense);
            });
          },
        ),
        persist: false,
      ),
    );
  }

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(_addExpense),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = _registeredExpenses.isEmpty
        ? Center(
            child: Text(
              'No Expenses Found. Click the + in the top right corner to start adding some!',
              textAlign: TextAlign.center,
            ),
          )
        : ExpensesList(
            onRemoveExpense: _removeExpense,
            expenses: _registeredExpenses,
          );

    return Scaffold(
      appBar: AppBar(
        title: Text('Expense Tracker'),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          Text('The chart'),
          Expanded(child: mainContent),
        ],
      ),
    );
  }
}
