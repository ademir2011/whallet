import 'package:flutter/material.dart';
import 'package:whallet/src/widgets/cripto_label_percentage_widget.dart';
import 'package:whallet/src/widgets/cripto_label_title_widget.dart';

class CardPriceWidget extends StatelessWidget {
  final String tokenTitle;
  final double price;
  final double percentage;
  final Function()? onTap;
  const CardPriceWidget({
    Key? key,
    required this.tokenTitle,
    required this.price,
    required this.percentage,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: Theme.of(context).colorScheme.secondary,
          ),
          boxShadow: [
            BoxShadow(color: Theme.of(context).colorScheme.surface.withOpacity(.5), blurRadius: 5),
            BoxShadow(color: Theme.of(context).colorScheme.surface.withOpacity(.5), blurRadius: 2.5)
          ],
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              left: -1,
              top: -1,
              child: Align(
                alignment: Alignment.topLeft,
                child: CriptoLabelTitleWidget(
                  title: tokenTitle,
                  height: 45,
                  width: 110,
                ),
              ),
            ),
            Center(
              child: Text(
                '\$ $price',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            Positioned(
              bottom: -1,
              right: -1,
              child: Align(
                alignment: Alignment.bottomRight,
                child: CriptoLabelPercentageWidget(
                  value: percentage,
                  isPositive: percentage >= 0,
                  height: 45,
                  width: 75,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
