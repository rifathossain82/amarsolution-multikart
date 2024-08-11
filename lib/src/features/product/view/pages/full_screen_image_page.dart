import 'package:amarsolution_multikart/src/core/theme/app_theme.dart';
import 'package:amarsolution_multikart/src/features/product/controller/full_screen_image_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:amarsolution_multikart/src/core/utils/color.dart';
import 'package:amarsolution_multikart/src/core/widgets/cached_network_image_builder.dart';
import 'package:amarsolution_multikart/src/features/product/model/product_details_model.dart';

class FullScreenImagePage extends StatefulWidget {
  final List<Photo> photos;

  const FullScreenImagePage({
    super.key,
    required this.photos,
  });

  @override
  _FullScreenImagePageState createState() => _FullScreenImagePageState();
}

class _FullScreenImagePageState extends State<FullScreenImagePage> {
  late PageController controller;
  late FullScreenImageController fullScreenImageController;

  @override
  void initState() {
    super.initState();
    controller = PageController(
      viewportFraction: 1,
      keepPage: true,
      initialPage: 0,
    );

    fullScreenImageController = Get.find<FullScreenImageController>()
      ..updateIndex(0);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0.0,
        systemOverlayStyle: AppTheme.darkSystemOverlayStyle(),
      ),
      backgroundColor: kBlack,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _CloseButton(),
            _LargeImageView(
              pageController: controller,
              photos: widget.photos,
              onPageChanged: (int index) {
                fullScreenImageController.updateIndex(index);
              },
            ),
            _HorizontalImageList(
              photos: widget.photos,
              onTapImage: (int index) {
                setState(() {
                  controller.jumpToPage(index);
                  fullScreenImageController.updateIndex(index);
                });
              },
            )
          ],
        ),
      ),
    );
  }
}

class _CloseButton extends StatelessWidget {
  const _CloseButton();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          InkWell(
            onTap: () => Get.back(),
            child: Container(
              alignment: Alignment.centerRight,
              height: 30,
              width: 30,
              margin: const EdgeInsets.only(
                top: 0,
              ),
              decoration: const BoxDecoration(
                color: kWhite,
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Icon(
                  Icons.close,
                  size: 18,
                  color: kBlack,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LargeImageView extends StatelessWidget {
  final PageController pageController;
  final List<Photo> photos;
  final Function(int index) onPageChanged;

  const _LargeImageView({
    required this.pageController,
    required this.photos,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: PageView.builder(
        controller: pageController,
        itemCount: photos.length,
        onPageChanged: onPageChanged,
        itemBuilder: (context, index) => Container(
          color: kBlackLight,
          width: double.infinity,
          child: CachedNetworkImageBuilder(
            imgURl: photos[index].image ?? '',
            borderRadius: BorderRadius.zero,
            backgroundColor: kBlack,
          ),
        ),
      ),
    );
  }
}

class _HorizontalImageList extends StatelessWidget {
  final List<Photo> photos;
  final Function(int index) onTapImage;

  const _HorizontalImageList({
    required this.photos,
    required this.onTapImage,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FullScreenImageController>();

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 20,
      ),
      child: SizedBox(
        height: 60,
        child: GridView.builder(
          physics: const ScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: photos.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            mainAxisSpacing: 5,
          ),
          itemBuilder: (context, int index) {
            return Obx(() {
              return InkWell(
                onTap: () => onTapImage(index),
                child: Container(
                  width: 40,
                  height: 80,
                  decoration: BoxDecoration(
                    color: kGreyLight,
                    border: Border.all(
                      width: 3,
                      color: controller.currentIndex.value == index
                          ? kPrimaryColor
                          : kGrey,
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CachedNetworkImageBuilder(
                        imgURl: photos[index].image ?? '',
                        borderRadius: BorderRadius.circular(3),
                      ),
                      if (controller.currentIndex.value == index)
                        const Icon(
                          Icons.check,
                          color: kPrimaryColor,
                          size: 35,
                        ),
                    ],
                  ),
                ),
              );
            });
          },
        ),
      ),
    );
  }
}
