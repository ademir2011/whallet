import 'package:flutter/material.dart';

class OutlinedButtonWidget extends StatelessWidget {
  final String title;
  final void Function() onPressed;
  const OutlinedButtonWidget({
    Key? key,
    required this.onPressed,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 50,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: BorderSide(
            color: Theme.of(context).colorScheme.surface,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
        ),
        child: Text(
          title,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 12.5,
              ),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
