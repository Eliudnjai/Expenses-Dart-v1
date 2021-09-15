import 'package:flutter/material.dart';
import '../modules/transaction.dart';
import 'package:intl/intl.dart';


//This widget shows transactions.


class TransactionList extends StatelessWidget {

  final List<Transaction>transactions;
  final Function deletetx;

  TransactionList(this.transactions, this.deletetx);


  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 450,
          //if the transaction is empty - we render an image.
      child: transactions.isEmpty ? Column(
          children: [
            Text('No Transactions so far - Please add', style: Theme.of(context).textTheme.title,),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 250,
              child: Image.asset('lib/assets/images/waiting.png', fit: BoxFit.cover,)),
          ],
      ) : ListView.builder(itemBuilder: (ctx, index){
        return Card(
          elevation: 8,
          margin: EdgeInsets.symmetric(horizontal: 3, vertical: 5),
          child: ListTile(
            leading: CircleAvatar(radius: 30,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FittedBox(
                child: Text('\$${transactions[index].amount}')),
            ),),
            title: Text(transactions[index].title,
            style: Theme.of(context).textTheme.title,),
            subtitle: Text(DateFormat.yMMMd().format(transactions[index].date),),
            trailing:  IconButton(icon: Icon(Icons.delete,
            color: Theme.of(context).errorColor),
            onPressed: () => deletetx(transactions[index].id),
            ),
          )
        );
      },
      itemCount: transactions.length)
    );
  }
}