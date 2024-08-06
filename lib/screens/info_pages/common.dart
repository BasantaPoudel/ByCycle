import 'package:flutter/material.dart';

Widget buildSectionTitle(BuildContext context, String title) {
  return Text(
    title,
    style: Theme.of(context).textTheme.titleLarge?.copyWith(
          //color: const Color.fromRGBO(49, 49, 47, 1),
          fontWeight: FontWeight.bold,
        ),
  );
}
