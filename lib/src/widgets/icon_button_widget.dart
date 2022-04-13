import 'package:flutter/material.dart';

class IconButtonWidget extends StatelessWidget {
  final Color color;
  final IconData icon;
  final void Function() onPressed;

  const IconButtonWidget({
    Key? key,
    required this.color,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      width: 35,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(12.5),
        border: Border.all(
          color: color,
        ),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(
          icon,
          size: 20,
          color: color,
        ),
        padding: EdgeInsets.zero,
      ),
    );
  }
}
