import 'package:expense_tracker/Model/expense.dart';
import 'package:expense_tracker/Widgets/expenses-list/expense_item.dart';
import 'package:flutter/material.dart';

class ExpenseList extends StatelessWidget{
  const ExpenseList({
    super.key,
    required this.expenses,
    required this.onRemoveExpense
  });

  final List<Expense> expenses;
  final void Function(Expense expense) onRemoveExpense;
  @override
  Widget build(BuildContext context){
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (ctx,index) => Dismissible(//swipe remove
        onDismissed:(direction){
          onRemoveExpense(expenses[index]);
        } ,
        key: ValueKey(expenses[index]),
        child: ExpenseItem(expense: expenses[index]),
        )
      );
  }
}