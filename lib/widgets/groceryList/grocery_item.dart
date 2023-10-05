import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class GroceryItem extends StatefulWidget {
  const GroceryItem(this.grocery, {super.key});

  final Expense grocery;

  @override
  State<GroceryItem> createState() => _GroceryItemState();
}

class _GroceryItemState extends State<GroceryItem> {
  var _isChecked = false;

  void _removeGrocery(bool? isChecked) {
    setState(() {
      _isChecked = isChecked ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Checkbox(value: _isChecked, onChanged: _removeGrocery),
            Text(widget.grocery.title),
          ],
        ),
        Icon(categoryIcons[widget.grocery.category]),
      ],
    );
  }
}
