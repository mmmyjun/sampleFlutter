import 'package:flutter/material.dart';
import 'memo_models.dart';
import 'memo_list.dart';
import 'memo_detail.dart';

class MemoPage extends StatefulWidget {
  const MemoPage({Key? key}) : super(key: key);

  @override
  State<MemoPage> createState() => _MemoPageState();
}

class _MemoPageState extends State<MemoPage> {
  @override
  void initState() {
    super.initState();
  }

  final inputController = TextEditingController(text: '');
  List<MemoListModel> memoList = [];

  get inputContentIsEmpty => inputController.text.isEmpty;

  void clearSearch() {
    inputController.clear();
    setState(() {});
  }

  void toSearch() {
    print('searching......');
    memoList = memoList
        .where((element) =>
            element.title.contains(inputController.text) ||
            element.content.contains(inputController.text))
        .toList();
    setState(() {});
  }

  Future<void> _navigateAndDisplaySelection(BuildContext context, MemoListModel? paramOfDetail) async {
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
      if (memoList[index].title != title || memoList[index].content != content) {
        memoList.removeAt(index);
      }
    }
    print('index: $index, id: $id, title: $title, content: $content');
    setState(() {
      if ((index == -1 || (memoList[index].title != title || memoList[index].content != content)) && (title != '' || content != '')) {
        memoList = [MemoListModel(id: formattedDate, title: title, content: content, date: formattedDate), ...memoList];
      }
    });


    // After the Selection Screen returns a result, hide any previous snackbars
    // and show the new result.
    // ScaffoldMessenger.of(context)
    //   ..removeCurrentSnackBar()
    //   ..showSnackBar(SnackBar(content: Text('$result')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('备忘录'),
      ),
      body: Column(
        children: [
          // Padding(
          //   padding: EdgeInsets.all(4),
          //   child: TextField(
          //     controller: inputController,
          //     decoration: InputDecoration(
          //         border: const OutlineInputBorder(),
          //         labelText: '请输入关键词: 标题/内容',
          //         suffixIcon: IconButton(
          //             style: ButtonStyle(
          //               foregroundColor: MaterialStateProperty.all(
          //                   inputContentIsEmpty ? Colors.grey : Colors.purple),
          //             ),
          //             onPressed: inputContentIsEmpty ? () {} : clearSearch,
          //             icon: Icon(
          //                 inputContentIsEmpty ? Icons.search : Icons.clear))),
          //     onChanged: (value) {
          //       toSearch();
          //     },
          //     onSubmitted: (value) {
          //       if (inputContentIsEmpty) return;
          //     },
          //   ),
          // ),
          Expanded(child: MemoList(lists: memoList, onChanged: _navigateAndDisplaySelection)),
        ],
      ),
      floatingActionButton: FloatingActionButton.small(
        onPressed: () {
          print('add floating button clicked');
          _navigateAndDisplaySelection(context, null);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
