import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:oh_my_expenses/models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return Container(

      height: MediaQuery
          .of(context)
          .size
          .height * 0.6,
      child: transactions.isEmpty
          ? Column(
        children: [
          SizedBox(
            height: 30,
          ),
          Container(
              height: 200,
              child: Image.asset(
                'assets/images/money_full.png',
                fit: BoxFit.cover,
              )),
          Text(
            'No Expenses',
            style: TextStyle(fontSize: 30),
          ),
        ],
      )
          : ListView.builder(
        itemBuilder: (ctx, index) {
          return Card(
            elevation: 10,
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            child: ListTile(
                leading: CircleAvatar(
                  radius: 30,
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: FittedBox(
                        child: Text('\$${transactions[index].amount}')),
                  ),
                ),
                title: Text(
                  transactions[index].title,
                  style: TextStyle(
                      color: Colors.deepOrange, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                    DateFormat.yMMMd().format(transactions[index].date)),

                trailing: IconButton(icon: Icon(Icons.delete), color: Colors.red,onPressed: (){ deleteTx(transactions[index].id);})


            ),
          );
        },
        itemCount: transactions.length,
      ),
    );
  }
}
