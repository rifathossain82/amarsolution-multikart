import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:amarsolution_multikart/src/core/extensions/build_context_extension.dart';
import 'package:amarsolution_multikart/src/core/utils/color.dart';
import 'package:amarsolution_multikart/src/features/home/controller/flash_sales_count_down_controller.dart';

class FlashSalesCountDownTimerWidget extends StatelessWidget {
  final DateTime expireTime;

  const FlashSalesCountDownTimerWidget({
    Key? key,
    required this.expireTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FlashSalesCountDownController>(
      init: FlashSalesCountDownController(expireTime),
      builder: (controller) {
        Duration difference = controller.difference;
        int days = difference.inDays;
        int hours = difference.inHours.remainder(24);
        int minutes = difference.inMinutes.remainder(60);
        int seconds = difference.inSeconds.remainder(60);

        return Row(
          children: [
            _TimerField(
              value: '$days',
              title: 'Days',
            ),
            const SizedBox(width: 4),
            _TimerField(
              value: '$hours',
              title: 'Hours',
            ),
            const SizedBox(width: 4),
            _TimerField(
              value: '$minutes',
              title: 'Min',
            ),
            const SizedBox(width: 4),
            _TimerField(
              value: '$seconds',
              title: 'Sec',
            ),
          ],
        );
      },
    );
  }
}

class _TimerField extends StatelessWidget {
  final String value;
  final String title;

  const _TimerField({
    Key? key,
    required this.value,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      width: 40,
      decoration: BoxDecoration(
        color: kPrimaryColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: context.appTextTheme.bodySmall?.copyWith(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: kBlackLight,
            ),
          ),
          Text(
            title,
            style: context.appTextTheme.bodySmall?.copyWith(
              fontSize: 9,
              color: kBlackLight,
            ),
          ),
        ],
      ),
    );
  }
}
