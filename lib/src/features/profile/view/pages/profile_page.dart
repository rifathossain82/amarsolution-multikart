import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:amarsolution_multikart/src/core/theme/app_theme.dart';
import 'package:amarsolution_multikart/src/features/profile/controller/profile_controller.dart';
import 'package:amarsolution_multikart/src/features/profile/view/widgets/profile_contact_card_widget.dart';
import 'package:amarsolution_multikart/src/features/profile/view/widgets/profile_info_card_widget.dart';
import 'package:amarsolution_multikart/src/features/profile/view/widgets/profile_image_widget.dart';
import 'package:amarsolution_multikart/src/features/profile/view/widgets/profile_shipping_address_card.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Page'),
        elevation: 0.0,
        // systemOverlayStyle: AppTheme.lightSystemOverlayStyle(),
      ),
      body: Obx(() {
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ProfileImageWidget(
                  user: profileController.userInfo.value!,
                  profileController: profileController,
                ),
                const SizedBox(height: 20),
                ProfileInfoCardWidget(
                  user: profileController.userInfo.value!,
                  profileController: profileController,
                ),
                const SizedBox(height: 20),
                ProfileContactCardWidget(
                  user: profileController.userInfo.value!,
                  profileController: profileController,
                ),
                const SizedBox(height: 20),
                ProfileShippingAddressCardWidget(
                  user: profileController.userInfo.value!,
                  profileController: profileController,
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
