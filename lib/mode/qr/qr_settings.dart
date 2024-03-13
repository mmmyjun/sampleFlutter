import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrSettings extends StatefulWidget {
  int qrVersion;
  int errorCorrectionLevel;
  bool gapLess;
  QrSettings(
      {Key? key,
      required this.qrVersion,
      required this.errorCorrectionLevel,
      required this.gapLess})
      : super(key: key);

  @override
  State<QrSettings> createState() => _QrSettingsState();
}

class _QrSettingsState extends State<QrSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('二维码设置'),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context, {
                'qrVersion': widget.qrVersion,
                'errorCorrectionLevel': widget.errorCorrectionLevel,
                'gapLess': widget.gapLess,
              });
            },
            icon: const Icon(Icons.arrow_back),
          )),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Card(
                child: ListTile(
                  title: const Text('二维码版本'),
                  trailing: DropdownButton<int>(
                    value: widget.qrVersion,
                    items: [
                      const DropdownMenuItem<int>(child: Text('自动'), value: -1),
                      ...List.generate(40, (index) => index + 1).map((e) =>
                          DropdownMenuItem<int>(
                              child: Text(e.toString()), value: e))
                    ].toList(),
                    onChanged: (int? value) {
                      setState(() {
                        widget.qrVersion = value!;
                      });
                    },
                  ),
                ),
              ),
              Card(
                child: ListTile(
                  title: const Text('纠错等级'),
                  trailing: DropdownButton<int>(
                    value: widget.errorCorrectionLevel,
                    items: [
                      QrErrorCorrectLevel.L,
                      QrErrorCorrectLevel.M,
                      QrErrorCorrectLevel.Q,
                      QrErrorCorrectLevel.H
                    ]
                        .map((e) => DropdownMenuItem<int>(
                            value: e,
                            child: Text(QrErrorCorrectLevel.getName(e))))
                        .toList(),
                    onChanged: (int? value) {
                      setState(() {
                        widget.errorCorrectionLevel = value!;
                      });
                    },
                  ),
                ),
              ),
              Card(
                child: ListTile(
                  title: const Text('无间隙'),
                  trailing: Switch(
                    value: widget.gapLess,
                    onChanged: (bool value) {
                      setState(() {
                        widget.gapLess = value;
                      });
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ]),
    );
  }
}
