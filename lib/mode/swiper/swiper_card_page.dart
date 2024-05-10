import 'package:flutter/material.dart';
import 'dart:io';

import 'swiper_card_list.dart';

class SwiperCardPage extends StatefulWidget {
  const SwiperCardPage({Key? key}) : super(key: key);

  @override
  State<SwiperCardPage> createState() => _SwiperCardPageState();
}

class _SwiperCardPageState extends State<SwiperCardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('轮播'),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: Platform.isAndroid || Platform.isIOS ?  300 : MediaQuery.of(context).size.height - 100,
              child: SwiperCardList(),
            ),
            Expanded(
              child: Text('其他内容补充中'),
            )
          ],
        )
      )
    );
  }
}
