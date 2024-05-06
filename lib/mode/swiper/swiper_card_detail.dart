import 'package:flutter/material.dart';

class SwiperCardDetail extends StatefulWidget {
  int id;
  SwiperCardDetail({Key? key, required this.id}) : super(key: key);

  @override
  State<SwiperCardDetail> createState() => _SwiperCardDetailState();
}

class _SwiperCardDetailState extends State<SwiperCardDetail> {
  int get oId => widget.id ?? -1;

  @override
  void initState() {
    super.initState();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Text('1');
  }
}
