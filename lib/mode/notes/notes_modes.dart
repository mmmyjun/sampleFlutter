import 'package:flutter/material.dart';


class NotesListModel {
  String id;
  String title;
  String content;
  String? date;

  NotesListModel({required this.id, required this.title, required this.content, this.date});

  factory NotesListModel.fromMap(Map<String, dynamic> map) {
    return NotesListModel(
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
