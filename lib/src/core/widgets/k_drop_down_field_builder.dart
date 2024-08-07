import 'package:flutter/material.dart';
import 'package:amarsolution_multikart/src/core/errors/messages.dart';

class KDropDownFieldBuilder<T> extends StatelessWidget {
  final bool isLoading;
  final String? title;
  final List<T>? items;
  final T? value;
  final ValueChanged onChanged;
  final Widget Function(T?) itemBuilder;
  final bool validatorActive;
  final FocusNode? focusNode;
  final String hintText;
  final int? maxLines;
  final int? minLines;
  final TextInputType? inputType;
  final TextInputAction? inputAction;
  final Widget? suffix;
  final Widget? prefixIcon;
  final Widget? dropdownIcon;
  final bool? obscureValue;
  final bool isBorder;
  final bool isExpanded;

  const KDropDownFieldBuilder({
    super.key,
    this.isLoading = false,
    required this.items,
    required this.value,
    required this.onChanged,
    required this.itemBuilder,
    this.validatorActive = true,
    this.focusNode,
    this.title,
    this.hintText = 'Select One',
    this.maxLines,
    this.minLines,
    this.inputType,
    this.inputAction,
    this.suffix,
    this.prefixIcon,
    this.dropdownIcon,
    this.obscureValue,
    this.isBorder = true,
    this.isExpanded = true,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      isExpanded: isExpanded,
      validator: (value) {
        if (validatorActive && items?.contains(value) == false) {
          return Message.emptyField;
        }
        return null;
      },
      decoration: InputDecoration(
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 12,
        ),
        border: isBorder ? const OutlineInputBorder() : InputBorder.none,
        hintText: hintText,
        labelText: title,
      ),
      icon: dropdownIcon,
      items: items?.map(
        (item) => DropdownMenuItem(
        value: item,
        child: itemBuilder(item),
      ),
      ).toList(),
      value: value,
      onChanged: onChanged,
    );
  }
}