import 'package:flutter/material.dart';

class SpaceComponent extends StatelessWidget {
  final double? height;
  final double? width;
  const SpaceComponent({super.key, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height?? 0,
      width: width?? 0,
    );
  }
}
