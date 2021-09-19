import 'dart:io';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_complete_guide/widgets/chart.dart';
import './widgets/new_transaction.dart';
import './modules/transaction.dart';
import './widgets/transaction_list.dart';

void main(){
   WidgetsFlutterBinding.ensureInitialized();
   SystemChrome.setPreferredOrientations([
     DeviceOrientation.portraitUp,
     DeviceOrientation.landscapeRight,
     DeviceOrientation.portraitDown,
     DeviceOrientation.landscapeLeft
   ]);
   runApp(MyApp());
   
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Personal Expenses',
      theme: ThemeData(primarySwatch: Colors.brown, 
      accentColor: Colors.yellow,
      fontFamily: 'Quicksand',
      textTheme: const TextTheme(headline1: TextStyle(
          fontFamily: 'Quicksand',
           fontWeight: FontWeight.bold,
            fontSize: 12,),
      button: TextStyle(color: Colors.white)),
      appBarTheme: AppBarTheme(
        textTheme: ThemeData().textTheme.copyWith(headline2: TextStyle(
          fontFamily: 'OpenSans',
           fontWeight: FontWeight.normal,
            fontSize: 13, color: Colors.white)), )),
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
    amount: 20.00,
    title: 'New shoes',
    date: DateTime.now()

  )
  ),
  Transaction(
    id: 't2',
    amount: 30.89,
    title: 'SkateBoard',
    date: DateTime.now()
  )
  
  ];

 bool _showChart = false;

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
    final mediaQuery = MediaQuery.of(context);
    final _islandScape = mediaQuery.orientation == Orientation.landscape;
    
    final appBar =  AppBar(
        title: Text('Personal Expenses'),
        actions: [IconButton(icon: Icon(Icons.add, size: 30,),
          onPressed: 
            () => _startAddNewTransaction(context)
          )
          ],
      );


    final txTransactionWidget = Container(
          height: (mediaQuery.size.height - appBar.preferredSize.height - mediaQuery.padding.top) * 0.5,
          child: TransactionList(_userTransactions, _deleteTransaction));
    return Scaffold(
      appBar: appBar,
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if(_islandScape) Row(
              mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('show chart'),
              Switch.adaptive(
                activeColor: Theme.of(context).accentColor,
                value: _showChart, onChanged: (val) {
                setState(() {
                  _showChart = val;
                                });
              },),
            ],
          ),
          if(!_islandScape)
          Container(
            height: (mediaQuery.size.height - appBar.preferredSize.height - mediaQuery.padding.top) * 0.2,
            child: Chart(_recentTransactions)),

            if(!_islandScape) txTransactionWidget,
          if(_islandScape)
          _showChart
           ? Container(
            height: (mediaQuery.size.height - appBar.preferredSize.height - mediaQuery.padding.top) * 0.4,
            child: Chart(_recentTransactions))
             : txTransactionWidget],
      ),
      floatingActionButtonLocation:  FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Platform.isIOS ? Container() : FloatingActionButton(child: Icon(Icons.add), onPressed: 
        () => _startAddNewTransaction(context)
        
      ),
    );
  }
}
