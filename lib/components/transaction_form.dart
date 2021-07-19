import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime) onSubmit;

  TransactionForm(this.onSubmit);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  late DateTime _selectedDate = DateTime(1800);

  _submitForm() {
    final newTitle = _titleController.text;
    final newValue = double.tryParse(_valueController.text) ?? 0.0;
    if (newTitle.isEmpty || newValue <= 0 || _selectedDate == DateTime(1800)) {
      return;
    }
    widget.onSubmit(newTitle, newValue, _selectedDate);
  }

  _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }

      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.only(
            top: 10,
            right: 10,
            left: 10,
            bottom: 10 + MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _titleController,
                onSubmitted: (_) => _submitForm(),
                decoration: InputDecoration(
                  labelText: 'Título',
                ),
              ),
              TextField(
                controller: _valueController,
                onSubmitted: (_) => _submitForm(),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  labelText: 'Valor (R\$)',
                ),
              ),
              Container(
                height: 70,
                child: Row(
                  children: [
                    // ignore: unnecessary_null_comparison
                    Text(_selectedDate == DateTime(1800)
                        ? 'Nenhuma data informada'
                        : DateFormat('d MMM y').format(_selectedDate)),
                    TextButton(
                      style: TextButton.styleFrom(
                          textStyle:
                              TextStyle(color: Theme.of(context).primaryColor)),
                      onPressed: _showDatePicker,
                      child: Text(
                        'Selecionar data',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateColor.resolveWith(
                            (_) => Theme.of(context).primaryColor)),
                    onPressed: _submitForm,
                    child: Text(
                      'Nova transação',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
