import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:amarsolution_multikart/src/core/extensions/build_context_extension.dart';
import 'package:amarsolution_multikart/src/core/services/dialog_service.dart';
import 'package:amarsolution_multikart/src/core/services/image_services.dart';
import 'package:amarsolution_multikart/src/core/services/loading_overlay.dart';
import 'package:amarsolution_multikart/src/core/utils/color.dart';
import 'package:amarsolution_multikart/src/core/widgets/k_outlined_button.dart';
// import 'package:amarsolution_multikart/src/core/widgets/k_profile_image.dart';
import 'package:amarsolution_multikart/src/features/profile/controller/profile_controller.dart';
import 'package:amarsolution_multikart/src/features/profile/model/user_model.dart';

class ProfileImageWidget extends StatelessWidget {
  final UserModel user;
  final ProfileController profileController;

  const ProfileImageWidget({
    Key? key,
    required this.user,
    required this.profileController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double imageSize = context.screenWidth * 0.29;
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        // KProfileImage(
        //   height: imageSize,
        //   width: imageSize,
        //   imgURL: user.image ?? "",
        // ),
        Positioned(
          child: Container(
            width: imageSize,
            height: imageSize,
            padding: const EdgeInsets.only(bottom: 5),
            alignment: Alignment.bottomCenter,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.transparent,
                  kGrey,
                ],
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(100),
                bottomRight: Radius.circular(100),
              ),
            ),
            child: GestureDetector(
              onTap: () => openImageSourceSelectorDialog(context),
              child: Icon(
                Icons.camera_alt,
                color: kWhite,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void openImageSourceSelectorDialog(BuildContext context) {
    DialogService.customDialog(
      context: context,
      title: "Choose an image from",
      dialogPosition: Alignment.bottomCenter,
      actions: [
        /// image from camera
        KOutlinedButton(
          onPressed: () async {
            final img = await ImageServices.cameraImage();
            if (img != null) {
              File? picture = await ImageServices.getImageFile(img);
              if (picture != null) updateProfileImage(context, picture);
            }
          },
          width: MediaQuery.of(context).size.width * 0.4,
          borderColor: kPrimaryColor,
          bgColor: kWhite,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.camera_alt,
                color: kPrimaryColor,
              ),
              const SizedBox(width: 10),
              Text(
                'Camera',
                style: context.textTheme.titleMedium,
              ),
            ],
          ),
        ),

        /// image from gallery
        KOutlinedButton(
          onPressed: () async {
            final img = await ImageServices.galleryImage();
            if (img != null) {
              File? picture = await ImageServices.getImageFile(img);
              if (picture != null) updateProfileImage(context, picture);
            }
          },
          width: MediaQuery.of(context).size.width * 0.4,
          borderColor: kPrimaryColor,
          bgColor: kWhite,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.image,
                color: kPrimaryColor,
              ),
              const SizedBox(width: 10),
              Text(
                'Gallery',
                style: context.textTheme.titleMedium,
              ),
            ],
          ),
        ),
      ],
    );
  }

  void updateProfileImage(BuildContext context, File image) async {
    /// To close the image selector dialog
    Navigator.of(context).pop();

    /// convert file to path
    String filePath = ImageServices.getImagePath(image);

    /// request to update
    LoadingOverlay.runAsyncTask(context, () async {
      await profileController.updateUser(
        user: user,
        filePath: filePath,
      );
    });
  }
}
