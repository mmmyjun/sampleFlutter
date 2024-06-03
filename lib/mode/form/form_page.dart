import 'package:flutter/material.dart';

import './form_select_multi.dart';

class FormPage extends StatefulWidget {
  const FormPage({Key? key}) : super(key: key);

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  int selectedOne = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('文件'),
      ),
      body: Column(
        children: [
          DropdownButton(
              value: selectedOne,
              items: [
                DropdownMenuItem(child: Text('多选框'), value: 1),
                DropdownMenuItem(child: Text('多个图片'), value: 2),
              ],
              onChanged: (value) {
                print('表单选项=====$value');
                setState(() {
                  selectedOne = value as int;
                });
              }
          ),
          Expanded(
            child: FormSelectMulti(),
          )
        ],
      ),
    );
  }
}
