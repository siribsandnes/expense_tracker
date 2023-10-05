import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/groceryList/grocery_item.dart';
import 'package:flutter/material.dart';

class GroceryList extends StatelessWidget {
  const GroceryList({required this.groceries, super.key});

  final List<Expense> groceries;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: groceries.length,
      itemBuilder: (BuildContext context, index) {
        return Container(
          margin: const EdgeInsets.fromLTRB(0, 2, 0, 2),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
          height: 35,
          child: GroceryItem(groceries[index]),
        );
      },
    );
  }
}