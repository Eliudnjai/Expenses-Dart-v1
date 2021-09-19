import 'package:flutter/cupertino.dart';
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
    return  transactions.isEmpty ? LayoutBuilder(builder: (ctx, constraints){
        return Column(
        children: [
          Text('No Transactions so far - Please add', style: Theme.of(context).textTheme.headline1,),
          SizedBox(
            height: 20,
          ),
          Container(
            height: constraints.maxHeight * 0.6,
            child: Image.asset('lib/assets/images/waiting.png', fit: BoxFit.cover,
            )
            ),
        ],
    );
    }) 
     : ListView.builder(itemBuilder: (ctx, index){
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
          style: TextStyle(
            fontSize: 20,
            color: Colors.blue,
            fontWeight: FontWeight.bold
          )),
          subtitle: Text(DateFormat.yMMMd().format(transactions[index].date), style: TextStyle(
            fontSize: 16
          ),),
          trailing: MediaQuery.of(context).size.width > 420 ? FlatButton.icon(onPressed: () => deletetx(transactions[index].id),
           label: Text('Delete'),
           textColor: Theme.of(context).errorColor,
            icon: Icon(Icons.delete)
            )
           :  IconButton(icon: Icon(Icons.delete,
          color: Theme.of(context).errorColor),
          onPressed: () => deletetx(transactions[index].id),
          ),
        )
      );
    },
    itemCount: transactions.length);
  }
}