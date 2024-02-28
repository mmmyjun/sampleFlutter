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