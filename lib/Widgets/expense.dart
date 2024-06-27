import 'package:expense_tracker/Model/expense.dart';
import 'package:expense_tracker/Widgets/expenses-list/expense_list.dart';
import 'package:expense_tracker/Widgets/new_expense.dart';
import 'package:flutter/material.dart';

//createState
class Expenses extends StatefulWidget{
  @override
  State<Expenses> createState()=> _ExpensesState();
}

class _ExpensesState extends State<Expenses>{
  //list of expenses dummy data
  final List<Expense> _registeredExpenses = [
    Expense(
      title: 'Cinema',
      amount: 20,
      date: DateTime.now(),
      category: Category.leisure
    ),
    Expense(
      title: 'Macdonalds',
      amount: 9.89,
      date: DateTime.now(),
      category: Category.food
    ),
  ];

  void _openAddExpenseOverlay(){
    showModalBottomSheet(
     isScrollControlled: true,
     context:context,
     builder: (ctx)=> NewExpense(onAddExpense:_addExpense),
     );
  }
 
  void _addExpense(Expense expense){
    setState(() {
    _registeredExpenses.add(expense);  
    });
  }
  void _removeExpense(Expense expense){
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content:Text('Expense Deleted'),
      duration: Duration(seconds: 3),
      action: SnackBarAction(
        label: 'undo',
        onPressed: () {//when undo pressed
          setState(() {
            _registeredExpenses.insert(expenseIndex,expense);
          });
        },
      ), 
      )
      );
  }

  @override
  Widget build(BuildContext context){
    Widget mainContent = Center(child: Text('No expenses found ,start adding some!'),);
    if(_registeredExpenses.isNotEmpty){
      mainContent = ExpenseList(
          expenses:_registeredExpenses ,
          onRemoveExpense: _removeExpense,
          );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter ExpenseTracker'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _openAddExpenseOverlay
          )
        ],
      ),
      body: Column(
        children: [
          //Toolbar with add button
          Text('The Chart'),
        Expanded(child: 
        mainContent
          ),
      ]
      ),
    );
  }
}