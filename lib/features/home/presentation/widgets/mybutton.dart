import 'package:flutter/material.dart';

class Mybutton extends StatefulWidget {
  final void Function()? onTap;
  final String title;
  Mybutton({super.key, this.onTap, required this.title});

  @override
  State<Mybutton> createState() => _MybuttonState();
}

class _MybuttonState extends State<Mybutton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (widget.onTap != null) {
          widget.onTap!(); 
        }
      },
      child: Ink(
        width: MediaQuery.of(context).size.width * 0.95,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.blue,
        ),
        child: Center(
          child: Text(
            widget.title,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
