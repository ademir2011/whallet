import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whallet/utils/change_theme.dart';

class CriptoLabelTitleWidget extends StatelessWidget {
  final double width;
  final double height;
  final String title;

  const CriptoLabelTitleWidget({
    Key? key,
    required this.title,
    required this.width,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Provider.of<ChangeTheme>(context).switchTheme
            ? Theme.of(context).cardColor
            : Theme.of(context).scaffoldBackgroundColor,
        border: Border.all(
          color: Theme.of(context).colorScheme.surface,
        ),
        borderRadius: const BorderRadius.only(
          bottomRight: Radius.circular(25),
          topLeft: Radius.circular(25),
        ),
      ),
      child: Center(
        child: Text(
          title,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                fontWeight: FontWeight.w800,
              ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
