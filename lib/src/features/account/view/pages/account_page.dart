import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:amarsolution_multikart/src/core/theme/app_theme.dart';
import 'package:amarsolution_multikart/src/core/utils/color.dart';
import 'package:amarsolution_multikart/src/features/account/view/widgets/account_app_bar.dart';
import 'package:amarsolution_multikart/src/features/account/view/widgets/account_body_widget.dart';
import 'package:amarsolution_multikart/src/features/account/view/widgets/account_page_loading_widget.dart';
import 'package:amarsolution_multikart/src/features/auth/controller/auth_controller.dart';
import 'package:amarsolution_multikart/src/features/profile/controller/profile_controller.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  // final profileController = Get.find<ProfileController>();
  // final authController = Get.find<AuthController>();
  //
  // @override
  // void initState() {
  //   AppTheme.setLightStatusBar();
  //   super.initState();
  // }
  //
  // @override
  // void dispose() {
  //   AppTheme.setDarkStatusBar();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        toolbarHeight: 0.0,
        backgroundColor: kPrimaryColor,
      ),
      // body: Obx(() {
      //   return profileController.isUserInfoLoading.value
      //       ? const AccountPageLoadingWidget()
      //       : Column(
      //           children: [
      //             AccountAppBar(
      //               user: profileController.userInfo.value,
      //               authController: authController,
      //             ),
      //             Expanded(
      //               child: AccountBodyWidget(
      //                 profileController: profileController,
      //                 authController: authController,
      //               ),
      //             ),
      //           ],
      //         );
      // }),
    );
  }
}
