// import 'package:flutter/material.dart';
// import 'package:amarsolution_multikart/src/core/extensions/build_context_extension.dart';
// import 'package:amarsolution_multikart/src/core/utils/asset_path.dart';
// import 'package:amarsolution_multikart/src/core/utils/color.dart';
// import 'package:amarsolution_multikart/src/features/account/model/account_grid_item_model.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:amarsolution_multikart/src/features/auth/controller/auth_controller.dart';
// import 'package:amarsolution_multikart/src/features/faq/view/pages/faq_page.dart';
// import 'package:amarsolution_multikart/src/features/my_order/view/pages/my_order_page.dart';
// import 'package:amarsolution_multikart/src/features/policies/view/pages/policies_page.dart';
// import 'package:amarsolution_multikart/src/features/profile/controller/profile_controller.dart';
// import 'package:amarsolution_multikart/src/features/profile/view/pages/profile_page.dart';
// import 'package:amarsolution_multikart/src/features/support/view/pages/support_page.dart';
// import 'package:amarsolution_multikart/src/features/wishlist/view/pages/wishlist_page.dart';
//
// class AccountBodyWidget extends StatefulWidget {
//   final AuthController authController;
//   final ProfileController profileController;
//
//   const AccountBodyWidget({
//     Key? key,
//     required this.authController,
//     required this.profileController,
//   }) : super(key: key);
//
//   @override
//   State<AccountBodyWidget> createState() => _AccountBodyWidgetState();
// }
//
// class _AccountBodyWidgetState extends State<AccountBodyWidget> {
//   final items = [
//     AccountGridItemModel(
//       title: 'Support',
//       svgIcon: AssetPath.supportIcon,
//       onTap: () {
//         Get.to(() => SupportPage());
//       },
//     ),
//     AccountGridItemModel(
//       title: 'Policies',
//       svgIcon: AssetPath.policiesIcon,
//       onTap: () {
//         Get.to(() => const PoliciesPage());
//       },
//     ),
//     AccountGridItemModel(
//       title: 'FAQ',
//       svgIcon: AssetPath.helpIcon,
//       onTap: () {
//         Get.to(() => const FaqPage());
//       },
//     ),
//   ];
//
//   @override
//   void initState() {
//     updateItems();
//     super.initState();
//   }
//
//   void updateItems() {
//     if (Get.find<AuthController>().isLoggedIn) {
//       items.addAll(
//         [
//           AccountGridItemModel(
//             title: 'My Order',
//             svgIcon: AssetPath.myOrderIcon,
//             onTap: () {
//               Get.to(() => const MyOrderPage());
//             },
//           ),
//           AccountGridItemModel(
//             title: 'My Wishlist',
//             svgIcon: AssetPath.wishlistIcon,
//             onTap: () {
//               Get.to(() => const WishlistPage());
//             },
//           ),
//           AccountGridItemModel(
//             title: 'Profile',
//             svgIcon: AssetPath.profileIcon,
//             onTap: () {
//               Get.to(
//                 () => const ProfilePage(),
//               );
//             },
//           ),
//           // AccountGridItemModel(
//           //   title: 'Logout',
//           //   svgIcon: AssetPath.logoutIcon,
//           //   onTap: logoutMethod,
//           // ),
//         ],
//       );
//     }
//   }
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: context.screenWidth,
//       height: context.screenHeight,
//       decoration: BoxDecoration(
//         color: kScaffoldBackgroundColor,
//         borderRadius: const BorderRadius.vertical(
//           top: Radius.circular(20),
//         ),
//       ),
//       child: GridView.builder(
//         padding: const EdgeInsets.all(15),
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 3,
//           crossAxisSpacing: 15,
//           mainAxisSpacing: 15,
//         ),
//         itemCount: items.length,
//         itemBuilder: (context, index) => _AccountGridItemBuilder(
//           item: items[index],
//         ),
//       ),
//     );
//   }
// }
//
// class _AccountGridItemBuilder extends StatelessWidget {
//   final AccountGridItemModel item;
//
//   const _AccountGridItemBuilder({
//     Key? key,
//     required this.item,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: item.onTap,
//       child: Container(
//         decoration: BoxDecoration(
//           color: kWhite,
//           borderRadius: BorderRadius.circular(10),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.symmetric(
//             horizontal: 15,
//             vertical: 10,
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               SvgPicture.asset(
//                 item.svgIcon,
//                 height: context.screenWidth * 0.1,
//                 width: context.screenWidth * 0.1,
//                 alignment: Alignment.center,
//                 color: kBlackLight,
//               ),
//               const SizedBox(height: 10),
//               Text(
//                 item.title,
//                 maxLines: 1,
//                 overflow: TextOverflow.ellipsis,
//                 style: context.textTheme.bodySmall,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
