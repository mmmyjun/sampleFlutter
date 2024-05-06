import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
class SwiperCardList extends StatefulWidget {
  const SwiperCardList({Key? key}) : super(key: key);

  @override
  State<SwiperCardList> createState() => _SwiperCardListState();
}

class _SwiperCardListState extends State<SwiperCardList> {
  List<String> images = [
    'assets/yellowFlower.jpeg',
    'assets/dog.jpg',
    'assets/ha.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Swiper(
      itemBuilder: (context, index) {
        final image = images[index];
        return Image.asset(
          image,
          fit: BoxFit.fill,
        );
      },
      indicatorLayout: PageIndicatorLayout.COLOR,
      autoplay: true,
      itemCount: images.length,
      pagination: const SwiperPagination(),
      control: const SwiperControl(),
    );
  }
}
