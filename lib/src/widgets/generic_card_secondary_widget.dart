import 'package:flutter/material.dart';

class GenericCardSecondary extends StatelessWidget {
  final Widget child;
  const GenericCardSecondary({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(12.5),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: child,
      ),
    );
  }
}
