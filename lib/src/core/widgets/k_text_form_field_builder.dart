import 'package:flutter/material.dart';

class KTextFormFieldBuilder extends StatelessWidget {
  const KTextFormFieldBuilder({
    super.key,
    required this.controller,
    this.validator,
    this.focusNode,
    this.hintText,
    this.labelText,
    this.onChanged,
    this.onTap,
    this.onEditingComplete,
    this.maxLines,
    this.minLines,
    this.contentPadding,
    this.inputType,
    this.inputAction,
    this.suffix,
    this.prefixIcon,
    this.obscureValue,
    this.isBorder = true,
    this.readOnly = false,
  });

  final TextEditingController controller;
  final FormFieldValidator? validator;
  final FocusNode? focusNode;
  final String? hintText;
  final String? labelText;
  final Function(String value)? onChanged;
  final VoidCallback? onTap;
  final VoidCallback? onEditingComplete;
  final int? maxLines;
  final int? minLines;
  final EdgeInsetsGeometry? contentPadding;
  final TextInputType? inputType;
  final TextInputAction? inputAction;
  final Widget? suffix;
  final Widget? prefixIcon;
  final bool? obscureValue;
  final bool isBorder;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onTap: onTap,
      onEditingComplete: onEditingComplete,
      validator: validator,
      focusNode: focusNode,
      onChanged: onChanged,
      maxLines: maxLines ?? 1,
      minLines: minLines,
      keyboardType: inputType,
      textInputAction: inputAction,
      obscureText: obscureValue ?? false,
      readOnly: readOnly,
      decoration: InputDecoration(
        isDense: true,
        contentPadding: contentPadding ?? const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 12,
        ),
        hintText: hintText,
        labelText: labelText,
        border: isBorder ? const OutlineInputBorder() : InputBorder.none,
        suffixIcon: suffix,
        prefixIcon: prefixIcon,
      ),
    );
  }
}
