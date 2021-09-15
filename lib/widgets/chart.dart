import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/widgets/chart-bar.dart';
import '../modules/transaction.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {

final List<Transaction>recentTransaction;

Chart(this.recentTransaction);


List<Map<String, Object>> get getGroupTransactions {


    return List.generate(7, (index) {

    final weekday = DateTime.now().subtract(Duration(days: index),);

    var totalSum = 0.00;

    for(var i = 0; i<recentTransaction.length; i++){

      if(recentTransaction[i].date.day == weekday.day 
      && recentTransaction[i].date.month == weekday.month
      && recentTransaction[i].date.year == weekday.year){
        totalSum += recentTransaction[i].amount;
      }
    }
        return {'day': DateFormat.E().format(weekday).substring(0, 1), 'amount': totalSum}; 
    }).reversed.toList();
}

    double get totalSpending{
      return getGroupTransactions.fold(0.0, (sum, items) => sum + items['amount']);
    }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children:
            getGroupTransactions.map((data) {
              return Flexible(
                fit: FlexFit.tight,
                child: ChartBar(data['day'],
                                data['amount'],
                                totalSpending == 0.0 ? 0.0 : (data['amount'] as double) / totalSpending),
              );
            }).toList()
        ),
      ),
    );
  }
}