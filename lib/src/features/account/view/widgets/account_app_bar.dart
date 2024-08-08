// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:amarsolution_multikart/src/core/enums/app_enum.dart';
// import 'package:amarsolution_multikart/src/core/extensions/build_context_extension.dart';
// import 'package:amarsolution_multikart/src/core/services/local_storage.dart';
// import 'package:amarsolution_multikart/src/core/utils/asset_path.dart';
// import 'package:amarsolution_multikart/src/core/utils/color.dart';
// import 'package:amarsolution_multikart/src/core/widgets/cached_network_image_builder.dart';
// import 'package:amarsolution_multikart/src/core/widgets/k_box_shadow.dart';
// import 'package:amarsolution_multikart/src/core/widgets/k_button_progress_indicator.dart';
// import 'package:amarsolution_multikart/src/features/profile/model/user_model.dart';
// import 'package:amarsolution_multikart/src/features/auth/controller/auth_controller.dart';
// import 'package:amarsolution_multikart/src/features/auth/view/pages/login_page.dart';
// import 'package:amarsolution_multikart/src/features/profile/view/pages/profile_page.dart';
//
// class AccountAppBar extends StatelessWidget {
//   final UserModel? user;
//   final AuthController authController;
//
//   const AccountAppBar({
//     Key? key,
//     required this.user,
//     required this.authController,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return LocalStorage.getData(key: LocalStorageKey.isGuestCheckout) == true
//         ? const _GuestUserAppBar()
//         : authController.isLoggedIn && user != null
//             ? _UserAppBar(
//                 user: user!,
//                 authController: authController,
//               )
//             : const _EmptyUserAppBar();
//   }
// }
//
// class _UserAppBar extends StatelessWidget {
//   final UserModel user;
//   final AuthController authController;
//
//   const _UserAppBar({
//     Key? key,
//     required this.user,
//     required this.authController,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(
//         horizontal: 10.0,
//         vertical: 25,
//       ),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           GestureDetector(
//             onTap: () {
//               Get.to(
//                 () => const ProfilePage(),
//               );
//             },
//             child: CachedNetworkImageBuilder(
//               height: 60,
//               width: 60,
//               imgURl: user.image ?? '',
//               fit: BoxFit.cover,
//               borderRadius: BorderRadius.circular(100),
//               isBorderActive: true,
//             ),
//           ),
//           const SizedBox(width: 15),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   user.name ?? '',
//                   style: context.appTextTheme.titleMedium?.copyWith(
//                     color: kWhite,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(height: 2),
//                 Text(
//                   user.phone ?? '',
//                   style: context.appTextTheme.bodySmall?.copyWith(
//                     color: kWhite,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           GestureDetector(
//             onTap: () => logoutMethod(context),
//             child: SvgPicture.asset(
//               AssetPath.logoutIcon,
//               height: context.screenWidth * 0.07,
//               width: context.screenWidth * 0.07,
//               alignment: Alignment.center,
//               color: kWhite,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void logoutMethod(BuildContext context) {
//     showDialog(
//         context: context,
//         builder: (context) {
//           return AlertDialog(
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(10),
//             ),
//             icon: Icon(
//               Icons.question_mark,
//               color: kPrimaryColor,
//             ),
//             title: Text(
//               'Are you sure you want to logout?',
//               style: context.textTheme.titleMedium,
//             ),
//             actionsAlignment: MainAxisAlignment.spaceEvenly,
//             actions: [
//               TextButton(
//                 onPressed: () => Navigator.pop(context),
//                 child: Text(
//                   'Cancel',
//                   style: context.textTheme.bodyMedium?.copyWith(
//                     color: kGrey,
//                   ),
//                 ),
//               ),
//               TextButton(
//                 onPressed: () {
//                   authController.logout();
//                 },
//                 child: Obx(
//                   () => authController.isLogoutLoading.value
//                       ? KButtonProgressIndicator(
//                           indicatorColor: kPrimaryColor,
//                         )
//                       : Text(
//                           'Logout',
//                           style: context.textTheme.bodyMedium?.copyWith(
//                             color: kPrimaryColor,
//                           ),
//                         ),
//                 ),
//               ),
//             ],
//           );
//         });
//   }
// }
//
// class _EmptyUserAppBar extends StatelessWidget {
//   const _EmptyUserAppBar({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(
//         horizontal: 10.0,
//         vertical: 25,
//       ),
//       child: Row(
//         children: [
//           GestureDetector(
//             onTap: () {
//               Get.to(
//                 () => const LoginPage(),
//               );
//             },
//             child: CachedNetworkImageBuilder(
//               height: 60,
//               width: 60,
//               imgURl: '',
//               borderRadius: BorderRadius.circular(100),
//             ),
//           ),
//           const SizedBox(width: 15),
//           GestureDetector(
//             onTap: () {
//               Get.to(
//                 () => const LoginPage(),
//               );
//             },
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Container(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 8,
//                     vertical: 6,
//                   ),
//                   decoration: BoxDecoration(
//                     color: kWhite,
//                     borderRadius: BorderRadius.circular(5),
//                     boxShadow: [
//                       KBoxShadow.itemShadow(),
//                     ],
//                   ),
//                   child: Text(
//                     'Register / Login',
//                     style: context.appTextTheme.titleSmall,
//                   ),
//                 ),
//                 const SizedBox(height: 5),
//                 Text(
//                   'Login with phone number',
//                   style: context.appTextTheme.bodySmall?.copyWith(
//                     color: kWhite,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class _GuestUserAppBar extends StatelessWidget {
//   const _GuestUserAppBar({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(
//         horizontal: 10.0,
//         vertical: 25,
//       ),
//       child: Row(
//         children: [
//           CachedNetworkImageBuilder(
//             height: 60,
//             width: 60,
//             imgURl: '',
//             borderRadius: BorderRadius.circular(100),
//           ),
//           const SizedBox(width: 15),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Guest User',
//                   style: context.appTextTheme.titleMedium?.copyWith(
//                     color: kWhite,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(height: 2),
//                 Text(
//                   'Order now without login!',
//                   style: context.appTextTheme.bodySmall?.copyWith(
//                     color: kWhite,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
