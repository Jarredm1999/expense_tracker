import 'package:flutter/material.dart';

import 'package:expense_tracker/widgets/expenses_list.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:expense_tracker/monthly_budget.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  late MonthlyBudget budgetWidget;
  double _totalExpenseValue = 0;

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
    updateBudget(newEpense.amount);
    setState(() {
      _registeredExpenses;
    });
  }

  void _removeExpense(Expense removedExpense) {
    final removedItemIndex = _registeredExpenses.indexOf(removedExpense);
    updateBudget(-1 * removedExpense.amount);
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
              updateBudget(removedExpense.amount);
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

  final double _monthlyBudget = 4000;

  double get monthlyBudget {
    return _monthlyBudget;
  }

  @override
  void initState() {
    double budgetLeft = monthlyBudget;
    for (var expense in _registeredExpenses) {
      budgetLeft -= expense.amount;
      _totalExpenseValue += expense.amount;
    }
    budgetWidget = MonthlyBudget(
      monthlyBudget: monthlyBudget,
      budgetLeft: budgetLeft,
      totalExpenseValue: _totalExpenseValue,
    );
    super.initState();
  }

  void updateBudget(double expenseAmount) {
    _totalExpenseValue += expenseAmount;
    final updatedBudget = monthlyBudget - _totalExpenseValue;
    setState(() {
      budgetWidget = MonthlyBudget(
        monthlyBudget: monthlyBudget,
        budgetLeft: updatedBudget,
        totalExpenseValue: _totalExpenseValue,
      );
    });
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
        title: Text('Expense Tracker', textAlign: TextAlign.start),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          Row(children: [budgetWidget]),
          Text('The chart'),
          Expanded(child: mainContent),
        ],
      ),
    );
  }
}
