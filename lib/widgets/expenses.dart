import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/widgets/groceries_List/grocery_list.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:expense_tracker/widgets/new_grocery.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/chart/chart.dart';

//Represeents an expense.
class Expenses extends StatefulWidget {
  const Expenses({super.key});
  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

//Represents an expenseState
class _ExpensesState extends State<Expenses> {
  //Creates some dummy expenses to use
  final List<Expense> _registeredExpenses = [
    Expense(
      title: 'Flutter Course',
      amount: 15.99,
      date: DateTime.now(),
      category: Category.work,
    ),
    Expense(
      title: 'Beef',
      amount: 12.49,
      date: DateTime.now(),
      category: Category.food,
    ),
    Expense(
      title: 'Train tickets',
      amount: 5.99,
      date: DateTime.now(),
      category: Category.travel,
    ),
  ];
// Creates some dummy groceries to use
  final List<Expense> _registredGroceries = [
    Expense(
      title: 'Bread',
      amount: 2.99,
      date: DateTime.now(),
      category: Category.food,
    ),
    Expense(
      title: 'Milk',
      amount: 1.99,
      date: DateTime.now(),
      category: Category.food,
    ),
  ];

//Opens the add expense overlay
  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(onAddExpense: _addExpense),
    );
  }

//opens the addGrocery overlay
  void _openAddGroceryOverlay() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewGrocery(onAddGrocery: _addGrocery),
    );
  }

//Adds an expense to the expense lits
  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

//Adds a grocery to the grocery list
  void _addGrocery(Expense grocery) {
    setState(() {
      _registredGroceries.add(grocery);
    });
  }

//removes a grocery from the grocery list
  void _removeGrocery(Expense grocery) {
    setState(() {
      _registredGroceries.remove(grocery);
    });
  }

//Removes an expense from the expense list and shows a snackbar with
//the option to regret the removal of the expense and add it back to the list
  void _removeExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 5),
        content: const Text('Expense deleted'),
        action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              setState(() {
                _registeredExpenses.insert(expenseIndex, expense);
              });
            }),
      ),
    );
  }

//Builds the "main screen" of the application. Creates different widgets based on the screen size.
  @override
  Widget build(BuildContext context) {
    //
    final width = MediaQuery.of(context).size.width;

    //
    Widget mainContent = const Center(
      child: Text('No expenses found, start adding some'),
    );

    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registeredExpenses,
        onRemoveExpense: _removeExpense,
      );
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('Flutter Expense Tracker'),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: width < 600
          ? Column(
              children: [
                Chart(expenses: _registeredExpenses),
                Expanded(
                  flex: 1,
                  child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        gradient: LinearGradient(
                          colors: [
                            Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.3),
                            Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.0)
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                      margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      height: 150,
                      child: ListView(
                        children: [
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  const Text(
                                    'Grocery List',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  ElevatedButton(
                                    onPressed: _openAddGroceryOverlay,
                                    style: ElevatedButton.styleFrom(
                                        shape: const CircleBorder(),
                                        foregroundColor: Theme.of(context)
                                            .colorScheme
                                            .primary),
                                    child: const Icon(Icons.add),
                                  ),
                                ],
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8)),
                                height: 140,
                                child: GroceryList(
                                  groceries: _registredGroceries,
                                  onRemoveGroceries: _removeGrocery,
                                  onAddExpense: _addExpense,
                                ),
                              )
                            ],
                          ),
                        ],
                      )),
                ),
                Expanded(
                  flex: 2,
                  child: mainContent,
                ),
              ],
            )
          : Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Expanded(child: Chart(expenses: _registeredExpenses)),
                      Expanded(
                        flex: 1,
                        child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              gradient: LinearGradient(
                                colors: [
                                  Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withOpacity(0.3),
                                  Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withOpacity(0.0)
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                            ),
                            margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                            height: 150,
                            child: ListView(
                              children: [
                                Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        const Text(
                                          'Grocery List',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        ElevatedButton(
                                          onPressed: _openAddGroceryOverlay,
                                          style: ElevatedButton.styleFrom(
                                              shape: const CircleBorder(),
                                              foregroundColor: Theme.of(context)
                                                  .colorScheme
                                                  .primary),
                                          child: const Icon(Icons.add),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      height: 140,
                                      child: GroceryList(
                                        groceries: _registredGroceries,
                                        onRemoveGroceries: _removeGrocery,
                                        onAddExpense: _addExpense,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            )),
                      ),
                    ],
                  ),
                ),

                //Her må handleliste komme
                Expanded(
                  child: mainContent,
                ),
              ],
            ),
    );
  }
}
