import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final String? Function(String?) validator;
  final Icon? icon;
  final FocusNode focusNode;
  final bool isPassword;
  final TextInputAction textInputAction;
  final void Function(String)? onSubmitted;

  const TextFormFieldWidget({
    Key? key,
    required this.hintText,
    required this.focusNode,
    this.icon,
    this.textInputAction = TextInputAction.next,
    this.onSubmitted,
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
      textInputAction: textInputAction,
      onFieldSubmitted: onSubmitted ?? (_) {},
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
            color: Theme.of(context).colorScheme.primary,
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
            color: Theme.of(context).errorColor,
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
