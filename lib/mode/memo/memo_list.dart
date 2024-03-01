import 'package:flutter/material.dart';
import 'memo_models.dart';
import 'memo_detail.dart';

class MemoList extends StatefulWidget {
  List<MemoListModel> lists = [];
  void Function(BuildContext context, MemoListModel obj) onChanged;
  MemoList({Key? key, required this.lists, required this.onChanged}) : super(key: key);

  @override
  State<MemoList> createState() => _MemoListState();
}

class _MemoListState extends State<MemoList> {
  get parentList => widget.lists;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (BuildContext context, int index) => const Divider(),
      itemCount: parentList.length,
      itemBuilder: (_, int index) {
        return ListTile(
          title: Text(parentList[index].title,
              textAlign: TextAlign.left,
              style: const TextStyle(fontSize: 24, color: Colors.black)),
          subtitle: Text(parentList[index].content,
              textAlign: TextAlign.left,
              style: const TextStyle(fontSize: 18, color: Colors.blue)),
          trailing: Text(parentList[index].id,
              textAlign: TextAlign.right,
              style: const TextStyle(fontSize: 12, color: Colors.green)),
          onTap: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => MemoDetail(obj: parentList[index]),
            //   ),
            // );

            widget.onChanged(context, parentList[index]);
          },
        );
      },
    );
  }
}
