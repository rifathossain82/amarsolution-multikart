import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:amarsolution_multikart/src/core/theme/app_theme.dart';
import 'package:amarsolution_multikart/src/core/utils/color.dart';
import 'package:amarsolution_multikart/src/core/widgets/cached_network_image_builder.dart';
import 'package:amarsolution_multikart/src/features/product/model/product_details_model.dart';

class FullScreenImagePage extends StatelessWidget {
  final List<Photo> photos;

  FullScreenImagePage({
    super.key,
    required this.photos,
  });

  final PageController controller = PageController(
    viewportFraction: 1,
    keepPage: true,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0.0,
      ),
      backgroundColor: kBlack,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Close button
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
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
                      decoration: BoxDecoration(
                        color: kWhite,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
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
            ),

            /// Large image
            Expanded(
              child: PageView.builder(
                controller: controller,
                itemCount: photos.length,
                onPageChanged: (int index) {
                  // productDetailsController.changeIndex(index: index);
                },
                itemBuilder: (context, index) => Container(
                  color: kBlackLight,
                  width: double.infinity,
                  child: CachedNetworkImageBuilder(
                    imgURl: photos[index].image ?? '',
                    borderRadius: BorderRadius.zero,
                  ),
                ),
              ),
            ),

            /// Bottom image list
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
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
                    return InkWell(
                      onTap: () {
                        controller.jumpToPage(index);
                        // productDetailsController.changeIndex(index: index);
                      },
                      child: Container(
                        width: 40,
                        height: 80,
                        decoration: BoxDecoration(
                          color: kGreyLight,
                          border: Border.all(
                            width: 1,
                            color: 5 == index ? kPrimaryColor : kWhite,
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: CachedNetworkImageBuilder(
                          imgURl: photos[index].image ?? '',
                          borderRadius: BorderRadius.zero,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
