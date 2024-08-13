import 'package:flutter/material.dart';
import 'package:amarsolution_multikart/src/core/utils/asset_path.dart';

class KLogo extends StatelessWidget {
  final double? height;
  final double? width;
  final BoxFit? fit;

  const KLogo({
    super.key,
    this.height,
    this.width,
    this.fit,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'KLogo',
      child: Image.asset(
        AssetPath.appLogo,
        height: height ?? 120,
        width: width ?? 200,
        fit: fit,
      ),
    );
  }
}
