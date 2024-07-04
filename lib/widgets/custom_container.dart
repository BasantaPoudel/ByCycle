import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final Widget? child;
  final Color? color;
  final double? borderRadius;
  final EdgeInsets? padding;

  const CustomContainer({
    Key? key,
    this.child,
    this.color,
    this.borderRadius,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // title and information button
    // body
    return Container(
      child: Column(
        children: [
          child!,
        ],
      ),
      color: color,
      padding: padding,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius!),
      ),
    );
  }
}
