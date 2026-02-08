import 'package:flutter/material.dart';

class MonthlyBudget extends StatelessWidget {
  const MonthlyBudget({
    required this.monthlyBudget,
    required this.budgetLeft,
    required this.totalExpenseValue,
    super.key,
  });

  final double monthlyBudget;
  final double budgetLeft;
  final double totalExpenseValue;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Monthly Budget',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 10,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('Starting Budget:'),
                        Text('Total Expense Value:'),
                        Text('Budget Left:'),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('\$${monthlyBudget.toStringAsFixed(2)}'),
                      Text('\$${totalExpenseValue.toStringAsFixed(2)}'),
                      Text('\$${budgetLeft.toStringAsFixed(2)}'),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
