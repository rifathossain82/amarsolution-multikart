import 'package:amarsolution_multikart/src/core/extensions/text_style_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:amarsolution_multikart/src/core/extensions/build_context_extension.dart';
import 'package:amarsolution_multikart/src/core/helpers/validators.dart';
import 'package:amarsolution_multikart/src/core/widgets/k_button.dart';
import 'package:amarsolution_multikart/src/core/widgets/k_button_progress_indicator.dart';
import 'package:amarsolution_multikart/src/core/widgets/k_logo.dart';
import 'package:amarsolution_multikart/src/core/widgets/k_text_form_field_builder_with_title.dart';
import 'package:amarsolution_multikart/src/features/auth/controller/auth_controller.dart';
import 'package:amarsolution_multikart/src/features/auth/view/widgets/custom_back_button_widget.dart';

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
      body: SafeArea(
        child: Stack(
          children: [
            _loginPageBody(),
            const Positioned(
              top: 15,
              left: 15,
              child: CustomBackButton(),
            ),
          ],
        ),
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
          top: context.screenHeight * 0.08,
          bottom: context.screenHeight * 0.03,
        ),
        child: Form(
          key: loginFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /// logo and welcome text
              const KLogo(),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                ),
                child: Text(
                  'Become an ideal member by just verifying your phone number',
                  textAlign: TextAlign.center,
                  style: context.appTextTheme.bodySmall,
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
                          'Send OTP',
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
