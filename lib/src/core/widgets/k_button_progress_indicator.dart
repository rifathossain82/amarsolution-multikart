import 'package:flutter/material.dart';

class KButtonProgressIndicator extends StatelessWidget {
  final Color indicatorColor;

  const KButtonProgressIndicator({
    super.key,
    this.indicatorColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20,
      width: 20,
      child: CircularProgressIndicator(
        color: indicatorColor,
      ),
    );
  }
}
