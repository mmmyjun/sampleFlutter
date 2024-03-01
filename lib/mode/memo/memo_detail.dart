import 'package:flutter/material.dart';
import 'memo_models.dart';

class MemoDetail extends StatefulWidget {
  MemoListModel? obj;
  MemoDetail({Key? key, this.obj}) : super(key: key);

  @override
  State<MemoDetail> createState() => _MemoDetailState();
}

class _MemoDetailState extends State<MemoDetail> {
  get oId => widget.obj?.id ?? '';

  final idController = TextEditingController(text: '');
  final inputController = TextEditingController(text: '');
  final textareaController = TextEditingController(text: '');

  @override
  void initState() {
    super.initState();

    idController.text = oId;
    inputController.text = widget.obj?.title ?? '';
    textareaController.text = widget.obj?.content ?? '';
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('详情'),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context, {
                'id': oId,
                'title': inputController.text,
                'content': textareaController.text,
              });
            },
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        body: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    'id: $oId',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  )
              ),
              Padding(
                  padding: const EdgeInsets.all(8),
                  child: TextFormField(
                    controller: inputController,
                    decoration: const InputDecoration(
                        labelText: '请输入标题', hintText: '标题'),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return '请输入标题~~';
                      }
                      return null;
                    },
                    onChanged: (value) {
                    },
                  )
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: TextFormField(
                    controller: textareaController,
                    decoration:
                    const InputDecoration(labelText: '请输入内容', hintText: '内容'),
                    validator: (String? value) {
                      print('validator 内容:$value');
                      if (value == null || value.isEmpty) {
                        return '请输入内容~~';
                      }
                      return null;
                    },
                    maxLines: 10,
                    onChanged: (value) {
                    },
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
