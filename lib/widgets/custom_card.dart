import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final String title;
  final Widget? child;
  final Color? color;
  final double? borderRadius;
  final EdgeInsets? padding;
  final VoidCallback? onPressed;
  final String info;
  final String infoSource;

  const CustomCard({
    super.key,
    this.child,
    this.color,
    this.borderRadius,
    this.padding,
    required this.title,
    this.onPressed,
    required this.info,
    required this.infoSource,
  });

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
                      onPressed: () {
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            contentTextStyle:
                                Theme.of(context).textTheme.bodyMedium,

                            backgroundColor:
                                Theme.of(context).brightness == Brightness.light
                                    ? Colors.black
                                    : Colors.white,
                            // title: const Text('AlertDialog Title'),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(info,
                                    style: Theme.of(context).brightness ==
                                            Brightness.light
                                        ? Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(color: Colors.white)
                                        : Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(color: Colors.black)),
                                const SizedBox(height: 10.0),
                                Text(infoSource,
                                    style: Theme.of(context).brightness ==
                                            Brightness.light
                                        ? Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(color: Colors.white)
                                        : Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(color: Colors.black)),
                              ],
                            ),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () =>
                                    Navigator.pop(context, 'Cancel'),
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(context, 'OK'),
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                        );
                      },
                      icon: const Icon(Icons.info_outline),
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),
                child ?? Container(),
              ]),
        ));
  }
}
