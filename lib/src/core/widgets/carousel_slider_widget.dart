import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarouselSliderWidget<T> extends StatelessWidget {
  final void Function(int, CarouselPageChangedReason)? onPageChanged;
  final List<T> items;
  final Widget Function(T) builder;

  const CarouselSliderWidget({
    super.key,
    required this.onPageChanged,
    required this.items,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        aspectRatio: 2.4,
        viewportFraction: 1,
        initialPage: 0,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 4),
        autoPlayAnimationDuration: const Duration(milliseconds: 1000),
        autoPlayCurve: Curves.easeInCubic,
        enlargeCenterPage: true,
        scrollDirection: Axis.horizontal,
        onPageChanged: onPageChanged,
      ),
      items: items.map((item) => builder(item)).toList(),
    );
  }
}
