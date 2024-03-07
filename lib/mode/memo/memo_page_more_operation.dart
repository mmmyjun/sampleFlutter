import 'package:flutter/material.dart';

enum OperationItem {
  canDelete,
  canSort,
}

class MemoPageMoreOperation extends StatefulWidget {
  final bool showBulkDel;
  final bool showSort;
  void Function() setBulkDel;
  void Function() setSort;
  void Function() bulkDelMemo;
  MemoPageMoreOperation(
      {Key? key,
      required this.showBulkDel,
      required this.showSort,
      required this.setBulkDel,
      required this.setSort,
      required this.bulkDelMemo})
      : super(key: key);

  @override
  State<MemoPageMoreOperation> createState() => _MemoPageMoreOperationState();
}

class _MemoPageMoreOperationState extends State<MemoPageMoreOperation> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        PopupMenuButton<OperationItem>(
          onSelected: (OperationItem result) {
            switch (result) {
              case OperationItem.canDelete:
                widget.setBulkDel();
                break;
              case OperationItem.canSort:
                widget.setSort();
                break;
            }
          },
          itemBuilder: (BuildContext context) =>
              <PopupMenuEntry<OperationItem>>[
            PopupMenuItem<OperationItem>(
              value: OperationItem.canDelete,
              child: Row(
                children: [
                  const Text('选择'),
                  widget.showBulkDel
                      ? const Icon(Icons.check)
                      : const SizedBox.shrink(),
                ],
              ),
            ),
            PopupMenuItem<OperationItem>(
              value: OperationItem.canSort,
              child: Row(
                children: [
                  const Text('排序'),
                  widget.showSort
                      ? const Icon(Icons.check)
                      : const SizedBox.shrink(),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
