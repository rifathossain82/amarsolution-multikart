import 'package:amarsolution_multikart/src/core/utils/asset_path.dart';
import 'package:amarsolution_multikart/src/core/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FavoriteIconWidget extends StatelessWidget {
  const FavoriteIconWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onFavorite,
      child: SvgPicture.asset(
        AssetPath.wishlistIcon,
        colorFilter: const ColorFilter.mode(kBlackLight, BlendMode.srcIn),
        height: 20,
        width: 20,
      ),
    );
  }

  void _onFavorite() {}
}
