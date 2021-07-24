import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();

  final _amountController = TextEditingController();

  DateTime? _selectedDate;

  void _submitData() {
    if(_amountController.text.isEmpty){
      return;
    }

    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate==null) {
      return;
    }
    widget.addTx(
      enteredTitle,
      enteredAmount,
      _selectedDate
    );

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2019),
        lastDate: DateTime.now()).then((pickedDate) {
          if(pickedDate==null){
            return;
          }
          setState(() {
            _selectedDate=pickedDate;
          });

    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
      ),
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextField(
            decoration: InputDecoration(labelText: 'Title'),
            controller: _titleController,
            onSubmitted: (_) => _submitData(),
          ),
          TextField(
            decoration: InputDecoration(labelText: 'Amount'),
            controller: _amountController,
            keyboardType: TextInputType.number,
            onSubmitted: (_) => _submitData(),
          ),
          Container(
            height: 70,
            child: Row(
              children: [
                Text( _selectedDate==null ? 'No Date Choosen! ' :  DateFormat.yMMMd().format(_selectedDate!)),
                SizedBox(
                  width: 20,
                ),
                OutlinedButton(
                  onPressed: _presentDatePicker,
                  child: Text('Choose Date',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  style: OutlinedButton.styleFrom(
                      primary: Colors.deepOrange,
                      backgroundColor: Colors.white,
                      side: BorderSide(color: Colors.deepOrange, width: 2),
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(20)))),
                )
              ],
            ),
          ),
          TextButton(
            onPressed: _submitData,
            child: Text('Add Transaction'),
            style: TextButton.styleFrom(
                primary: Colors.white, backgroundColor: Colors.deepOrange),
          )
        ],
      ),
    );
  }
}
