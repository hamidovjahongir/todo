import 'package:flutter/material.dart';

class MyTaskWidget extends StatefulWidget {
  final String todoTitle;
  final String todoSubTitle;
  final void Function()? delete;

  MyTaskWidget({
    super.key,
    required this.todoTitle,
    required this.todoSubTitle,
    this.delete,
  });

  @override
  State<MyTaskWidget> createState() => _MyTaskWidgetState();
}

class _MyTaskWidgetState extends State<MyTaskWidget> {
  @override
  Widget build(BuildContext context) {
    final mediaQueryWidth = MediaQuery.of(context).size.width;
    return Container(
      width: mediaQueryWidth,
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            spreadRadius: 1,
            offset: Offset(0, 5),
            color: Colors.black.withOpacity(0.3),
          ),
        ],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Column(
                  children: [
                    Text(
                      widget.todoTitle,
                      style: TextStyle(color: Color(0xff9395D3)),
                    ),
                    Text(
                      widget.todoSubTitle,
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              spacing: 10,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.edit, color: Color(0xffB3B7EE)),
                ),
                IconButton(
                  onPressed: widget.delete ?? () {},
                  icon: Icon(Icons.delete, color: Color(0xffB3B7EE)),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.check_circle_outline_rounded,
                    color: Color(0xffB3B7EE),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
