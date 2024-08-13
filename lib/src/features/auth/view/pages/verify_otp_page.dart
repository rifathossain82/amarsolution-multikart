import 'package:amarsolution_multikart/src/core/extensions/text_style_extension.dart';
import 'package:amarsolution_multikart/src/core/utils/color.dart';
import 'package:amarsolution_multikart/src/features/auth/view/widgets/auth_back_button.dart';
import 'package:amarsolution_multikart/src/features/auth/view/widgets/auth_circle_shape.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:amarsolution_multikart/src/core/errors/messages.dart';
import 'package:amarsolution_multikart/src/core/extensions/build_context_extension.dart';
import 'package:amarsolution_multikart/src/core/widgets/k_button.dart';
import 'package:amarsolution_multikart/src/core/widgets/k_button_progress_indicator.dart';
import 'package:amarsolution_multikart/src/features/auth/controller/auth_controller.dart';
import 'package:amarsolution_multikart/src/features/auth/view/widgets/pin_field_widget.dart';

class VerifyOTPPage extends StatefulWidget {
  final String phone;

  const VerifyOTPPage({
    super.key,
    required this.phone,
  });

  @override
  State<VerifyOTPPage> createState() => _VerifyOTPPageState();
}

class _VerifyOTPPageState extends State<VerifyOTPPage> {
  final authController = Get.find<AuthController>();

  final pinTextController = TextEditingController();
  final verifyOTPFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _verifyOTPPageBody(),
          const AuthBackButton(),
          const AuthCircleShape(),
        ],
      ),
    );
  }

  Widget _verifyOTPPageBody() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Container(
        margin: EdgeInsets.only(
          left: 15,
          right: 15,
          top: context.screenHeight * 0.15,
        ),
        child: Form(
          key: verifyOTPFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Hey,\nVerify Now",
                style: context.titleLarge(
                  fontSize: 24,
                  color: kGrey,
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(
                  top: 12,
                  right: 150,
                ),
                child: Text(
                  'We have just sent a 6 digit OTP code to your mobile number (${widget.phone})',
                  textAlign: TextAlign.start,
                  style: context.bodyMedium(),
                ),
              ),

              /// phone textField
              _buildPinTextFiled(),

              /// verify otp button
              KButton(
                height: 45,
                onPressed: _verifyOTPMethod,
                child: Obx(() {
                  return authController.isVerifyOTPLoading.value
                      ? const KButtonProgressIndicator()
                      : Text(
                          'verify otp'.toUpperCase(),
                          style: context.buttonTextStyle(),
                        );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPinTextFiled() {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0),
      child: PinFieldWidget(
        labelText: 'Pin',
        fieldController: pinTextController,
        icon: Icons.visibility,
        keyType: TextInputType.number,
        validation: (value) {
          if (value!.isEmpty) {
            return Message.emptyOTP;
          } else if (value.toString().length < 6) {
            return Message.invalidOTP;
          }
          return null;
        },
      ),
    );
  }

  void _verifyOTPMethod() {
    if (verifyOTPFormKey.currentState!.validate()) {
      authController.verifyOTP(
        phone: widget.phone,
        otp: pinTextController.text.trim(),
      );
    }
  }
}
