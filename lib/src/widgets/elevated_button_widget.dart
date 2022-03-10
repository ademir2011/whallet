import 'package:flutter/material.dart';

class ElevatedButtonWidget extends StatefulWidget {
  final String title;
  final bool isLoading;
  final void Function() onPressed;
  final Icon? leftIcon;
  final Icon? rightIcon;

  const ElevatedButtonWidget({
    Key? key,
    required this.onPressed,
    required this.title,
    this.isLoading = false,
    this.leftIcon,
    this.rightIcon,
  }) : super(key: key);

  @override
  State<ElevatedButtonWidget> createState() => _ElevatedButtonWidgetState();
}

class _ElevatedButtonWidgetState extends State<ElevatedButtonWidget> {
  var showText = true;
  var countShowText = 0;

  @override
  Widget build(BuildContext context) {
    if (widget.isLoading) {
      showText = false;
    }
    return AnimatedContainer(
      onEnd: () {
        if (++countShowText == 2) {
          showText = true;
          countShowText = 0;
          setState(() {});
        }
      },
      width: widget.isLoading ? 50 : 135,
      height: 50,
      duration: const Duration(seconds: 1),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(color: Theme.of(context).colorScheme.primary.withOpacity(.25), blurRadius: 20),
          BoxShadow(color: Theme.of(context).colorScheme.primary.withOpacity(.25), blurRadius: 10),
        ],
        borderRadius: BorderRadius.circular(50),
      ),
      child: ElevatedButton(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 150),
              transitionBuilder: (child, animation) => ScaleTransition(scale: animation, child: child),
              child: showText
                  ? Row(
                      children: [
                        if (widget.leftIcon != null) widget.leftIcon!,
                        Text(
                          widget.title,
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                        if (widget.rightIcon != null) widget.rightIcon!,
                      ],
                    )
                  : SizedBox(
                      width: 15,
                      height: 15,
                      child: CircularProgressIndicator(
                        color: Theme.of(context).colorScheme.secondary,
                        strokeWidth: 2,
                      ),
                    ),
            ),
          ],
        ),
        onPressed: widget.onPressed,
      ),
    );
  }
}
