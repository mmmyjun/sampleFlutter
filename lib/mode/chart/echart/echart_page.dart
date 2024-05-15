import 'package:flutter/material.dart';
import './echart_bar.dart';
import '/common_model.dart';

class EchartPage extends StatefulWidget {
  const EchartPage({Key? key}) : super(key: key);

  @override
  State<EchartPage> createState() => _EchartPageState();
}

class _EchartPageState extends State<EchartPage> {
  int selectedOne = 1;

  List<Map<String, Object>> lists = [
    {
      'label': 'Jan',
      'value':  8726.2453,
    },
    {
      'label': 'Feb',
      'value':  445.245,
    },
    {
      'label': 'Mar',
      'value': 6636.2400,
    },
    {
      'label': 'Apr',
      'value': 4774.2453,
    },
    {
      'label': 'May',
      'value': 1066.2453,
    },
  ];

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
              items: const [
                DropdownMenuItem(child: Text('柱状图'), value: 1),
                DropdownMenuItem(child: Text('饼图'), value: 2),
              ],
              onChanged: (value) {
                print('选择图片=====$value');
                setState(() {
                  selectedOne = value as int;
                });
              }
          ),
          Expanded(
            child: EchartBar(lists: lists),
          )
        ],
      ),
    );
  }
}
