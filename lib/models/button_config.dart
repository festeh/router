import 'package:flutter/material.dart';

class ButtonConfig {
  final String label;
  final Color color;
  final String screenTitle;
  final String? url;

  const ButtonConfig({
    required this.label,
    required this.color,
    required this.screenTitle,
    this.url,
  });

  factory ButtonConfig.fromJson(Map<String, dynamic> json) {
    return ButtonConfig(
      label: json['label'] as String,
      color: Color(int.parse(json['color'] as String)),
      screenTitle: json['title'] as String,
      url: json['url'] as String?,
    );
  }
}