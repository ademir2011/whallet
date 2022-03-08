import 'package:flutter/material.dart';
import 'package:whallet/src/widgets/header_widget.dart';

class AuthHeaderContainerWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final Size size;
  final Widget child;
  const AuthHeaderContainerWidget({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.size,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeaderWidget(height: size.height * 0.125),
            Container(
              height: size.height * 0.875,
              margin: const EdgeInsets.symmetric(horizontal: 35),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 50),
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 15),
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 50),
                  child,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
