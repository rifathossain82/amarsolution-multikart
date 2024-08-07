import 'package:flutter/material.dart';
import 'package:amarsolution_multikart/src/core/enums/app_enum.dart';
import 'package:amarsolution_multikart/src/core/errors/messages.dart';
import 'package:amarsolution_multikart/src/core/extensions/build_context_extension.dart';
import 'package:amarsolution_multikart/src/core/extensions/date_time_extension.dart';
import 'package:amarsolution_multikart/src/core/extensions/string_extension.dart';
import 'package:amarsolution_multikart/src/core/helpers/validators.dart';
import 'package:amarsolution_multikart/src/core/services/loading_overlay.dart';
import 'package:amarsolution_multikart/src/core/utils/color.dart';
// import 'package:amarsolution_multikart/src/core/widgets/k_blank_field_builder_with_title.dart';
import 'package:amarsolution_multikart/src/core/widgets/k_button.dart';
import 'package:amarsolution_multikart/src/core/widgets/k_divider.dart';
import 'package:amarsolution_multikart/src/core/widgets/k_outlined_button.dart';
import 'package:amarsolution_multikart/src/core/widgets/k_text_form_field_builder_with_title.dart';
// import 'package:amarsolution_multikart/src/core/widgets/radio_list_tile_widget.dart';
import 'package:amarsolution_multikart/src/features/profile/controller/profile_controller.dart';
import 'package:amarsolution_multikart/src/features/profile/model/user_model.dart';
import 'package:amarsolution_multikart/src/features/profile/view/widgets/profile_card_title_widget.dart';
import 'info_item.dart';

class ProfileInfoCardWidget extends StatelessWidget {
  final UserModel user;
  final ProfileController profileController;

  const ProfileInfoCardWidget({
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
      // child: Column(
      //   children: [
      //     ProfileCartTitleWidget(
      //       title: 'User Information',
      //       suffixIcon: Icons.account_circle,
      //       onEdit: () {
      //         _buildUserInfoEditingBottomSheet(context: context, user: user);
      //       },
      //     ),
      //     ProfileInfoItem(
      //       title: 'Name',
      //       data: user.name ?? 'Not Set',
      //     ),
      //     KDivider(color: kGrey),
      //     ProfileInfoItem(
      //       title: 'Date of Birth',
      //       data: user.birthDate ?? 'Not Set',
      //     ),
      //     KDivider(color: kGrey),
      //     ProfileInfoItem(
      //       title: 'Gender',
      //       data: user.gender ?? 'Not Set',
      //     ),
      //   ],
      // ),
    );
  }

