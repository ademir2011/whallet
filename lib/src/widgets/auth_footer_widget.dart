import 'package:flutter/material.dart';
import 'package:whallet/src/widgets/elevated_button_widget.dart';

class AuthFooterWidget extends StatelessWidget {
  final String title;

  final void Function() onPressed;
  const AuthFooterWidget({
    Key? key,
    required this.onPressed,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_rounded,
            size: 40,
          ),
        ),
        ElevatedButtonWidget(
          title: title,
          onPressed: onPressed,
        ),
      ],
    );
  }
}
