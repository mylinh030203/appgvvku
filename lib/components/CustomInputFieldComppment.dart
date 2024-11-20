import 'package:app_giang_vien_vku/constants/AppColor.dart';
import 'package:app_giang_vien_vku/constants/AppSizes.dart';
import 'package:app_giang_vien_vku/utils/styles/textStyle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class CustomInputFormFieldCompoment extends StatefulWidget {
  CustomInputFormFieldCompoment({
    super.key,
    this.affix,
    this.placeholder,
    this.suffix,
    this.isPassword = false,
    this.type,
    this.onEnd,
    this.allowClear = false,
    this.colorBackground,
    this.validator,
    required this.controller,
    this.isDigitsOnly = false,
    required this.onSaved,
    this.onChanged,
  });

  TextEditingController? controller;
  final bool isDigitsOnly;
  final Widget? affix;
  final String? placeholder;
  final Widget? suffix;
  final bool isPassword;
  final TextInputType? type;
  final Function()? onEnd;
  final bool allowClear;
  final Color? colorBackground;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final void Function(String)? onChanged;

  @override
  State<CustomInputFormFieldCompoment> createState() => _CustomInputFormFieldCompomentState();
}

class _CustomInputFormFieldCompomentState extends State<CustomInputFormFieldCompoment> {
  bool _obscureText = true;
  late ValueNotifier<String> _textNotifier;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();

    _focusNode = FocusNode();
    _textNotifier = ValueNotifier<String>(widget.controller!.text);
    widget.controller!.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    widget.controller!.removeListener(_onTextChanged);
    _textNotifier.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    setState(() {
      _textNotifier.value = widget.controller!.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: Theme.of(context).textTheme.bodyLarge,
      onChanged: widget.onChanged,
      onSaved: widget.onSaved,
      validator: widget.validator,
      controller: widget.controller,
      inputFormatters: widget.isDigitsOnly
          ? <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly, // Chỉ cho phép nhập số
            ]
          : null,
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
        labelText: widget.placeholder,
        labelStyle: Theme.of(context).textTheme.bodySmall,
        suffixIcon: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.allowClear && widget.controller != null && widget.controller!.text.isNotEmpty)
              IconButton(
                icon: const Icon(CupertinoIcons.clear_circled_solid, size: AppSize.lg),
                onPressed: () {
                  widget.controller!.clear();
                },
              ),
            if (widget.isPassword)
              IconButton(
                icon: Icon(
                  color: AppColors.black,
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
    );
  }
}
