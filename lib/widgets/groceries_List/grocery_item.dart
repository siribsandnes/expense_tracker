import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

//Represents a GroceryItem
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

//Checks if the grocery is ticked off or not. If it is ticked off the checkbox is set to checked
//and another function (_removeGroceryItem) is called
  void _removeGrocery(bool? isChecked) {
    setState(() {
      _isChecked = isChecked ?? false;
      _removeGroceryItem();
    });
  }

  //Remoces a grocery item from the grocery lsit and adds the romved item to the expense list.
  void _removeGroceryItem() {
    Future.delayed(const Duration(milliseconds: 400)).then((val) {
      widget.onRemoveGroceries(widget.grocery);
      widget.onAddExpense(widget.grocery);
      _isChecked = false;
    });
  }

// Creates and returns a groceryitem widget.
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
