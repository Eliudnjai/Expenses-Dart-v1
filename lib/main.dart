import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/widgets/chart.dart';
import './widgets/new_transaction.dart';
import './modules/transaction.dart';
import './widgets/transaction_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Personal Expenses',
      theme: ThemeData(primarySwatch: Colors.brown, 
      accentColor: Colors.yellow,
      fontFamily: 'Quicksand',
      textTheme: ThemeData().textTheme.copyWith(title: TextStyle(
          fontFamily: 'Quicksand',
           fontWeight: FontWeight.bold,
            fontSize: 12,),
      button: TextStyle(color: Colors.white)),
      appBarTheme: AppBarTheme(
        textTheme: ThemeData().textTheme.copyWith(title: TextStyle(
          fontFamily: 'OpenSans',
           fontWeight: FontWeight.bold,
            fontSize: 18, color: Colors.white)), )),
      home: MyHomePage(),
    );
  }
}


class MyHomePage extends StatefulWidget {

  // create a new transaction pop up sheet
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

 

class _MyHomePageState extends State<MyHomePage> {
  
   final List<Transaction>_userTransactions = [
  (Transaction(
    id: 't1',
    amount: 200.00,
    title: 'New shoes',
    date: DateTime.now()

  )
  ),
  Transaction(
    id: 't2',
    amount: 300.89,
    title: 'SkateBoard',
    date: DateTime.now()
  )
  
  ];

  List<Transaction> get _recentTransactions  {
    return _userTransactions.where((tx) {
      return  tx.date.isAfter(
          DateTime.now().subtract(Duration(days: 7))
        );
    }).toList();
  }
     

void _addNewTransaction(String txTitle, double txAmount, DateTime addDate){
  final newTx = Transaction(
    title: txTitle,
    amount: txAmount,
    date: addDate,
    id: DateTime.now().toString()
    );

    setState((){
      _userTransactions.add(newTx);
    });
}


  void _startAddNewTransaction(BuildContext ctx){
    showModalBottomSheet(context: ctx, builder: (_){
          
          return NewTranscation(_addNewTransaction);
    },);
  }

  void _deleteTransaction(String id){
        setState(() {
                  _userTransactions.removeWhere((element) => element.id == id);
                });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Expenses'),
        actions: [IconButton(icon: Icon(Icons.add, size: 20,),
          onPressed: 
            () => _startAddNewTransaction(context)
          )
          ],
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            child: 
            Chart(_recentTransactions)
          ),
        
        Expanded(child:
         TransactionList(_userTransactions, _deleteTransaction),
         )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(child: Icon(Icons.add), onPressed: 
        () => _startAddNewTransaction(context)
        
      ),
    );
  }
}
