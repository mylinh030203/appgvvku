import 'package:flutter/material.dart';

class SectionComponent extends StatelessWidget {
  final List<Widget>? children;
  final Widget? child;
  final EdgeInsetsGeometry? padding;
  final double? height;
  final double? width;
  final Color? colorContainer;
  final CrossAxisAlignment crossAxisAlignment;

  const SectionComponent({
    super.key,
    this.children,
    this.padding,
    this.height,
    this.colorContainer,
    this.child, this.width, this.crossAxisAlignment = CrossAxisAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    return height != null
        ? Container(
            color: colorContainer,
            height: height,
            width: width?? double.infinity,
            padding: padding,
            child: child ?? _buildChildren(),
          )
        : Padding(
            padding: padding ?? EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: child ?? _buildChildren(),
          );
  }

  Widget _buildChildren() {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: children ?? [],
    );
  }
}
