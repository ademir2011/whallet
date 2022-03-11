import 'package:flutter/material.dart';
import 'package:whallet/src/widgets/cripto_label_percentage_widget.dart';
import 'package:whallet/src/widgets/cripto_label_title_widget.dart';

class CardPriceWidget extends StatelessWidget {
  final String tokenTitle;
  final double price;
  const CardPriceWidget({
    Key? key,
    required this.tokenTitle,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: Theme.of(context).colorScheme.surface,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: CriptoLabelTitleWidget(
              title: tokenTitle,
              height: 35,
              width: 70,
            ),
          ),
          Text(
            '\$ $price',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: CriptoLabelPercentageWidget(
              value: 0.0,
              isPositive: true,
              height: 37.5,
              width: 70,
            ),
          ),
        ],
      ),
    );
  }
}
