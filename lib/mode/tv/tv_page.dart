import 'package:flutter/material.dart';
import '../../request/http_utils/base_api.dart';
import './tv_models.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../request/tv_api.dart';
import './tv_list.dart';

class TvPage extends StatefulWidget {
  const TvPage({Key? key}) : super(key: key);

  @override
  State<TvPage> createState() => _TvPageState();
}

class _TvPageState extends State<TvPage> with TickerProviderStateMixin {
  final inputController = TextEditingController(text: '');
  get inputContentIsEmpty => inputController.text.isEmpty;

  List<TvListResDataModel> lists = [];
  // bool hasSearch = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void clearSearch() {
    inputController.clear();
    setState(() {});
  }

  Future<void> toSearch() async {
    EasyLoading.show(status: 'loading...');

    lists = [];

    TvApi().getAllTvInfo(inputController.text).then((value) {
      print('tvapi res::$value');
      EasyLoading.dismiss();
      // hasSearch = true;

      int code = value['code'];
      // String msg = value['msg'];
      // if (code == 0) {
      List valueData = value['data'];

      if (code == 0) {
        for (int i = 0; i < valueData.length; i++) {
          var valueDataI = valueData[i];
          lists.add(TvListResDataModel.fromMap(valueDataI));
        }
      } else {}
      print('tvapi data:::$lists');

      setState(() {});
    }).catchError((e){
      EasyLoading.dismiss();
      print('request list error:::$e');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('影视剧'),
      ),
      body: Column(
        children: [
          Center(
            child: Row(
              children: <Widget>[
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: inputController,
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: '请输入关键词',
                        suffixIcon: IconButton(
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all(
                                  inputContentIsEmpty
                                      ? Colors.grey
                                      : Colors.purple),
                            ),
                            onPressed:
                                inputContentIsEmpty ? () {} : clearSearch,
                            icon: Icon(inputContentIsEmpty
                                ? Icons.search
                                : Icons.clear))),
                    onChanged: (value) {
                      setState(() {});
                    },
                    onSubmitted: (value) {
                      if (inputContentIsEmpty) return;
                      toSearch();
                    },
                  ),
                )),
                SizedBox(
                  width: 70,
                  child: TextButton(
                    style: ButtonStyle(
                      foregroundColor: inputContentIsEmpty
                          ? MaterialStateProperty.all(Colors.grey)
                          : MaterialStateProperty.all(Colors.purple),
                    ),
                    onPressed: () {
                      if (inputContentIsEmpty) return;
                      toSearch();
                    },
                    child: const Text('搜索'),
                  ),
                )
              ],
            ),
          ),
          lists.isNotEmpty ? const Divider(height: 1) : const SizedBox.shrink(),
          Expanded(
              child: FlutterEasyLoading(
            child: DefaultTabController(
              initialIndex: 0,
              length: lists.length,
              child: Column(
                children: [
                  TabBar(
                    isScrollable: true,
                    tabs: [
                      for (int i = 0; i < lists.length; i++)
                        Tab(text: lists[i].name)
                    ],
                  ),
                  Expanded(
                    child: TvList(lists: lists),
                  ),
                ],
              ),
            ),
          ))
        ],
      ),
    );
  }
}
