import 'package:flutter/material.dart';
import 'package:whallet/src/widgets/header_widget.dart';

class TemplateContainerWidget extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final Size size;
  final Widget child;
  final bool isExit;
  final bool isOptions;
  const TemplateContainerWidget({
    Key? key,
    this.isExit = false,
    this.isOptions = false,
    this.title,
    this.subtitle,
    required this.size,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HeaderWidget(
                    height: size.height * 0.125,
                    isExit: isExit,
                    isOptions: isOptions,
                  ),
                  if (title != null && subtitle != null)
                    Container(
                      height: size.height * 0.275,
                      margin: const EdgeInsets.symmetric(horizontal: 35),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            title!,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 15),
                          Text(
                            subtitle!,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  SizedBox(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 35),
                      child: child,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
