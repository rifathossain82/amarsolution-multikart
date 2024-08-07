import 'package:amarsolution_multikart/src/core/extensions/text_style_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:amarsolution_multikart/src/core/extensions/build_context_extension.dart';
import 'package:amarsolution_multikart/src/core/services/loading_overlay.dart';
import 'package:amarsolution_multikart/src/core/utils/color.dart';
import 'package:amarsolution_multikart/src/core/widgets/k_button.dart';
import 'package:amarsolution_multikart/src/core/widgets/k_divider.dart';
import 'package:amarsolution_multikart/src/core/widgets/k_outlined_button.dart';
import 'package:amarsolution_multikart/src/core/widgets/k_text_form_field_builder_with_title.dart';
import 'package:amarsolution_multikart/src/features/profile/controller/profile_controller.dart';
import 'package:amarsolution_multikart/src/features/profile/model/user_model.dart';
import 'package:amarsolution_multikart/src/features/profile/view/widgets/profile_card_title_widget.dart';
import 'info_item.dart';

class ProfileShippingAddressCardWidget extends StatelessWidget {
  final UserModel user;
  final ProfileController profileController;

  const ProfileShippingAddressCardWidget({
    Key? key,
    required this.user,
    required this.profileController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.screenWidth,
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          // BoxShadow(
          //   offset: const Offset(0, 0),
          //   blurRadius: 4,
          //   spreadRadius: 0,
          //   color: kItemShadowColor,
          // ),
        ],
      ),
      child: Column(
        children: [
          ProfileCartTitleWidget(
            title: 'Shipping Address',
            suffixIcon: Icons.location_on,
            onEdit: () => _buildShippingAddressEditingBottomSheet(
              context: context,
              user: user,
            ),
          ),
          ProfileInfoItem(
            title: 'Address Line'.tr,
            data: user.address ?? 'Not Set',
          ),
          KDivider(color: kGrey),
          ProfileInfoItem(
            title: 'City'.tr,
            data: user.city ?? 'Not Set',
          ),
          KDivider(color: kGrey),
          ProfileInfoItem(
            title: 'Country'.tr,
            data: user.country ?? 'Not Set',
          ),
        ],
      ),
    );
  }

  Future _buildShippingAddressEditingBottomSheet({
    required BuildContext context,
    required UserModel user,
  }) {
    final addressLineTextController = TextEditingController();
    final cityTextController = TextEditingController();
    final countryTextController = TextEditingController();

    addressLineTextController.text = user.address ?? '';
    cityTextController.text = user.city ?? '';
    countryTextController.text = user.country ?? '';

    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: kWhite,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(8),
        ),
      ),
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Container(
              padding: const EdgeInsets.all(15),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    /// bottom sheet close button and title
                    Text(
                      'Update Shipping Address',
                      textAlign: TextAlign.center,
                      style: context.appTextTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    KTextFormFieldBuilderWithTitle(
                      controller: addressLineTextController,
                      title: 'Address Line',
                      hintText: 'Enter your address line',
                      inputType: TextInputType.streetAddress,
                      inputAction: TextInputAction.next,
                    ),
                    KTextFormFieldBuilderWithTitle(
                      controller: cityTextController,
                      title: 'City',
                      hintText: 'Enter your city',
                      inputType: TextInputType.text,
                      inputAction: TextInputAction.next,
                    ),
                    KTextFormFieldBuilderWithTitle(
                      controller: countryTextController,
                      title: 'Country',
                      hintText: 'Enter your country',
                      inputType: TextInputType.text,
                      inputAction: TextInputAction.done,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: KOutlinedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            width: context.screenWidth,
                            borderColor: kPrimaryColor,
                            child: Text(
                              'Cancel',
                              style: context.outlinedButtonTextStyle(),
                            ),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: KButton(
                            onPressed: () {
                              /// to unFocus keyboard
                              context.unFocusKeyboard;

                              /// set modified data into user
                              user.address = addressLineTextController.text.trim();
                              user.city = cityTextController.text.trim();
                              user.country = countryTextController.text.trim();

                              /// request for update user
                              LoadingOverlay.runAsyncTask(context, () async {
                                await profileController.updateUser(
                                  user: user,
                                );
                              }).then((value) => Navigator.pop(context));
                            },
                            width: context.screenWidth,
                            child: Text(
                              'Update',
                              style: context.buttonTextStyle(),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
      },
    );
  }
}
