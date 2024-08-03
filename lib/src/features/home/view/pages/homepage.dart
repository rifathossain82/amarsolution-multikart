import 'package:amarsolution_multikart/src/core/enums/app_enum.dart';
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
                    leading: const _HomepageAppBarIconWidget(),
                    title: const _HomepageSearchWidget(),
                  ),
                  body: const HomepageAllWidget(),
                )
              : DefaultTabController(
                  length: homepageController.categoryList.length,
                  initialIndex: 0,
                  child: Scaffold(
                    appBar: AppBar(
                      leading: const _HomepageAppBarIconWidget(),
                      title: const _HomepageSearchWidget(),
                      bottom: AppBar(
                        // Prevents the back button from appearing
                        automaticallyImplyLeading: false,
                        toolbarHeight: 50,
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
                          indicator: const HomepageTabIndicator(
                            indicatorSize: IndicatorSize.full,
                            indicatorHeight: 4.0,
                            indicatorColor: kPrimaryColor,
                          ),
                          tabs: List.generate(
                              homepageController.categoryList.length, (index) {
                            if (index == 0) {
                              return const Tab(
                                text: 'All',
                              );
                            } else {
                              return Tab(
                                text:
                                    '${homepageController.categoryList[index].categoryName}',
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

class _HomepageSearchWidget extends StatelessWidget {
  const _HomepageSearchWidget();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
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
      },
      child: Container(
        height: 38,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
        ),
        decoration: BoxDecoration(
          color: kWhite,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: kPrimaryColor,
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.search,
              size: 20,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                'Search...',
                style: context.appTextTheme.titleSmall?.copyWith(
                  color: kGrey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HomepageAppBarIconWidget extends StatelessWidget {
  const _HomepageAppBarIconWidget();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 0,
      ),
      child: Image.asset(
        AssetPath.appLogo,
      ),
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
        leading: const _HomepageAppBarIconWidget(),
        title: const _HomepageSearchWidget(),
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
