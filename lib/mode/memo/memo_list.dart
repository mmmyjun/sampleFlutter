import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sample_flutter/storage_single_pattern.dart';
import 'memo_models.dart';
import 'memo_detail.dart';

class MemoList extends StatefulWidget {
  List<MemoListModel> lists = [];
  void Function(BuildContext context, MemoListModel obj) onChanged;
  void Function(int index) onDeleted;
  MemoList(
      {Key? key,
      required this.lists,
      required this.onChanged,
      required this.onDeleted})
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

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color oddItemColor = colorScheme.secondary.withOpacity(0.05);
    final Color evenItemColor = colorScheme.secondary.withOpacity(0.15);
    final Color draggableItemColor = colorScheme.secondary;

    Widget proxyDecorator(
        Widget child, int index, Animation<double> animation) {
      return AnimatedBuilder(
        animation: animation,
        builder: (BuildContext context, Widget? child) {
          final double animValue = Curves.easeInOut.transform(animation.value);
          final double elevation = lerpDouble(0, 6, animValue)!;
          return Material(
            elevation: elevation,
            color: draggableItemColor,
            shadowColor: draggableItemColor,
            child: child,
          );
        },
        child: child,
      );
    }
    return ReorderableListView(
      padding: const EdgeInsets.all(8),
      proxyDecorator: proxyDecorator,
      children: <Widget>[
        for (int index = 0; index < parentList.length; index++)
          ListTile(
            key: Key('$index'),
            title: Row(
              children: [
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
            subtitle: Text(parentList[index].content,
                textAlign: TextAlign.left,
                style: const TextStyle(fontSize: 18, color: Colors.purpleAccent)),
            trailing: IconButton(
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
            ),
            onTap: () {
              widget.onChanged(context, parentList[index]);
            },
          ),
      ],
      onReorder: (int oldIndex, int newIndex) {
        setState(() {
          if (newIndex > oldIndex) {
            newIndex -= 1;
          }
          final MemoListModel item = parentList.removeAt(oldIndex);
          parentList.insert(newIndex, item);

          StorageSinglePattern().write(
              'memoList',
              json.encode(parentList.map((e) => e.toMap()).toList()));
        });
      },
    );
    return ListView.separated(
      separatorBuilder: (BuildContext context, int index) => const Divider(),
      itemCount: parentList.length,
      itemBuilder: (_, int index) {
        return ListTile(
          title: Row(
            children: [
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
          subtitle: Text(parentList[index].content,
              textAlign: TextAlign.left,
              style: const TextStyle(fontSize: 18, color: Colors.purpleAccent)),
          trailing: IconButton(
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
          ),
          onTap: () {
            widget.onChanged(context, parentList[index]);
          },
        );
      },
    );
  }
}
