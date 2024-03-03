import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'memo_models.dart';
import 'memo_list.dart';
import 'memo_detail.dart';

class MemoPage extends StatefulWidget {
  const MemoPage({Key? key}) : super(key: key);

  @override
  State<MemoPage> createState() => _MemoPageState();
}

class _MemoPageState extends State<MemoPage> {
  final storage = const FlutterSecureStorage();

  final inputController = TextEditingController(text: '');
  List<MemoListModel> memoList = [];

  @override
  void initState() {
    super.initState();

    storage.read(key: 'memoList').then((value) {
      if (value != null) {
        var list = json.decode(value);
        memoList =
            list.map<MemoListModel>((e) => MemoListModel.fromMap(e)).toList();
        setState(() {});
      }
    });
  }

  get inputContentIsEmpty => inputController.text.isEmpty;

  get filteredList => memoList
      .where((element) =>
          element.title.contains(inputController.text) ||
          element.content.contains(inputController.text))
      .toList();

  void clearSearch() {
    inputController.clear();
    setState(() {});
  }

  void toSearch() {
    setState(() {});
  }

  Future<void> _navigateAndDisplaySelection(
      BuildContext context, MemoListModel? paramOfDetail) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MemoDetail(obj: paramOfDetail)),
    );

    // When a BuildContext is used from a StatefulWidget, the mounted property
    // must be checked after an asynchronous gap.
    if (!context.mounted) return;

    DateTime now = DateTime.now();
    String formattedDate = now.toString().substring(0, 19);

    var id = result['id'];
    var title = result['title'];
    var content = result['content'];
    var index = memoList.indexWhere((element) => id != '' && element.id == id);
    if (index != -1) {
      if (memoList[index].title != title ||
          memoList[index].content != content) {
        memoList.removeAt(index);

        storage.write(
            key: 'memoList',
            value: json.encode(memoList.map((e) => e.toMap()).toList()));
      }
    }
    setState(() {
      if ((index == -1 ||
              (memoList[index].title != title ||
                  memoList[index].content != content)) &&
          (title != '' || content != '')) {
        memoList = [
          MemoListModel.fromMap({
            'id': formattedDate,
            'title': title,
            'content': content,
            'date': formattedDate
          }),
          ...memoList
        ];

        storage.write(
            key: 'memoList',
            value: json.encode(memoList.map((e) => e.toMap()).toList()));
      }
    });

    // After the Selection Screen returns a result, hide any previous snackbars
    // and show the new result.
    // ScaffoldMessenger.of(context)
    //   ..removeCurrentSnackBar()
    //   ..showSnackBar(SnackBar(content: Text('$result')));
  }

  void _deleteMemo(int index) {
    memoList.removeAt(index);
    storage.write(
        key: 'memoList',
        value: json.encode(memoList.map((e) => e.toMap()).toList()));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('备忘录'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: inputController,
              decoration: InputDecoration(
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.purple),
                  ),
                  labelText: '请输入关键词: 标题/内容',
                  suffixIcon: IconButton(
                      style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all(
                            inputContentIsEmpty ? Colors.grey : Colors.purple),
                      ),
                      onPressed: inputContentIsEmpty ? () {} : clearSearch,
                      icon: Icon(
                          inputContentIsEmpty ? Icons.search : Icons.clear))),
              onChanged: (value) {
                toSearch();
              },
              onSubmitted: (value) {
                if (inputContentIsEmpty) return;
              },
            ),
          ),
          Expanded(
              child: MemoList(
                  lists: filteredList,
                  onChanged: _navigateAndDisplaySelection,
                  onDeleted: _deleteMemo)),
        ],
      ),
      floatingActionButton: FloatingActionButton.small(
        onPressed: () {
          _navigateAndDisplaySelection(context, null);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
