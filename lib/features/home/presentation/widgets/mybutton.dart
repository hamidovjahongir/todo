import 'package:flutter/material.dart';

class Mybutton extends StatefulWidget {
  final void Function()? onTap;
  final String title;
  final double? fontSize;

  Mybutton({super.key, this.onTap, required this.title, this.fontSize});

  @override
  State<Mybutton> createState() => _MybuttonState();
}

class _MybuttonState extends State<Mybutton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: widget.onTap ?? () {},
      child: Ink(
        width: MediaQuery.of(context).size.width * 0.90,
        height: 60,

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Color(0xff9395D3),
          boxShadow: [
            BoxShadow(
              blurRadius: 12,
              offset: Offset(0, 5),
              color: Colors.black.withOpacity(0.5),
            ),
          ],
        ),

        child: Center(
          child: Text(
            widget.title,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: widget.fontSize ?? 20,
            ),
          ),
        ),
      ),
    );
  }
}
