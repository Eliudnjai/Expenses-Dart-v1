import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


//This is where we work with input and submit - to add new transactions

class NewTranscation extends StatefulWidget {
  final Function addTx;

  NewTranscation(this.addTx);

  @override
  _NewTranscationState createState() => _NewTranscationState();
}

class _NewTranscationState extends State<NewTranscation> {
  final _titleController = TextEditingController();
  DateTime _datePicked;

  final _amountController = TextEditingController();

  void _submitData(){
    final enterText = _titleController.text;
    final enterAmount = double.parse(_amountController.text);

  if(enterText.isEmpty || enterAmount <= 0 || _datePicked == null){
    return;
  }
    widget.addTx(enterText, enterAmount, _datePicked);

    Navigator.of(context).pop();
  }
  

  void _presentDatePicker(){
      showDatePicker(context: context,
       initialDate: DateTime.now(),
       firstDate: DateTime(2021),
       lastDate: DateTime.now(),).then((pickedDate) {
        if(pickedDate == null){
         return;
         }
          setState(() {
            _datePicked = pickedDate;
                    }); 
        });
  }

  @override
  Widget build(BuildContext context) {
    return
   //User Input
          Card(
            elevation: 2.5,
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children:
                  [
                    TextField(decoration: InputDecoration(labelText: 'Title'), controller: _titleController,
                    onSubmitted: (_) => _submitData(),
                    ),
                    TextField(decoration: InputDecoration(labelText: 'Amount'), controller: _amountController,
                    keyboardType: TextInputType.number,
                    onSubmitted: (_) => _submitData(),
                    ),

                    Container(
                      height: 70,
                      child: Row(
                        children: [
                          Expanded(child: Text(_datePicked == null ? 'No date chosen!' : 'Picked date ${DateFormat.yMd().format(_datePicked)}')),
                          FlatButton(onPressed: _presentDatePicker,
                          child: Text('Select date',
                           style: TextStyle(fontWeight: FontWeight.bold),),
                          textColor: Theme.of(context).primaryColor,)
                        ],
                      ),
                    ),
                    RaisedButton(onPressed: _submitData, 
                    child: Text('Add Transaction',),
                    color: Theme.of(context).primaryColor,
                    textColor: Theme.of(context).textTheme.button.color,
                  )],),
                ),
          );
  }
}