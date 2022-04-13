import 'package:flutter/material.dart';

class GenericCardPrimaryWidget extends StatelessWidget {
  final String title;
  const GenericCardPrimaryWidget({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Theme.of(context).colorScheme.surface,
        ),
        boxShadow: const [
          BoxShadow(color: Color(0x44ffffff), blurRadius: 7.5),
          BoxShadow(color: Color(0x44ffffff), blurRadius: 5)
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
