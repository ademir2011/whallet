import 'package:flutter/material.dart';
import 'package:whallet/src/widgets/elevated_button_widget.dart';

class AuthFooterWidget extends StatelessWidget {
  final String title;
  final bool isLoading;

  final void Function() onPressed;
  const AuthFooterWidget({
    Key? key,
    required this.onPressed,
    required this.isLoading,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AnimatedOpacity(
          opacity: isLoading ? 0 : 1,
          duration: const Duration(seconds: 1),
          child: IconButton(
            padding: EdgeInsets.zero,
            alignment: Alignment.centerLeft,
            iconSize: 50,
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back_rounded,
            ),
          ),
        ),
        ElevatedButtonWidget(
          isLoading: isLoading,
          title: title,
          onPressed: onPressed,
        ),
      ],
    );
  }
}
