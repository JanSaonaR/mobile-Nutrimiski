import 'package:flutter/material.dart';


class Button extends StatefulWidget{

  final String text;
  final Color color;
  final VoidCallback press;

  const Button({Key? key, required this.text, required this.color, required this.press}) : super(key: key);

  @override
  _ButtonState createState() => _ButtonState();
}

class _ButtonState extends State<Button>{



  @override
  Widget build(BuildContext context) {

    final ButtonStyle style =
    ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        minimumSize: const Size(300, 70),
        maximumSize: const Size(400, 100),
        primary: widget.color,
        //elevation: 0,
        padding: const EdgeInsets.symmetric(vertical: 20),
        textStyle: const TextStyle(fontSize: 15)
    );

    return ElevatedButton(
        style: style,
        onPressed: widget.press,
        child: Text(
          widget.text,
          style: const TextStyle(color: Colors.white),
        )
    );
  }

}