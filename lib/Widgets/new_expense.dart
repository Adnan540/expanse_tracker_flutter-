import 'package:flutter/material.dart';
import 'package:expense_tracker/Model/expense.dart';
class NewExpense extends StatefulWidget{
  //Constructor
  const NewExpense({super.key,required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;
  @override
  State<NewExpense> createState()=> _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense>{
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
    DateTime? _selectedDate;
    Category _selectedCategory = Category.leisure;

  void _presentDatePicker() async{
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month,now.day);
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now
      );
      setState(() {
        _selectedDate= pickedDate;
      });
  }

  void _submitExpenseData(){
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <=0;

    if(_titleController.text.trim().isEmpty ||amountIsInvalid || _selectedDate ==null){
      //show error message
      showDialog(
       context: context,
       builder: (ctx) =>AlertDialog(
        title: Text('Invalid Input'),
        content: Text('Please make sure a valid title , amount , date and category was entered..'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
            },
            child: Text('Okay'),
          )
        ],
       )
       );
       return;
    }
    widget.onAddExpense(Expense(
    title:_titleController.text,
    amount:enteredAmount,
    date: _selectedDate!,//won't be null
    category: _selectedCategory
       ),
  );
  Navigator.pop(context); //close pop up after adding our expense
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context){
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 48, 16, 16),
      child: Column(
        children: [
          //Title field
          TextField(
            controller: _titleController,
            maxLength: 50,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              label: Text('Title'),
            ),
          ),
          Row(
            children: [
          Expanded(
            child:TextField(
            controller: _amountController,
            maxLength:14,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              label: Text('Amount'),
              prefixText:'\$' 
            ),
          )
          ),
          SizedBox(width: 16,),
          Expanded(//because row inside of
            child: Row(//inner row
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(_selectedDate == null?'No date selected': formatter.format(_selectedDate!)),//! wont be null
                IconButton(
                  icon:Icon(Icons.calendar_month),
                  onPressed: () {
                    _presentDatePicker();
                  },
                )
              ],
            ),
          )
            ],

          ),
          SizedBox(height: 16,),
          Row(
            children: [
              DropdownButton(
               value: _selectedCategory, 
               items: Category.values.map(
                (category) =>DropdownMenuItem(
                  value: category,
                  child:Text(category.name.toString().toUpperCase(),),
                ),
               ).toList(),
             
               onChanged: (value){
                if(value == null){
                  return;
                }
                setState(() {
                  _selectedCategory = value;
                });
               }
               ),
               Spacer(),
              //Save Expense button
              ElevatedButton(
               onPressed: _submitExpenseData,
               child: Text('Save Expense')),
               //Cancel button
               TextButton(
                onPressed:() {
                  Navigator.pop(context);//remove overlay from screen
                },
                child:Text('Cancel editing')
                )
            ],
          ),
          
        ]
        ),
    );
  }
}