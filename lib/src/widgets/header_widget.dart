import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whallet/utils/change_theme.dart';
import 'package:whallet/utils/routes.dart';

class HeaderWidget extends StatefulWidget {
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
  State<HeaderWidget> createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  @override
  Widget build(BuildContext context) {
    final changeTheme = Provider.of<ChangeTheme>(context);
    return Row(
      children: [
        Container(
          width: 200,
          height: widget.height,
          padding: const EdgeInsets.only(left: 20),
          decoration: BoxDecoration(
            color: changeTheme.switchTheme ? null : Theme.of(context).cardColor,
            borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(50),
            ),
            boxShadow: changeTheme.switchTheme
                ? []
                : [
                    BoxShadow(color: Theme.of(context).colorScheme.primary, blurRadius: 10),
                    BoxShadow(color: Theme.of(context).colorScheme.primary, blurRadius: 5)
                  ],
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Whallet',
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (widget.isOptions)
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 10,
                          color: const Color(0xffECECEC).withOpacity(0.15),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Switch(
                      value: changeTheme.switchTheme,
                      activeColor: Theme.of(context).colorScheme.primary,
                      onChanged: changeTheme.toogleSwitch,
                    ),
                  ),
                const SizedBox(width: 30),
                if (widget.isExit)
                  IconButton(
                    icon: const ImageIcon(
                      AssetImage('lib/assets/icons/exit.png'),
                    ),
                    onPressed: () {
                      FirebaseAuth.instance.signOut().then((value) {
                        Navigator.of(context).pushNamedAndRemoveUntil(AppRoute.SPLASHSCREEN, (route) => true);
                      });
                    },
                  ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
