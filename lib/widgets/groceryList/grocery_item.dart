import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class GroceryItem extends StatefulWidget {
  const GroceryItem(this.grocery, this.onRemoveGroceries, this.onAddExpense,
      {super.key});

  final Expense grocery;
  final Function(Expense expense) onRemoveGroceries;
  final Function(Expense expense) onAddExpense;

  @override
  State<GroceryItem> createState() => _GroceryItemState();
}

class _GroceryItemState extends State<GroceryItem> {
  var _isChecked = false;

  void _removeGrocery(bool? isChecked) {
    setState(() {
      _isChecked = isChecked ?? false;
      widget.onRemoveGroceries(widget.grocery);
      widget.onAddExpense(widget.grocery);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            Checkbox(value: _isChecked, onChanged: _removeGrocery),
            Text(
              widget.grocery.title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    );
  }
}
