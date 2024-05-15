import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_echarts/flutter_echarts.dart';

class EchartBar extends StatefulWidget {
  List<Map<String, Object>> lists;
  EchartBar({Key? key, required this.lists}) : super(key: key);

  @override
  State<EchartBar> createState() => _EchartBarState();
}

class _EchartBarState extends State<EchartBar> {
  get data1 => widget.lists;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Echarts(
        option: '''
                    {
                      dataset: {
                        dimensions: ['name', 'value'],
                        source: ${jsonEncode(data1)},
                      },
                      color: ['#3398DB'],
                      legend: {
                        data: ['直接访问', '背景'],
                        show: false,
                      },
                      grid: {
                        left: '0%',
                        right: '0%',
                        bottom: '5%',
                        top: '7%',
                        height: '85%',
                        containLabel: true,
                        z: 22,
                      },
                      xAxis: [{
                        type: 'category',
                        gridIndex: 0,
                        axisTick: {
                          show: false,
                        },
                        axisLine: {
                          lineStyle: {
                            color: '#0c3b71',
                          },
                        },
                        axisLabel: {
                          show: true,
                          color: 'rgb(170,170,170)',
                          formatter: function xFormatter(value, index) {
                            if (index === 6) {
                              return `\${value}\\n*`;
                            }
                            return value;
                          },
                        },
                      }],
                      yAxis: {
                        type: 'value',
                        gridIndex: 0,
                        splitLine: {
                          show: false,
                        },
                        axisTick: {
                            show: false,
                        },
                        axisLine: {
                          lineStyle: {
                            color: '#0c3b71',
                          },
                        },
                        axisLabel: {
                          color: 'rgb(170,170,170)',
                        },
                        splitNumber: 12,
                        splitArea: {
                          show: true,
                          areaStyle: {
                            color: ['rgba(250,250,250,0.0)', 'rgba(250,250,250,0.05)'],
                          },
                        },
                      },
                      series: [{
                        name: '合格率',
                        type: 'bar',
                        barWidth: '50%',
                        xAxisIndex: 0,
                        yAxisIndex: 0,
                        itemStyle: {
                          normal: {
                            barBorderRadius: 5,
                            color: {
                              type: 'linear',
                              x: 0,
                              y: 0,
                              x2: 0,
                              y2: 1,
                              colorStops: [
                                {
                                  offset: 0, color: '#00feff',
                                },
                                {
                                  offset: 1, color: '#027eff',
                                },
                                {
                                  offset: 1, color: '#0286ff',
                                },
                              ],
                            },
                          },
                        },
                        zlevel: 11,
                      }],
                    }
                  ''',
        extraScript: '''
                    chart.on('click', (params) => {
                      print('bar click extra..');
                      if(params.componentType === 'series') {
                        Messager.postMessage(JSON.stringify({
                          type: 'select',
                          payload: params.dataIndex,
                        }));
                      }
                    });
                  ''',
        onMessage: (String message) {
          print('click message: $message');
          // Map<String, Object> messageAction = jsonDecode(message);
          // print(messageAction);
          // if (messageAction['type'] == 'select') {
          //   final item = _data1[messageAction['payload']];
          //   _scaffoldKey.currentState.showSnackBar(
          //     SnackBar(
          //       content: Text(item['name'].toString() + ': ' + display(item['value'])),
          //       duration: Duration(seconds: 2),
          //     ));
          // }
        },
      ),
      width: 300,
      height: 250,
    );
  }
}
