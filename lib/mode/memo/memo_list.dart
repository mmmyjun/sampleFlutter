import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sample_flutter/storage_single_pattern.dart';
import 'memo_models.dart';
import 'memo_detail.dart';

class MemoList extends StatefulWidget {
  bool inputContentIsEmpty;
  List<MemoListModel> lists = [];
  void Function(BuildContext context, MemoListModel obj) onChanged;
  void Function(int index) onDeleted;
  void Function(int x, int y) onOrderChanged;
  List<String> selectedIndex;
  bool showBulkDel;
  bool showSort;
  void Function() onBulkDel;
  void Function(String id) onSelectedIndex;
  MemoList(
      {Key? key,
      required this.inputContentIsEmpty,
      required this.lists,
      required this.onBulkDel,
      required this.onChanged,
      required this.onDeleted,
      required this.onOrderChanged,
      required this.selectedIndex,
      required this.showBulkDel,
      required this.onSelectedIndex,
      required this.showSort})
      : super(key: key);

  @override
  State<MemoList> createState() => _MemoListState();
}

class _MemoListState extends State<MemoList> {
  get parentList => widget.lists;

  void _confirmDelete(BuildContext context, int index, msg) {
    if (msg == 'OK') {
      widget.onDeleted(index);
    }
    Navigator.pop(context, msg);
  }

  void _changeCheckbox(String id) {
    widget.onSelectedIndex(id);
  }

  @override
  Widget build(BuildContext context) {
    return ReorderableListView(
      buildDefaultDragHandles: widget.showSort && widget.inputContentIsEmpty,
      padding: const EdgeInsets.all(8),
      children: <Widget>[
        for (int index = 0; index < parentList.length; index++)
          Column(
            key: Key('$index'),
            children: [
              ListTile(
                key: Key('$index'),
                title: Row(
                  children: [
                    widget.showBulkDel ? Checkbox(value: widget.selectedIndex.contains(parentList[index].id), onChanged: (e) => _changeCheckbox(parentList[index].id)) : const SizedBox.shrink(),
                    Text(parentList[index].title,
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                            fontSize: 20, color: Colors.purpleAccent)),
                    const SizedBox(width: 12),
                    Text(parentList[index].id,
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                            fontSize: 12, color: Colors.purpleAccent)),
                  ],
                ),
                subtitle: Padding(
                  padding: EdgeInsets.only(left: widget.showBulkDel ? 30 : 0),
                  child: Text(parentList[index].content,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          fontSize: 16, color: Colors.purpleAccent)),
                ),
                trailing: widget.showBulkDel ? const SizedBox.shrink() : (!widget.showSort ? IconButton(
                  icon: const Icon(Icons.delete_forever, color: Colors.purpleAccent),
                  onPressed: () => showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text('Delete Memo'),
                      content: const Text('delete this memo?'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => _confirmDelete(context, index, 'Cancel'),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () => _confirmDelete(context, index, 'OK'),
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  ),
                ) : const SizedBox.shrink()),
                onTap: () {
                  widget.onChanged(context, parentList[index]);
                },
              ),
              const Divider(
                height: 1,
                color: Colors.purpleAccent,
              ),
            ],
          )
      ],
      onReorder: (int oldIndex, int newIndex) {
        setState(() {
          if (newIndex > oldIndex) {
            newIndex -= 1;
          }
          widget.onOrderChanged(oldIndex, newIndex);
        });
      },
    );
  }
}
