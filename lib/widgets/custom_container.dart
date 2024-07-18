import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final Widget? child;
  final Color? color;
  final double? borderRadius;
  final EdgeInsets? padding;

  const CustomContainer({
    super.key,
    this.child,
    this.color,
    this.borderRadius,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    // title and information button
    // body
    return Container(
      color: color,
      padding: padding,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius!),
      ),
      child: Column(
        children: [
          child!,
        ],
      ),
    );
  }
}
