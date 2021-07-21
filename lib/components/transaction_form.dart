import 'package:flutter/material.dart';
import 'adaptative_button.dart';
import 'adaptative_textField.dart';
import 'adaptative_date_picker.dart';

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
              AdaptativeTextField(
                titleController: _titleController,
                label: 'Título',
                submitForm: _submitForm,
              ),
              AdaptativeTextField(
                titleController: _valueController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                label: 'Valor',
                submitForm: _submitForm,
              ),
              AdaptativeDatePicker(
                  selectedDate: _selectedDate,
                  onDateChange: (newDate) {
                    setState(() {
                      _selectedDate = newDate;
                    });
                  }),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AdaptativeButton(
                      label: 'Nova Transação', onPressed: _submitForm),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
