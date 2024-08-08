import 'package:flutter/material.dart';
import 'package:amarsolution_multikart/src/core/extensions/build_context_extension.dart';
import 'package:amarsolution_multikart/src/core/utils/color.dart';

class KBlankFieldBuilderWithTitle extends StatelessWidget {
  final String title;
  final Widget content;
  final FormFieldValidator? validator;

  const KBlankFieldBuilderWithTitle({
    super.key,
    required this.title,
    required this.content,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              title,
              style: context.appTextTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            if (validator != null)
              Text(
                ' *',
                style: context.appTextTheme.titleSmall?.copyWith(
                  color: kRed,
                ),
              ),
          ],
        ),
        const SizedBox(height: 5),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 5,
          ),
          width: double.maxFinite,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              width: 1,
              color: kGrey,
            ),
          ),
          child: content,
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}
