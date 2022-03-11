import 'package:flutter/material.dart';

class CriptoLabelPercentageWidget extends StatelessWidget {
  final double width;
  final double height;
  final double value;
  final bool isPositive;

  const CriptoLabelPercentageWidget({
    Key? key,
    required this.width,
    required this.height,
    required this.value,
    required this.isPositive,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        border: Border.all(
          color: isPositive ? Theme.of(context).colorScheme.primary : Theme.of(context).errorColor,
        ),
        borderRadius: const BorderRadius.only(
          bottomRight: Radius.circular(25),
          topLeft: Radius.circular(25),
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 7.5,
            color: isPositive ? Theme.of(context).colorScheme.primary : Theme.of(context).errorColor,
          )
        ],
      ),
      child: Center(
        child: Text(
          '${value.toStringAsFixed(2)}%',
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.w800,
                fontSize: 12.5,
                color: isPositive ? Theme.of(context).colorScheme.primary : Theme.of(context).errorColor,
              ),
        ),
      ),
    );
  }
}
