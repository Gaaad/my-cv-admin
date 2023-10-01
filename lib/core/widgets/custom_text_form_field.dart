import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? Function(String? val)? validator;
  int? maxLine = 1;

  CustomTextFormField({
    super.key,
    required this.controller,
    required this.label,
    this.maxLine,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.text,
      style: Theme.of(context).textTheme.bodyMedium!,
      maxLines: maxLine,
      validator: validator,
      decoration: InputDecoration(
        alignLabelWithHint: true,
        label: Text(label),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(9),
        ),
      ),
    );
  }
}
