import 'package:flutter/material.dart';

/// home页面首页的widget
class WidgetModel {
  String name;
  Widget icon;
  Widget child;
  WidgetModel(this.name, this.icon, this.child);

  factory WidgetModel.fromJson(Map<String, dynamic> json) {
    return WidgetModel(
      json['name'],
      json['icon'],
      json['child'],
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'icon': icon,
    'child': child,
  };
}

/// label value model
class LabelValueModel {
  String label;
  String value;

  LabelValueModel({required this.label, required this.value});

  factory LabelValueModel.fromMap(Map<String, dynamic> map) {
    return LabelValueModel(
      label: map['label'],
      value: map['value']
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'label': label,
      'value': value
    };
  }
}