import 'package:flutter/material.dart';
import './tv_models.dart';
import '../../request/tv_api.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart'; // Provides [Player], [Media], [Playlist] etc.
import 'package:media_kit_video/media_kit_video.dart';

import './tv_screen.dart';
import './tv_detail_except_screen.dart';

class TvDetail extends StatefulWidget {
  String id;
  TvDetail({Key? key, required this.id}) : super(key: key);

  @override
  State<TvDetail> createState() => _TvDetailState();
}

class _TvDetailState extends State<TvDetail> {
  String get parentId => widget.id ?? '';

  TvDetailModel detailObj = TvDetailModel.fromMap({
    'pic': '',
    'name': '',
    'note': '',
    'subname': '',
    'type': '',
    'year': -1,
    'area': '',
    'director': '',
    'actor': '',
    'des': '',
    'dataList': []
  });

  get detailObjLast => detailObj ?? '';
  get detailList => detailObjLast.dataList ?? [];

  int currentIndex = -1;

  get currentUrl => currentIndex >= 0 && detailList.length > 0
      ? detailList[currentIndex].url
      : '';

  Future<void> getData() async {
    EasyLoading.show(status: 'loading...');

    TvApi().getVideoInfoById(parentId).then((value) {
      print('tvapigetVideoInfoById res::$value');
      EasyLoading.dismiss();
      // hasSearch = true;

      int code = value['code'];
      // String msg = value['msg'];
      if (code == 0) {
        var valueData = value['data'];
        var dataList = [];
        List urlArr = valueData['dataList'][0]['urls'];
        for (int i = 0; i < urlArr.length; i++) {
          dataList.add({"label": urlArr[i]['label'], "url": urlArr[i]['url']});
        }
        detailObj = TvDetailModel.fromMap({...valueData, 'dataList': dataList});
      }

      currentIndex = 0;

      setState(() {});
    }).catchError((onError) {
      print('tvapigetVideoInfoById Error:$onError');
      EasyLoading.dismiss();
    });
  }

  void changeIndex(idx) {
    print('changeIndex::$idx');
    currentIndex = idx;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    MediaKit.ensureInitialized();

    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('详情'),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context, {});
            },
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        body: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 2,
              child: currentUrl != ''
                  ? MyScreen(currentUrl: currentUrl)
                  : const SizedBox.shrink(),
            ),
            Expanded(
              child: currentIndex >= 0 && detailObjLast != '' && detailList.length > 0
                  ? TvDetailExceptScreen(
                      detailData: detailObjLast,
                      currentIndex: currentIndex,
                      changeIndex: changeIndex)
                  : const SizedBox.shrink(),
            )
          ],
        ));
  }
}
