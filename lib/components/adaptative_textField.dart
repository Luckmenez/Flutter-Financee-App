import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class AdaptativeTextField extends StatelessWidget {
  final TextEditingController titleController;
  final TextInputType keyboardType;
  final String label;
  final Function submitForm;

  AdaptativeTextField({
    required this.titleController,
    required this.label,
    required this.submitForm,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoTextField(
            controller: titleController,
            keyboardType: keyboardType,
            onSubmitted: (_) => submitForm,
            placeholder: label,
          )
        : TextField(
            controller: titleController,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              labelText: label,
            ),
            onSubmitted: (_) => submitForm(),
          );
  }
}
