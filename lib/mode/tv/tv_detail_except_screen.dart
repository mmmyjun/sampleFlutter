import 'package:flutter/material.dart';
import './tv_models.dart';
import 'package:flutter_html/flutter_html.dart';

typedef ValueChangeCallback = void Function(int index);

class TvDetailExceptScreen extends StatefulWidget {
  TvDetailModel detailData;
  int currentIndex;
  final ValueChangeCallback changeIndex;
  TvDetailExceptScreen(
      {Key? key,
      required this.detailData,
      required this.changeIndex,
      required this.currentIndex})
      : super(key: key);

  @override
  State<TvDetailExceptScreen> createState() => TvDetailExceptScreenState();
}

class TvDetailExceptScreenState extends State<TvDetailExceptScreen> {
  get parentObj => widget.detailData;
  get detailObjLast => parentObj ?? '';
  get detailList => detailObjLast.dataList ?? [];
  get parentIndex => widget.currentIndex;
  get currentLabel => parentIndex >= 0 && detailList.length > 0
      ? detailList[parentIndex].label
      : '';
  get currentUrl => parentIndex >= 0 && detailList.length > 0
      ? detailList[parentIndex].url
      : '';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: Column(
          children: [
            const TabBar(
              tabAlignment: TabAlignment.center,
              isScrollable: true,
              tabs: [Tab(text: '简介'), Tab(text: '选集')],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  Row(
                    children: [
                      Image.network(
                        detailObjLast.pic,
                        width: 120,
                        fit: BoxFit.cover,
                        errorBuilder: (BuildContext context,
                            Object exception, StackTrace? stackTrace) {
                          return const Text('暂无图片',
                              style: TextStyle(fontSize: 16));
                        },
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(detailObjLast.name,
                                      style: const TextStyle(
                                          fontSize: 24,
                                          color: Colors.purpleAccent)),
                                  Text(
                                    detailObjLast.totalNumberOfEpisodes,
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  detailObjLast.subname.isNotEmpty
                                      ? Text('又名: ${detailObjLast.subname}')
                                      : const SizedBox.shrink(),
                                  Text('类别: ${detailObjLast.type}'),
                                  Text(
                                      '年份: ${detailObjLast.year.toString()}'),
                                  Text('地区: ${detailObjLast.area}'),
                                  Text('导演: ${detailObjLast.director}'),
                                  Text('演员: ${detailObjLast.actor}'),

                                  // Text(
                                  //     '简介: ${detailObjLast.briefIntroduction.replaceAll(RegExp(r'[<br><br />]'), '')}'),
                                  Html(
                                    data: detailObjLast.briefIntroduction,
                                  )
                                ],
                              ),
                            )),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: EpisodeContainer(
                        currentIndex: parentIndex,
                        episodeArr: detailObjLast.dataList,
                        changeIndex: widget.changeIndex),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class EpisodeContainer extends StatefulWidget {
  int currentIndex;
  List<TvDetailEpisodesModel> episodeArr = [];
  final ValueChangeCallback changeIndex;
  EpisodeContainer(
      {super.key,
      required this.currentIndex,
      required this.episodeArr,
      required this.changeIndex});

  @override
  State<EpisodeContainer> createState() => _EpisodeContainerState();
}

class _EpisodeContainerState extends State<EpisodeContainer> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: widget.episodeArr.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            // 设置每子元素的大小（宽高比）
            childAspectRatio: 2,
            // 元素的左右的 距离
            crossAxisSpacing: 18,
            // 子元素上下的 距离
            mainAxisSpacing: 12,
            crossAxisCount: MediaQuery.of(context).size.width > 1000
                ? 12
                : (MediaQuery.of(context).size.width > 600 ? 6 : 4)),
        itemBuilder: (_, int index) {
          return ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: widget.currentIndex == index
                  ? Colors.purpleAccent
                  : Colors.white,
              foregroundColor: widget.currentIndex == index
                  ? Colors.white
                  : Colors.purpleAccent,
            ),
            onPressed: () {
              print("Press index:$index");
              widget.changeIndex(index);
            },
            child: Text(widget.episodeArr[index].label),
          );
        });

    // return LayoutBuilder(
    //   builder: (BuildContext context, BoxConstraints constraints) => SingleChildScrollView(
    //     child: Wrap(
    //       children: widget.episodeArr
    //           .asMap()
    //           .keys
    //           .map((int index) => Container(
    //           width: constraints.maxWidth / (constraints.maxWidth / 120).floor(),
    //           padding: const EdgeInsets.all(5),
    //           child: TextButton(
    //             onPressed: () {
    //               setState(() {
    //                 print("Press index:$index");
    //               });
    //             }, child: Text('11'),
    //           )))
    //           .toList(),
    //     ),
    //   ),
    // );
  }
}
