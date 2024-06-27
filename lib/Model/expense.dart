import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

enum Category{travel,leisure,food,work}
final uuid =  Uuid();//Generate unique ID
final formatter = DateFormat.yMd();//format dates
var categoryIcons ={
 Category.food: Icons.dinner_dining,
 Category.work: Icons.work,
 Category.leisure: Icons.movie,
 Category.travel: Icons.flight
};

class Expense{
//Constructor  
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category
  }) : id = uuid.v4(); // when ever object created it will generate unique id

  final Category category;
  final String id;
  final String title;
  final double amount;
  final DateTime date; //special datatype
  
//getter
 String get formattedDate{
  return formatter.format(date);
 }
} 