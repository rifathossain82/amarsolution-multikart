import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:amarsolution_multikart/src/core/extensions/build_context_extension.dart';
import 'package:amarsolution_multikart/src/core/utils/color.dart';
import 'package:amarsolution_multikart/src/core/widgets/cached_network_image_builder.dart';
import 'package:amarsolution_multikart/src/core/widgets/carousel_slider_widget.dart';
import 'package:amarsolution_multikart/src/core/widgets/k_shimmer_container.dart';
import 'package:amarsolution_multikart/src/features/home/controller/homepage_controller.dart';

class SliderWidget extends StatelessWidget {
  const SliderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final homepageController = Get.find<HomepageController>();
    return Obx(() {
      return homepageController.isSliderListLoading.value
          ? KShimmerContainer(
              width: context.screenWidth,
              height: 160,
            )
          : homepageController.sliderList.isEmpty
              ? const SizedBox()
              : Container(
                  padding: const EdgeInsets.only(
                    top: 20,
                  ),
                  alignment: Alignment.center,
                  width: context.screenWidth,
                  child: Stack(
                    alignment: Alignment.center,
                    clipBehavior: Clip.none,
                    children: [
                      CarouselSliderWidget(
                        onPageChanged: (index, reason) {
                          homepageController.updateSliderIndex(index);
                        },
                        items: homepageController.sliderList,
                        builder: (item) =>
                            _SliderItemWidget(imgUrl: item.image ?? ''),
                      ),
                      Positioned(
                        bottom: 10,
                        child: _SliderIndicatorWidget(
                          length: homepageController.sliderList.length,
                          currentIndex: homepageController.sliderIndex.value,
                        ),
                      ),
                    ],
                  ),
                );
    });
  }
}

class _SliderIndicatorWidget extends StatelessWidget {
  final int length;
  final int currentIndex;

  const _SliderIndicatorWidget({
    super.key,
    required this.length,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: context.screenWidth,
      alignment: Alignment.center,
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: length,
          itemBuilder: (context, int index) {
            return Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: currentIndex == index ? 18 : 6,
                height: 6,
                margin: const EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 5.0,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    currentIndex == index ? 15 : 30,
                  ),
                  color: currentIndex == index ? kPrimaryColor : kGreyLight,
                ),
              ),
            );
          }),
    );
  }
}

class _SliderItemWidget extends StatelessWidget {
  final String imgUrl;

  const _SliderItemWidget({
    super.key,
    required this.imgUrl,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImageBuilder(
      imgURl: imgUrl,
      borderRadius: BorderRadius.circular(0),
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
    );
  }
}
