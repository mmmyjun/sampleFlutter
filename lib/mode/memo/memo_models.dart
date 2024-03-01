import 'package:flutter/material.dart';


class MemoListModel {
  String id;
  String title;
  String content;
  String? date;

  MemoListModel({required this.id, required this.title, required this.content, this.date});

  factory MemoListModel.fromMap(Map<String, dynamic> map) {
    return MemoListModel(
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
