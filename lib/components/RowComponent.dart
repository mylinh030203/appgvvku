import 'package:flutter/material.dart';

class RowComponent extends StatelessWidget {
  final MainAxisAlignment justify;
  final List<Widget> children;
  final VoidCallback? onPress;
  final EdgeInsetsGeometry? padding;

  const RowComponent({
    super.key,
    this.justify = MainAxisAlignment.center,
    required this.children,
    this.onPress,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final row = Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Row(
        mainAxisAlignment: justify,
        children: children,
      ),
    );

    return onPress != null
        ? GestureDetector(
            onTap: onPress,
            child: row,
          )
        : row;
  }
}

