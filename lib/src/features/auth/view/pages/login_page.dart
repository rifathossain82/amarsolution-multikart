import 'package:amarsolution_multikart/src/core/extensions/text_style_extension.dart';
import 'package:amarsolution_multikart/src/core/utils/color.dart';
import 'package:amarsolution_multikart/src/features/auth/view/widgets/auth_back_button.dart';
import 'package:amarsolution_multikart/src/features/auth/view/widgets/auth_circle_shape.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:amarsolution_multikart/src/core/extensions/build_context_extension.dart';
import 'package:amarsolution_multikart/src/core/helpers/validators.dart';
import 'package:amarsolution_multikart/src/core/widgets/k_button.dart';
import 'package:amarsolution_multikart/src/core/widgets/k_button_progress_indicator.dart';
import 'package:amarsolution_multikart/src/core/widgets/k_text_form_field_builder_with_title.dart';
import 'package:amarsolution_multikart/src/features/auth/controller/auth_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final authController = Get.find<AuthController>();

  final phoneTextController = TextEditingController();
  final loginFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    phoneTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _loginPageBody(),
          const AuthBackButton(),
          const AuthCircleShape(),
        ],
      ),
    );
  }

  Widget _loginPageBody() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Container(
        margin: EdgeInsets.only(
          left: 15,
          right: 15,
          top: context.screenHeight * 0.15,
        ),
        child: Form(
          key: loginFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Hey,\nLogin Now",
                style: context.titleLarge(fontSize: 24, color: kGrey),
              ),

              Padding(
                padding: const EdgeInsets.only(
                  top: 12,
                  right: 150,
                ),
                child: Text(
                  'Become an ideal member by just verifying your phone number',
                  textAlign: TextAlign.start,
                  style: context.bodyMedium(),
                ),
              ),

              /// phone textField
              _buildPhoneTextFiled(),

              /// send otp button
              KButton(
                height: 45,
                onPressed: _sendOTPMethod,
                child: Obx(() {
                  return authController.isLoginLoading.value
                      ? const KButtonProgressIndicator()
                      : Text(
                          'send otp'.toUpperCase(),
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

  Widget _buildPhoneTextFiled() {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: KTextFormFieldBuilderWithTitle(
        controller: phoneTextController,
        title: 'Phone',
        hintText: 'Enter your phone no',
        validator: Validators.phoneNumberValidator,
        inputType: TextInputType.phone,
        inputAction: TextInputAction.done,
        prefixIconData: Icons.phone,
      ),
    );
  }

  void _sendOTPMethod() {
    if (loginFormKey.currentState!.validate()) {
      authController.login(phone: phoneTextController.text.trim());
    }
  }
}
