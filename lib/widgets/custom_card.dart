import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final String title;
  final Widget? child;
  final Color? color;
  final double? borderRadius;
  final EdgeInsets? padding;
  final VoidCallback? onPressed;

  const CustomCard({
    Key? key,
    this.child,
    this.color,
    this.borderRadius,
    this.padding,
    required this.title,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // title and information button
    // body
    // use enumerator for discharge, blood and symptoms

    return Card(
        color: color ?? Colors.white,
        margin: const EdgeInsets.all(16.0),
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: onPressed,
                      icon: Icon(Icons.info_outline),
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),
                child ?? Container(),
              ]),
        ));
  }
}


//     return Card.filled(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(borderRadius ?? 8),
//         ),
//         color: color,
//         child: SizedBox(
//           width: MediaQuery.of(context).size.width * 0.5,
//           height: MediaQuery.of(context).size.height * 0.2,
//           child: const Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text('Card Title', style: TextStyle(fontSize: 20)),
//                   Icon(Icons.info_outline, color: Colors.black, size: 20),
//                 ],
//               ),
//             ],
//           ),
//         ));
//   }
// }
