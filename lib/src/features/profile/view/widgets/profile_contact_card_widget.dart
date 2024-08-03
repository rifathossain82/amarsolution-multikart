import 'package:amarsolution_multikart/src/core/extensions/text_style_extension.dart';
import 'package:flutter/material.dart';
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

class ProfileContactCardWidget extends StatelessWidget {
  final UserModel user;
  final ProfileController profileController;

  const ProfileContactCardWidget({
    super.key,
    required this.user,
    required this.profileController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.screenWidth,
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 0),
            blurRadius: 4,
            spreadRadius: 0,
            color: kBlackLight,
          ),
        ],
      ),
      child: Column(
        children: [
          ProfileCartTitleWidget(
            title: 'Contact',
            suffixIcon: Icons.contacts,
            onEdit: () => _buildContactEditingBottomSheet(
              context: context,
              user: user,
            ),
          ),
          ProfileInfoItem(
            title: 'Email',
            data: user.email ?? 'Not Set',
          ),
          const KDivider(color: kGrey),
          ProfileInfoItem(
            title: 'Phone Number',
            data: user.phone ?? 'Not Set',
          ),
          const KDivider(color: kGrey),
          ProfileInfoItem(
            title: 'Alt. Phone Number',
            data: user.altPhoneNo ?? 'Not Set',
          ),
        ],
      ),
    );
  }

  Future _buildContactEditingBottomSheet({
    required BuildContext context,
    required UserModel user,
  }) {
    final emailTextController = TextEditingController();
    final altPhoneTextController = TextEditingController();

    /// set data based on user
    emailTextController.text = user.email ?? '';
    altPhoneTextController.text = user.altPhoneNo ?? '';

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
                      'Update Contact Information',
                      textAlign: TextAlign.center,
                      style: context.appTextTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    KTextFormFieldBuilderWithTitle(
                      controller: emailTextController,
                      title: 'Email',
                      hintText: 'Enter your email',
                      inputType: TextInputType.emailAddress,
                      inputAction: TextInputAction.next,
                    ),
                    KTextFormFieldBuilderWithTitle(
                      controller: altPhoneTextController,
                      title: 'Alternate Phone Number',
                      hintText: 'Enter your alternate phone no',
                      inputType: TextInputType.phone,
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
                              user.email = emailTextController.text.trim();
                              user.altPhoneNo =
                                  altPhoneTextController.text.trim();

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
