import 'package:flutter/material.dart';
import 'package:oh_my_expenses/models/transaction.dart';
import 'package:intl/intl.dart';

class Chart extends StatefulWidget {

  late final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);


  @override
  _ChartState createState() => _ChartState();
}

class _ChartState extends State<Chart> {



  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      var totalSum = 0.0;

      for (var i = 0; i < widget.recentTransactions.length; i++) {
        if (widget.recentTransactions[i].date.day == weekDay.day &&
            widget.recentTransactions[i].date.month == weekDay.month &&
            widget.recentTransactions[i].date.year == weekDay.year) {
          totalSum += widget.recentTransactions[i].amount;
        }
      }

      print(DateFormat.E().format(weekDay));
      print(totalSum);

      return {'day': DateFormat.E().format(weekDay), 'amount': totalSum};
    });
  }



  @override
  Widget build(BuildContext context) {
    print(groupedTransactionValues);

    return Card(elevation: 6, margin: EdgeInsets.all(20), child: Row(
      children:
        groupedTransactionValues.map((data){

          return Text('${data['day']}:${data['amount']}');

        }).toList(),
    ));
  }
}
