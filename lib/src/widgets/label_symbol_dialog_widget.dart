import 'package:flutter/material.dart';

class LabelSymbolDialogWidget extends StatelessWidget {
  final String symbleName;
  final bool selected;
  final void Function() onTap;

  const LabelSymbolDialogWidget({
    Key? key,
    required this.symbleName,
    required this.onTap,
    required this.selected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: selected ? Theme.of(context).colorScheme.primary : Colors.transparent,
          ),
        ),
        child: Center(
          child: Text(
            symbleName,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 15,
                ),
          ),
        ),
      ),
    );
  }
}
