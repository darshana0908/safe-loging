import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';

class TextWidget extends StatefulWidget {
  const TextWidget({Key? key, required this.text}) : super(key: key);
  final String text;
  @override
  State<TextWidget> createState() => _TextWidgetState();
}

class _TextWidgetState extends State<TextWidget> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text,
      style: const TextStyle(
          color: Colors.white, fontSize: 25, fontWeight: FontWeight.w600),
    );
  }
}
