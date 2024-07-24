import 'package:flutter/material.dart';
import 'package:amarsolution_multikart/src/core/extensions/build_context_extension.dart';
import 'package:amarsolution_multikart/src/core/utils/asset_path.dart';
import 'package:amarsolution_multikart/src/core/utils/color.dart';

class KCustomLoader extends StatelessWidget {
  final String? titleText;
  const KCustomLoader({super.key, this.titleText});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AbsorbPointer(
        child: Center(
          child: SizedBox(
            width: 200.0,
            height: 200.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      height: 70,
                      width: 70,
                      child: CircularProgressIndicator(
                        color: kPrimaryColor,
                      ),
                    ),
                    Positioned(
                      child: CircleAvatar(
                        maxRadius: 20,
                        backgroundColor: Colors.transparent,
                        child: Image.asset(AssetPath.appLogo),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                Text(
                  titleText ?? 'Please Wait...',
                  style: context.appTextTheme.titleMedium,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
