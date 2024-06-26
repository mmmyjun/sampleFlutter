import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:html/parser.dart';

import './tv_models.dart';
import './tv_detail.dart';

class TvList extends StatefulWidget {
  List<TvListResDataModel> lists = [];
  TvList({Key? key, required this.lists}) : super(key: key);

  @override
  State<TvList> createState() => _TvListState();
}

class _TvListState extends State<TvList> {
  int activeIndex = -1;

  get parentList => widget.lists;

  @override
  void initState() {
    super.initState();

    print('tvlist init:::${widget.lists}');

    // print('innerData::$innerData');
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _goToDetail(BuildContext context, String detailPageKey) async {
    print('tvlist goToDetail::$detailPageKey');
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TvDetail(id: detailPageKey)),
    );

    // When a BuildContext is used from a StatefulWidget, the mounted property
    // must be checked after an asynchronous gap.
    if (!context.mounted) return;

    if (result != null) {
      setState(() {});
    }

    setState(() {});
  }

  String getBotaUrl(btoaUrl) {
    return btoaUrl.replaceAll(RegExp(r'='), '');
  }

  String getPosterUrl(btoaUrl) {
    String tempBUrl = getBotaUrl(btoaUrl);
    return 'https://media-online.netlify.app/api/video/$tempBUrl?type=poster';
  }

  @override
  Widget build(BuildContext context) {
    return TabBarView(
        children: widget.lists
            .map((e) => Container(
                  child:
                    GridView.builder(
                        itemCount: e.data.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          // 设置每子元素的大小（宽高比）
                            childAspectRatio: 2,
                            // 元素的左右的 距离
                            crossAxisSpacing: 24,
                            // 子元素上下的 距离
                            mainAxisSpacing: 12,
                            crossAxisCount:
                                MediaQuery.of(context).size.width > 1000
                                    ? 3
                                    : (MediaQuery.of(context).size.width > 500
                                        ? 2
                                        : 1)),
                        itemBuilder: (_, int index) {
                          TvListModel f = e.data[index];
                          String baseSrc = base64Encode((utf8
                              .encode('${e.category}|${f.id}')));
                          String posterSrc = getPosterUrl(baseSrc);
                          // return Text(f.name);
                          return InkWell(
                            onTap: () {
                              print('card:tap:${f.name},,,${baseSrc}');
                              print(
                                  'card.getBotaUrl.${getBotaUrl(baseSrc)}');
                              print('card.posterSrc.${posterSrc}');
                              _goToDetail(context, getBotaUrl(baseSrc));
                            },
                            child: Card(
                              child: Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Image.network(
                                      posterSrc,
                                      width:  MediaQuery.of(context).size.width > 1000
                                          ? 120
                                          : (MediaQuery.of(context).size.width > 600
                                          ? 90
                                          : 80),
                                      // height: 50,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (BuildContext context,
                                          Object exception,
                                          StackTrace? stackTrace) {
                                        return const Text('暂无图片',
                                            style: TextStyle(
                                                fontSize: 16));
                                      },
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.all(8),
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(f.name,
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  color: Colors
                                                      .purpleAccent)),
                                          Row(
                                            children: [
                                              Text(f.type),
                                              const SizedBox(width: 8),
                                              Text(f.note)
                                            ],
                                          ),
                                          Text(f.last)
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        })

                ))
            .toList());
    // return TabBarView(
    //     children: widget.lists
    //         .map((e) => Column(
    //               children: [
    //                 ...e.data.map((f) {
    //                   String baseSrc = base64Encode(
    //                       (utf8.encode(e.category + '|' + f.id.toString())));
    //                   String posterSrc = getPosterUrl(baseSrc);
    //                   return Column(children: [
    //                     InkWell(
    //                       onTap: () {
    //                         print('card:tap:${f.name},,,${baseSrc}');
    //                         print('card.getBotaUrl.${getBotaUrl(baseSrc)}');
    //                         print('card.posterSrc.${posterSrc}');
    //                         _goToDetail(context, getBotaUrl(baseSrc));
    //                       },
    //                       child: Card(
    //                         child: Row(
    //                           children: [
    //                             Padding(
    //                               padding: EdgeInsets.all(8),
    //                               child: Image.network(
    //                                 posterSrc,
    //                                 width: 50,
    //                                 height: 50,
    //                                 fit: BoxFit.cover,
    //                                 errorBuilder: (BuildContext context,
    //                                     Object exception,
    //                                     StackTrace? stackTrace) {
    //                                   return const Text('暂无图片',
    //                                       style: TextStyle(fontSize: 16));
    //                                 },
    //                               ),
    //                             ),
    //                             Padding(
    //                               padding: EdgeInsets.all(16),
    //                               child: Column(
    //                                 crossAxisAlignment:
    //                                     CrossAxisAlignment.start,
    //                                 children: [
    //                                   Text(f.name,
    //                                       style: TextStyle(
    //                                           fontSize: 16,
    //                                           color: Colors.purpleAccent)),
    //                                   Row(
    //                                     children: [
    //                                       Text(f.type),
    //                                       const SizedBox(width: 8),
    //                                       Text(f.note)
    //                                     ],
    //                                   ),
    //                                   Text(f.last)
    //                                 ],
    //                               ),
    //                             )
    //                           ],
    //                         ),
    //                       ),
    //                     )
    //                   ]);
    //                 }).toList()
    //               ],
    //             ))
    //         .toList());
  }
}
