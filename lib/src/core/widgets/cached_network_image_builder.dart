import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:amarsolution_multikart/src/core/utils/asset_path.dart';
import 'package:amarsolution_multikart/src/core/utils/color.dart';

class CachedNetworkImageBuilder extends StatelessWidget {
  final String imgURl;
  final BorderRadius borderRadius;
  final double height;
  final double width;
  final BoxFit fit;
  final Color backgroundColor;

  const CachedNetworkImageBuilder({
    super.key,
    required this.imgURl,
    required this.borderRadius,
    this.height = 100,
    this.width = double.infinity,
    this.fit = BoxFit.contain,
    this.backgroundColor = kWhite,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imgURl,
      height: height,
      width: width,
      fit: fit,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          color: backgroundColor,
          image: DecorationImage(
            image: imageProvider,
            fit: fit,
          ),
        ),
      ),
      placeholder: (context, url) => ClipRRect(
        borderRadius: borderRadius,
        child: Image.asset(
          AssetPath.placeholder,
          fit: BoxFit.cover,
        ),
      ),
      errorWidget: (context, url, error) => ClipRRect(
        borderRadius: borderRadius,
        child: Image.asset(
          AssetPath.placeholder,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
