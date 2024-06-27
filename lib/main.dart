import 'package:expense_tracker/Widgets/expense.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(
     MaterialApp(
      
      debugShowCheckedModeBanner: false,                                               
      home: Expenses(),
    )
  );
}