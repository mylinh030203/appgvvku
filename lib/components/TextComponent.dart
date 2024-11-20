import 'package:flutter/material.dart';

enum TextType { regular, bold, italic, semibold }

class TextComponent extends StatelessWidget {
  final String text;
  final TextType? type;
  final double? fontSize;
  final Color? color;
  final int? maxLine;
  final bool softWrap;

  const TextComponent({
    super.key,
    required this.text,
    this.type = TextType.regular,
    this.fontSize,
    this.color,
    this.maxLine = 1,
    this.softWrap = true,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'Montserrat',
        fontSize: fontSize ?? 16.0,
        color: color ?? Colors.black,
        fontWeight: type != null ? _getFontWeight(type!) : FontWeight.normal,
        fontStyle: type == TextType.italic ? FontStyle.italic : FontStyle.normal,
      ),
      overflow: softWrap ? TextOverflow.visible : TextOverflow.ellipsis,
      maxLines: maxLine,
      softWrap: softWrap,
    );
  }

  FontWeight _getFontWeight(TextType type) {
    switch (type) {
      case TextType.bold:
        return FontWeight.bold;
      case TextType.semibold:
        return FontWeight.w600;
      default:
        return FontWeight.normal;
    }
  }
}