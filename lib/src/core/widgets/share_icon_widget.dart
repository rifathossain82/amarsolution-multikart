import 'package:amarsolution_multikart/src/core/helpers/helper_methods.dart';
import 'package:amarsolution_multikart/src/core/network/api.dart';
import 'package:amarsolution_multikart/src/core/utils/color.dart';
import 'package:flutter/material.dart';

class ShareIconWidget extends StatelessWidget {
  final String url;

  const ShareIconWidget({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onShare,
      child: const Icon(
        Icons.share,
        color: kBlackLight,
        size: 20,
      ),
    );
  }

  void _onShare() {
    kShareData(
      title: url,
    );
  }
}
