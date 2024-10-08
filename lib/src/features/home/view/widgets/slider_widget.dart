import 'package:amarsolution_multikart/src/core/widgets/slider_indicator_widget.dart';
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
                  margin: const EdgeInsets.only(
                    top: 10,
                  ),
                  padding: const EdgeInsets.all(12.0),
                  color: kWhite,
                  width: context.screenWidth,
                  height: 220,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CarouselSliderWidget(
                        onPageChanged: (index, reason) {
                          homepageController.updateSliderIndex(index);
                        },
                        items: homepageController.sliderList,
                        builder: (item) => _SliderItemWidget(
                          imgUrl: item.image ?? '',
                        ),
                      ),
                      const SizedBox(height: 8),
                      SliderIndicatorWidget(
                        length: homepageController.sliderList.length,
                        currentIndex: homepageController.sliderIndex.value,
                      ),
                    ],
                  ),
                );
    });
  }
}

class _SliderItemWidget extends StatelessWidget {
  final String imgUrl;

  const _SliderItemWidget({
    required this.imgUrl,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImageBuilder(
      imgURl: imgUrl,
      borderRadius: BorderRadius.circular(4),
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
    );
  }
}
