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
    return AnimatedContainer(
      duration: const Duration(seconds: 1),
      decoration: BoxDecoration(
        boxShadow: focusNode.hasFocus
            ? [
                BoxShadow(color: Theme.of(context).colorScheme.primary.withOpacity(.25), blurRadius: 20),
                BoxShadow(color: Theme.of(context).colorScheme.primary.withOpacity(.25), blurRadius: 10),
              ]
            : [],
      ),
      child: TextFormField(
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
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(
              color: focusNode.hasFocus ? Theme.of(context).colorScheme.primary : Colors.transparent,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
