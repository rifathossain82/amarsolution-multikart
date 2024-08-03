import 'package:amarsolution_multikart/src/core/enums/app_enum.dart';
import 'package:amarsolution_multikart/src/core/extensions/text_style_extension.dart';
import 'package:amarsolution_multikart/src/core/utils/app_constants.dart';
import 'package:amarsolution_multikart/src/core/widgets/cached_network_image_builder.dart';
import 'package:amarsolution_multikart/src/features/category/model/category_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:amarsolution_multikart/src/core/extensions/build_context_extension.dart';
import 'package:amarsolution_multikart/src/core/network/api.dart';
import 'package:amarsolution_multikart/src/core/utils/asset_path.dart';
import 'package:amarsolution_multikart/src/core/utils/color.dart';
import 'package:amarsolution_multikart/src/core/widgets/k_shimmer_container.dart';
import 'package:amarsolution_multikart/src/features/home/controller/homepage_controller.dart';
import 'package:amarsolution_multikart/src/features/home/view/widgets/flash_sales_widget.dart';
import 'package:amarsolution_multikart/src/features/home/view/widgets/homepage_all_widget.dart';
import 'package:amarsolution_multikart/src/features/home/view/widgets/homepage_category_tab_widget.dart';
import 'package:amarsolution_multikart/src/features/home/view/widgets/homepage_product_loading_widget.dart';
import 'package:amarsolution_multikart/src/features/home/view/widgets/homepage_tab_indicator.dart';
import 'package:amarsolution_multikart/src/features/home/view/widgets/new_arrival_widget.dart';
import 'package:amarsolution_multikart/src/features/product/controller/product_controller.dart';
import 'package:amarsolution_multikart/src/features/product/view/pages/product_page_with_search.dart';
import 'package:amarsolution_multikart/src/features/search/view/pages/search_page.dart';
import 'package:google_fonts/google_fonts.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final homepageController = Get.find<HomepageController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return homepageController.isCategoryListLoading.value
          ? const _HomepageLoadingWidget()
          : homepageController.categoryList.isEmpty
              ? Scaffold(
                  appBar: AppBar(
                    leading: const _AppBarLeadingWidget(),
                    title: const _AppBarTitleWidget(),
                  ),
                  body: const HomepageAllWidget(),
                )
              : DefaultTabController(
                  length: homepageController.categoryList.length,
                  initialIndex: 0,
                  child: Scaffold(
                    appBar: AppBar(
                      leading: const _AppBarLeadingWidget(),
                      title: const _AppBarTitleWidget(),
                      actions: const _AppBarActions().buildActions(context),
                      bottom: AppBar(
                        // Prevents the back button from appearing
                        automaticallyImplyLeading: false,
                        toolbarHeight: 65,
                        title: TabBar(
                          indicatorColor: kPrimaryColor,
                          labelColor: kPrimaryColor,
                          isScrollable: true,
                          unselectedLabelColor: kBlackLight,
                          unselectedLabelStyle: context.appTextTheme.bodySmall,
                          labelStyle: context.appTextTheme.bodySmall?.copyWith(
                            color: kPrimaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                          labelPadding: const EdgeInsets.symmetric(
                            horizontal: 6,
                          ),
                          padding: EdgeInsets.zero,
                          indicatorPadding: EdgeInsets.zero,
                          indicatorSize: TabBarIndicatorSize.label,
                          overlayColor: const MaterialStatePropertyAll(Colors.transparent),
                          indicator: const BoxDecoration(),
                          tabs: List.generate(
                              homepageController.categoryList.length, (index) {
                            if (index == 0) {
                              return _TabItem(
                                category: CategoryModel(
                                  categoryName: "All",
                                  image: "",
                                ),
                              );
                            } else {
                              return _TabItem(
                                category:
                                    homepageController.categoryList[index],
                              );
                            }
                          }),
                        ),
                      ),
                    ),
                    body: TabBarView(
                      physics: const NeverScrollableScrollPhysics(),
                      children: List.generate(
                          homepageController.categoryList.length, (index) {
                        if (index == 0) {
                          return const HomepageAllWidget();
                        } else {
                          return HomepageCategoryTabWidget(
                            categoryId:
                                '${homepageController.categoryList[index].id}',
                          );
                        }
                      }),
                    ),
                  ),
                );
    });
  }
}

