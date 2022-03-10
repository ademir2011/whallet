import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final String? Function(String?) validator;
  final Icon? icon;
  final FocusNode focusNode;
  final bool isPassword;

  const TextFormFieldWidget({
    Key? key,
    required this.hintText,
    required this.focusNode,
    this.icon,
    this.isPassword = false,
    required this.controller,
    required this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      focusNode: focusNode,
      obscureText: isPassword,
      decoration: InputDecoration(
        fillColor: Theme.of(context).cardColor,
        filled: true,
        prefixIcon: icon,
        hintText: hintText,
        hintStyle: Theme.of(context).textTheme.bodyMedium,
        focusColor: Colors.red,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(
            color: focusNode.hasFocus ? Theme.of(context).colorScheme.primary : Colors.transparent,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(
            color: Theme.of(context).errorColor,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(
            color: focusNode.hasFocus ? Theme.of(context).errorColor : Colors.transparent,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
