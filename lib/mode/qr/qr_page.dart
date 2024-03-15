import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:sample_flutter/storage_single_pattern.dart';
import 'qr_settings.dart';

class QrPage extends StatefulWidget {
  const QrPage({Key? key}) : super(key: key);

  @override
  State<QrPage> createState() => _QrPageState();
}

class _QrPageState extends State<QrPage> {
  final inputController = TextEditingController(text: '');
  String inputOfQrCode = '';
  int qrVersion = QrVersions.auto;
  int errorCorrectionLevel = QrErrorCorrectLevel.M;
  bool gapLess = false;

  get inputContentIsEmpty => inputController.text.isEmpty;

  void clearSearch() {
    inputController.clear();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    StorageSinglePattern().read('qrInfo').then((value) {
      if (value != null) {
        var qrInfo = json.decode(value);
        inputController.text = qrInfo['qrData'];
        inputOfQrCode = qrInfo['qrData'];
        qrVersion = qrInfo['qrVersion'];
        errorCorrectionLevel = qrInfo['errorCorrectionLevel'];
        gapLess = qrInfo['gapLess'];
        setState(() {});
      }
    });
  }

  Future<void> _generateQrCode(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => QrSettings(
              qrVersion: qrVersion,
              errorCorrectionLevel: errorCorrectionLevel,
              gapLess: gapLess)),
    );

    // When a BuildContext is used from a StatefulWidget, the mounted property
    // must be checked after an asynchronous gap.
    if (!context.mounted) return;

    if (result != null) {
      if (result['qiVersion'] != qrVersion ||
          result['errorCorrectionLevel'] != errorCorrectionLevel ||
          result['gapLess'] != gapLess) {
        if (result['qiVersion'] != qrVersion) {
          qrVersion = result['qrVersion'];
        }
        if (result['errorCorrectionLevel'] != errorCorrectionLevel) {
          errorCorrectionLevel = result['errorCorrectionLevel'];
        }
        if (result['gapLess'] != gapLess) {
          gapLess = result['gapLess'];
        }
        setState(() {});
        StorageSinglePattern().write(
            'qrInfo',
            jsonEncode({
              'qrData': inputOfQrCode,
              'qrVersion': qrVersion,
              'errorCorrectionLevel': errorCorrectionLevel,
              'gapLess': gapLess,
            }));
      }
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('二维码'),
        actions: [
          IconButton(
            onPressed: () => _generateQrCode(context),
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
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
                                inputContentIsEmpty
                                    ? Colors.grey
                                    : Colors.purple),
                          ),
                          onPressed: inputContentIsEmpty ? () {} : clearSearch,
                          icon: Icon(inputContentIsEmpty
                              ? Icons.search
                              : Icons.clear))),
                  onSubmitted: (value) {
                    if (inputContentIsEmpty) return;
                    inputOfQrCode = value;
                    setState(() {});
                    StorageSinglePattern().write(
                        'qrInfo',
                        jsonEncode({
                          'qrData': inputOfQrCode,
                          'qrVersion': qrVersion,
                          'errorCorrectionLevel': errorCorrectionLevel,
                          'gapLess': gapLess,
                        }));
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  inputOfQrCode = inputController.text;
                  setState(() {});

                  StorageSinglePattern().write(
                      'qrInfo',
                      jsonEncode({
                        'qrData': inputOfQrCode,
                        'qrVersion': qrVersion,
                        'errorCorrectionLevel': errorCorrectionLevel,
                        'gapLess': gapLess,
                      }));
                },
                child: const Text('生成二维码'),
              ),
            ],
          ),
        ),
        Expanded(
            child: Center(
          child: inputOfQrCode.isNotEmpty
              ? QrImageView(
                  eyeStyle: const QrEyeStyle(
                    eyeShape: QrEyeShape.square,
                    color: Colors.purple,
                  ),
                  dataModuleStyle: const QrDataModuleStyle(
                          dataModuleShape: QrDataModuleShape.square,
                          color: Colors.purple,
                  ),
                  data: inputOfQrCode,
                  size: 200.0,
                  version: qrVersion,
                  errorCorrectionLevel: errorCorrectionLevel,
                  gapless: gapLess,
                )
              : const SizedBox.shrink(),
        )),
      ]),
    );
  }
}
