// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../constants/colors.dart';

class CustomVerticalLine extends StatelessWidget {
  const CustomVerticalLine({
    Key? key,
    this.color = MyColors.myYellow,
    this.height = 20,
    this.width = 2,
  }) : super(key: key);

  final Color color;
  final double width, height;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      width: width,
      height: height,
    );
  }
}
