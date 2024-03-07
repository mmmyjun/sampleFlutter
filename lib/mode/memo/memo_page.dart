import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../storage_single_pattern.dart';
import 'memo_models.dart';
import 'memo_list.dart';
import 'memo_detail.dart';

import 'memo_page_more_operation.dart';

class MemoPage extends StatefulWidget {
  const MemoPage({Key? key}) : super(key: key);

  @override
  State<MemoPage> createState() => _MemoPageState();
}

class _MemoPageState extends State<MemoPage> {
  final inputController = TextEditingController(text: '');
  List<MemoListModel> memoList = [];

  @override
  void initState() {
    super.initState();

    StorageSinglePattern().read('memoList').then((value) {
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

        StorageSinglePattern().write(
            'memoList',
            json.encode(memoList.map((e) => e.toMap()).toList()));
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

        StorageSinglePattern().write(
            'memoList',
            json.encode(memoList.map((e) => e.toMap()).toList()));
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
    StorageSinglePattern().write(
        'memoList', json.encode(memoList.map((e) => e.toMap()).toList()));
    setState(() {});
  }

  /// 批量删除、排序
  bool showBulkDel = false, showSort = false;
  List<String> selectedIndex = [];
  void _setBulkDel() {
    showSort = false;
    showBulkDel = !showBulkDel;
    selectedIndex = [];
    setState(() {});
  }
  void _setSort() {
    showBulkDel = false;
    selectedIndex = [];
    showSort = !showSort;
    setState(() {});
  }
  void _bulkDelMemo() {
    memoList.removeWhere((element) => selectedIndex.contains(element.id));
    setState(() {
      selectedIndex = [];
      StorageSinglePattern().write(
          'memoList', json.encode(memoList.map((e) => e.toMap()).toList()));
    });
  }
  void _orderChanged(int oldIndex, int newIndex) {
    final MemoListModel item = memoList.removeAt(oldIndex);
    memoList.insert(newIndex, item);

    StorageSinglePattern().write(
        'memoList', json.encode(memoList.map((e) => e.toMap()).toList()));
    setState(() {});
  }

  void _setSelectedIndex(String id) {
    if (selectedIndex.contains(id)) {
      selectedIndex.remove(id);
    } else {
      selectedIndex.add(id);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('备忘录'),
        actions: [
          memoList.isNotEmpty && showBulkDel ? Row(
            children: [
              TextButton(onPressed: (){
                if(selectedIndex.length == memoList.length) {
                  selectedIndex = [];
                } else {
                  selectedIndex = memoList.map((e) => e.id).toList();
                }
                setState(() {});
              }, child: Text(selectedIndex.length == memoList.length ? '全不选' : '全选')),
              selectedIndex.isNotEmpty ? TextButton(onPressed: (){_bulkDelMemo();}, child: const Text('删除')) : const SizedBox.shrink(),
            ],
          ) : const SizedBox.shrink(),
          const SizedBox(width: 24),
          MemoPageMoreOperation(
              showBulkDel: showBulkDel,
              showSort: showSort,
              setBulkDel: _setBulkDel,
              setSort: _setSort,
              bulkDelMemo: _bulkDelMemo),
        ],
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
                  selectedIndex: selectedIndex,
                  onSelectedIndex: _setSelectedIndex,
                  showBulkDel: showBulkDel,
                  showSort: showSort,
                  lists: filteredList as List<MemoListModel>,
                  onBulkDel: _bulkDelMemo,
                  onOrderChanged: _orderChanged,
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
