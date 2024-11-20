import 'package:app_giang_vien_vku/constants/AppColor.dart';
import 'package:app_giang_vien_vku/utils/styles/textStyle.dart';
import 'package:flutter/material.dart';

class TextFieldComponent extends StatefulWidget {
  final TextEditingController controller;
  final Widget? affix;
  final String? placeholder;
  final Widget? suffix;
  final bool isPassword;
  final TextInputType? type;
  final Function()? onEnd;
  final bool allowClear;
  final Color? colorBackground;
  final String? Function(String?)? validate;

  const TextFieldComponent({
    super.key,
    required this.controller,
    this.affix,
    this.placeholder,
    this.suffix,
    this.isPassword = false,
    this.type,
    this.onEnd,
    this.allowClear = false,
    this.colorBackground,
    this.validate,
  });

  @override
  _TextFieldComponentState createState() => _TextFieldComponentState();
}

class _TextFieldComponentState extends State<TextFieldComponent> {
  bool _obscureText = true;
  late ValueNotifier<String> _textNotifier;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _textNotifier = ValueNotifier<String>(widget.controller.text);
    widget.controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onTextChanged);
    _textNotifier.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    _textNotifier.value = widget.controller.text;
    if (widget.validate != null) {
      _textNotifier.value = widget.controller.text;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: _textNotifier,
      builder: (context, text, _) {
        return TextFormField(
          style: AppTextStyles.displaySmall,
          controller: widget.controller,
          obscureText: widget.isPassword ? _obscureText : false,
          keyboardType: widget.type ?? TextInputType.text,
          focusNode: _focusNode,
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.thirdPrimary, width: 2.0),
              borderRadius: BorderRadius.circular(12.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.thirdPrimary),
              borderRadius: BorderRadius.circular(12.0),
            ),
            filled: true,
            fillColor: widget.colorBackground ?? AppColors.white,
            prefixIcon: widget.affix,
            hintText: widget.placeholder,
            suffixIcon: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (widget.allowClear && text.isNotEmpty)
                  IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      widget.controller.clear();
                    },
                  ),
                if (widget.isPassword)
                  IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  ),
                if (widget.suffix != null) widget.suffix!,
              ],
            ),
          ),
          onEditingComplete: () {
            // print('Editing complete: ${widget.controller.text}');
            FocusScope.of(context).unfocus();
          },
          validator: widget.validate,
        );
      },
    );
  }
}