class _AppBarLeadingWidget extends StatelessWidget {
  const _AppBarLeadingWidget();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 0,
      ),
      child: Image.asset(
        AssetPath.menu,
      ),
    );
  }
}

class _AppBarTitleWidget extends StatelessWidget {
  const _AppBarTitleWidget();

  @override
  Widget build(BuildContext context) {
    return Text(
      AppConstants.appName,
      style: GoogleFonts.blackOpsOne(
        fontWeight: FontWeight.w500,
        fontSize: 22,
        foreground: Paint()
          ..shader = const LinearGradient(
            colors: <Color>[kPrimaryColor, kBlackLight],
          ).createShader(
            const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0),
          ),
      ),
    );
  }
}

class _AppBarActions extends StatelessWidget {
  const _AppBarActions();

  List<Widget> buildActions(BuildContext context) {
    return [
      _ActionItem(
        onPressed: _onSearch,
        iconData: Icons.search,
      ),
      _ActionItem(
        onPressed: () {
          // Handle search action
        },
        iconData: Icons.notifications_none,
      ),
      _ActionItem(
        onPressed: () {
          // Handle search action
        },
        iconData: Icons.favorite_border,
      ),
      _ActionItem(
        onPressed: () {
          // Handle search action
        },
        iconData: Icons.shopping_cart_outlined,
      ),
      const SizedBox(width: 8),
    ];
  }

  void _onSearch() {
    Get.to(
      () => SearchPage(
        onSearch: (value) {
          /// To set search text in product controller
          Get.find<ProductController>().updateSearchText(value);

          /// For first time we need to close the search page and open product page
          Get
            ..back()
            ..to(
              () => ProductPageWithSearch(
                api: Api.productList,
              ),
            );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class _ActionItem extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData iconData;

  const _ActionItem({
    required this.onPressed,
    required this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Icon(
          iconData,
          size: 20,
        ),
      ),
    );
  }
}

class _TabItem extends StatelessWidget {
  final CategoryModel category;

  const _TabItem({
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CachedNetworkImageBuilder(
          imgURl: category.image ?? '',
          borderRadius: BorderRadius.circular(100),
          height: 45,
          width: 45,
          fit: BoxFit.cover,
        ),
        const SizedBox(height: 2),
        Text(
          category.categoryName.toString().length > 6
              ? category.categoryName.toString().substring(0, 6)
              : category.categoryName.toString(),
          maxLines: 1,
          style: context.bodyMedium(),
        ),
      ],
    );
  }
}

class _HomepageLoadingWidget extends StatelessWidget {
  const _HomepageLoadingWidget();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: const _AppBarLeadingWidget(),
        title: const _AppBarTitleWidget(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 60,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 10,
                ),
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: 20,
                itemBuilder: (context, int index) => const KShimmerContainer(
                  height: 20,
                  width: 80,
                  borderRadius: 8,
                ),
                separatorBuilder: (context, index) => const SizedBox(width: 10),
              ),
            ),
            KShimmerContainer(
              height: 160,
              width: context.screenWidth,
            ),
            const HomepageProductLoadingWidget(
              height: newArrivalItemHeight,
              width: newArrivalItemWidth,
            ),
            const HomepageProductLoadingWidget(
              height: flashSalesItemHeight,
              width: flashSalesItemWidth,
            ),
            const HomepageProductLoadingWidget(
              height: newArrivalItemHeight,
              width: newArrivalItemWidth,
            ),
          ],
        ),
      ),
    );
  }
}
