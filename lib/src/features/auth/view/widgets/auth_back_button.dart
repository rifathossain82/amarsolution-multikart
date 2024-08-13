import 'package:amarsolution_multikart/src/features/auth/view/widgets/custom_back_button_widget.dart';
import 'package:flutter/material.dart';

class AuthBackButton extends StatelessWidget {
  const AuthBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return const Positioned(
      top: 45,
      left: 15,
      child: CustomBackButton(),
    );
  }
}
