import 'package:flutter/material.dart';
import 'package:amarsolution_multikart/src/core/extensions/build_context_extension.dart';
import 'package:amarsolution_multikart/src/core/utils/color.dart';

class HomepageTitleTextBuilder extends StatelessWidget {
  final VoidCallback onViewAll;
  final String text;

  const HomepageTitleTextBuilder({
    super.key,
    required this.onViewAll,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 15,
        right: 0,
        top: 15,
        bottom: 0,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              text,
              maxLines: 1,
              textAlign: TextAlign.start,
              style: context.appTextTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          InkWell(
            onTap: onViewAll,
            borderRadius: BorderRadius.circular(4),
            splashColor: kPrimaryColor,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
              ),
              child: Row(
                children: [
                  Text(
                    'All',
                    maxLines: 1,
                    textAlign: TextAlign.end,
                    style: context.appTextTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: kGrey,
                    ),
                  ),
                  const SizedBox(width: 3),
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 14,
                    color: kGrey,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
