import 'package:flutter/material.dart';
import 'package:whallet/src/widgets/template_container_widget.dart';

class TokenDetailPage extends StatefulWidget {
  const TokenDetailPage({Key? key}) : super(key: key);

  @override
  State<TokenDetailPage> createState() => _TokenDetailPageState();
}

class _TokenDetailPageState extends State<TokenDetailPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return TemplateContainerWidget(
      size: size,
      child: Text('ual'),
    );
  }
}
