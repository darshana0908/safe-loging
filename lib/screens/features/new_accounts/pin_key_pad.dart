import 'package:flutter/material.dart';

class PinKeyPad extends StatefulWidget {
  const PinKeyPad({Key? key, required this.keypad, required this.click})
      : super(key: key);

  final String keypad;
  final Function() click;
  @override
  State<PinKeyPad> createState() => _PinKeyPadState();
}

class _PinKeyPadState extends State<PinKeyPad> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: widget.click,
        child: Container(
          alignment: Alignment.center,
          width: 55,
          height: 55,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(45),
            color: Colors.deepPurple,
          ),
          child: Text(
            widget.keypad,
            style: const TextStyle(
                color: Colors.white, fontSize: 45, fontWeight: FontWeight.w600),
          ),
        ));
  }
}
