import 'package:flutter/material.dart';

class ElevatedButtonWidget extends StatelessWidget {
  final Icon? leftIcon;
  final Icon? rightIcon;

  const ElevatedButtonWidget({
    Key? key,
    this.leftIcon,
    this.rightIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(color: Theme.of(context).colorScheme.primary.withOpacity(.25), blurRadius: 20),
          BoxShadow(color: Theme.of(context).colorScheme.primary.withOpacity(.25), blurRadius: 10),
        ],
        borderRadius: BorderRadius.circular(50),
      ),
      child: ElevatedButton(
        child: Row(
          children: [
            if (leftIcon != null) leftIcon!,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Text(
                'Entrar',
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ),
            if (rightIcon != null) rightIcon!,
          ],
        ),
        onPressed: () {},
      ),
    );
  }
}
