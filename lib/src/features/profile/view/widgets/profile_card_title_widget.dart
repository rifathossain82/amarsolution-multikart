import 'package:flutter/material.dart';
import 'package:amarsolution_multikart/src/core/extensions/build_context_extension.dart';
import 'package:amarsolution_multikart/src/core/utils/color.dart';

class ProfileCartTitleWidget extends StatelessWidget {
  final String title;
  final IconData suffixIcon;
  final VoidCallback onEdit;

  const ProfileCartTitleWidget({
    Key? key,
    required this.title,
    required this.suffixIcon,
    required this.onEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 8,
      ),
      margin: const EdgeInsets.only(
        bottom: 4,
      ),
      decoration: BoxDecoration(
        color: kPrimaryColor,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(5),
        ),
      ),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
          suffixIcon,
            size: 20,
            color: kWhite,
          ),
          Text(
            title,
            style: context.appTextTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: kWhite,
            ),
          ),
          GestureDetector(
            onTap: onEdit,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Icon(
                Icons.edit,
                size: 20,
                color: kWhite,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
