import 'package:flutter/cupertino.dart';
import 'package:amarsolution_multikart/src/core/extensions/build_context_extension.dart';
import 'package:amarsolution_multikart/src/core/utils/color.dart';

class IncrementDecrementWidget extends StatelessWidget {
  final String value;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const IncrementDecrementWidget({
    super.key,
    required this.value,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _ButtonWidget(
          icon: CupertinoIcons.minus,
          onTap: onDecrement,
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          alignment: Alignment.center,
          child: Text(
            value,
            style: context.appTextTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        _ButtonWidget(
          icon: CupertinoIcons.plus,
          onTap: onIncrement,
        ),
      ],
    );
  }
}

class _ButtonWidget extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _ButtonWidget({
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 30,
        height: 30,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: kGreyLight,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Icon(
          icon,
          size: 15,
          color: kBlack,
        ),
      ),
    );
  }
}
