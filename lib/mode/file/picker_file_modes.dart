import 'package:flutter/material.dart';


class PickerFileModel {
  String id;
  String title;
  String content;
  String? date;

  PickerFileModel({required this.id, required this.title, required this.content, this.date});

  factory PickerFileModel.fromMap(Map<String, dynamic> map) {
    return PickerFileModel(
      id: map['id'],
      title: map['title'],
      content: map['content'],
      date: map['date'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'date': date,
    };
  }
}
