import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  final String? labelText;
  final IconData? suffixicon;
  final TextInputType? keyboardType;
  final bool obscureText;
  final String formProperty;
  final Map<String, dynamic> formValues;

  const CustomInputField({
    Key? key,
    this.labelText,
    this.suffixicon,
    this.keyboardType,
    required this.obscureText,
    required this.formProperty,
    required this.formValues,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: true,
      textCapitalization: TextCapitalization.words,
      onChanged: (value) => formValues,
      validator: (name) {
        if (name == null) return "Field required";
      },
      decoration: InputDecoration(
        //hintText: ,
        labelText: labelText,
        suffixIcon: Icon(suffixicon),
      ),
    );
  }
}
