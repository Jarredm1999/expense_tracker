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
    final screenWidth = MediaQuery.of(context).size.width;

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
                        Text(''),
                        Text('Budget Left:'),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('\$${monthlyBudget.toStringAsFixed(2)}'),
                      Text('- \$${totalExpenseValue.toStringAsFixed(2)}'),
                      SizedBox(
                        width: 60,
                        child: Divider(thickness: 1, color: Colors.black),
                      ),
                      Text(
                        '\$${budgetLeft.toStringAsFixed(2)}',
                        style: TextStyle(
                          color: budgetLeft <= 0 ? Colors.red : Colors.green,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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
