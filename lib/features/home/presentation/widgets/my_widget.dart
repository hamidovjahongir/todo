import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyWidget extends StatefulWidget {
  final double width;
  final double height;
  void Function()? onTap;
  final String title;
  final Color color;

  MyWidget({
    super.key,
    required this.width,
    required this.height,
    required this.title,
    this.onTap,
    this.color = Colors.blue,
  });

  @override
  State<MyWidget> createState() => MyWidgetState();
}

class MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: widget.color,
        ),
        width: widget.width,

        height: widget.height,
        child: Center(
          child: Text(widget.title, style: TextStyle(color: Colors.amber)),
        ),
      ),
    );
  }
}
