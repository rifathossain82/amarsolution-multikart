import 'package:flutter/material.dart';
import 'package:amarsolution_multikart/src/core/extensions/build_context_extension.dart';

class StatusBuilder extends StatelessWidget {
  final String status;
  final Color statusColor;

  const StatusBuilder({
    super.key,
    required this.status,
    required this.statusColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 10,
      ),
      decoration: BoxDecoration(
        color: statusColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        status,
        style: context.appTextTheme.bodySmall?.copyWith(
          fontWeight: FontWeight.bold,
          color: statusColor,
          fontSize: 10,
        ),
      ),
    );
  }
}