  // Future _buildUserInfoEditingBottomSheet({
  //   required BuildContext context,
  //   required UserModel user,
  // }) {
  //   final nameTextController = TextEditingController();
  //   final dobTextController = TextEditingController();
  //   DateTime selectedDateOfBirth = DateTime.now();
  //   String? selectedGender;
  //
  //   /// set data based on user
  //   nameTextController.text = user.name ?? '';
  //   if (user.birthDate != null) {
  //     selectedDateOfBirth = DateTime.parse(user.birthDate);
  //     dobTextController.text = selectedDateOfBirth.requestFormat;
  //   }
  //   if (user.gender != null) {
  //     selectedGender = user.gender.toString().toLowerCase();
  //   }
  //
  //   return showModalBottomSheet(
  //     context: context,
  //     isScrollControlled: true,
  //     backgroundColor: kWhite,
  //     shape: const RoundedRectangleBorder(
  //       borderRadius: BorderRadius.vertical(
  //         top: Radius.circular(8),
  //       ),
  //     ),
  //     builder: (context) {
  //       return StatefulBuilder(builder: (context, setState) {
  //         return Padding(
  //           padding: MediaQuery.of(context).viewInsets,
  //           child: Container(
  //             padding: const EdgeInsets.all(15),
  //             child: SingleChildScrollView(
  //               child: Column(
  //                 mainAxisSize: MainAxisSize.min,
  //                 children: [
  //                   /// bottom sheet close button and title
  //                   Text(
  //                     'Update user information',
  //                     textAlign: TextAlign.center,
  //                     style: context.appTextTheme.bodySmall?.copyWith(
  //                       fontWeight: FontWeight.bold,
  //                     ),
  //                   ),
  //
  //                   KTextFormFieldBuilderWithTitle(
  //                     controller: nameTextController,
  //                     title: 'Name',
  //                     hintText: '',
  //                     inputType: TextInputType.name,
  //                     inputAction: TextInputAction.done,
  //                     validator: (value) {
  //                       if (value.toString().isEmpty) {
  //                         return Message.emptyName;
  //                       }
  //                       return null;
  //                     },
  //                   ),
  //                   KTextFormFieldBuilderWithTitle(
  //                     controller: dobTextController,
  //                     title: 'Date of Birth',
  //                     inputAction: TextInputAction.next,
  //                     readOnly: true,
  //                     validator: Validators.emptyValidator,
  //                     onTap: () {
  //                       _selectDate(
  //                         context: context,
  //                         selectedDate: selectedDateOfBirth,
  //                         onPicked: (dateTime) {
  //                           setState(() {
  //                             selectedDateOfBirth = dateTime;
  //                             dobTextController.text =
  //                                 selectedDateOfBirth.requestFormat;
  //                           });
  //                         },
  //                       );
  //                     },
  //                   ),
  //                   KBlankFieldBuilderWithTitle(
  //                     title: 'Gender',
  //                     content: Row(
  //                       children: [
  //                         ...Gender.values
  //                             .map(
  //                               (gender) => Expanded(
  //                                 child: RadioListTileWidget<String>(
  //                                   title: gender.name,
  //                                   value: gender.name,
  //                                   groupValue: selectedGender,
  //                                   onChanged: (value) {
  //                                     setState(() {
  //                                       selectedGender = value;
  //                                     });
  //                                   },
  //                                 ),
  //                               ),
  //                             )
  //                             .toList(),
  //                       ],
  //                     ),
  //                   ),
  //                   const SizedBox(height: 10),
  //                   Row(
  //                     children: [
  //                       Expanded(
  //                         child: KOutlinedButton(
  //                           onPressed: () {
  //                             Navigator.pop(context);
  //                           },
  //                           width: context.screenWidth,
  //                           borderColor: kPrimaryColor,
  //                           child: Text(
  //                             'Cancel',
  //                             style: context.outlinedButtonTextStyle,
  //                           ),
  //                         ),
  //                       ),
  //                       const SizedBox(width: 15),
  //                       Expanded(
  //                         child: KButton(
  //                           onPressed: () {
  //                             /// to unFocus keyboard
  //                             context.unFocusKeyboard;
  //
  //                             /// set modified data into user
  //                             user.name = nameTextController.text.trim();
  //                             user.birthDate = dobTextController.text.trim();
  //                             if (selectedGender != null) {
  //                               user.gender =
  //                                   selectedGender.toString().capitalizedFirst;
  //                             }
  //
  //                             /// request for update user
  //                             LoadingOverlay.runAsyncTask(context, () async {
  //                               await profileController.updateUser(
  //                                 user: user,
  //                               );
  //                             }).then((value) => Navigator.pop(context));
  //                           },
  //                           width: context.screenWidth,
  //                           child: Text(
  //                             'Update',
  //                             style: context.buttonTextStyle,
  //                           ),
  //                         ),
  //                       ),
  //                     ],
  //                   )
  //                 ],
  //               ),
  //             ),
  //           ),
  //         );
  //       });
  //     },
  //   );
  // }
  //
  // void _selectDate({
  //   required BuildContext context,
  //   required DateTime selectedDate,
  //   required ValueChanged<DateTime> onPicked,
  // }) async {
  //   final DateTime? picked = await showDatePicker(
  //       context: context,
  //       initialDate: selectedDate,
  //       firstDate: DateTime(1900),
  //       lastDate: DateTime.now());
  //   if (picked != null && picked != selectedDate) {
  //     onPicked(picked);
  //   }
  // }
}
