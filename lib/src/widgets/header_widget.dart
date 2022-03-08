import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  final bool isOptions;
  final bool isExit;
  final double height;

  const HeaderWidget({
    Key? key,
    required this.height,
    this.isOptions = false,
    this.isExit = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 200,
          height: height,
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(50),
            ),
            boxShadow: const [
              BoxShadow(color: Color(0xff00BD59), blurRadius: 10),
              BoxShadow(color: Color(0xff00BD59), blurRadius: 5)
            ],
          ),
          child: Center(
            child: Text(
              'Whallet',
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              if (isOptions)
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 10,
                        color: const Color(0xffECECEC).withOpacity(0.25),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: ImageIcon(
                    const AssetImage('lib/assets/icons/options.png'),
                    color: Theme.of(context).cardColor,
                  ),
                ),
              if (isExit)
                const ImageIcon(
                  AssetImage('lib/assets/icons/exit.png'),
                ),
            ],
          ),
        )
      ],
    );
  }
}
