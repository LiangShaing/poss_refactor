import 'package:flutter/material.dart';

class MyTextStatelessWidget extends StatelessWidget {
  final String? text;
  final EdgeInsetsGeometry padding;
  final TextStyle? style;
  final TextAlign textAlign;
  final TextOverflow textOverflow;

  const MyTextStatelessWidget({
    Key? key,
    required this.text,
    this.padding = const EdgeInsets.all(0.0),
    this.style,
    this.textAlign = TextAlign.left,
    this.textOverflow = TextOverflow.ellipsis,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (text == null || text!.isEmpty) return const Text("");

    return Padding(
      padding: padding,
      child: Text(
        text!,
        textAlign: textAlign,
        overflow: textOverflow,
        style: style ?? Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }
}
