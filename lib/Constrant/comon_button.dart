import 'package:flutter/material.dart';

import 'Textstyle.dart';

GestureDetector commonbutton(
    String title, Function() onTap, double height, double width, Color color) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: height,
      width: width,
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          title,
          style: kGreen20w800,
        ),
      ),
    ),
  );
}
