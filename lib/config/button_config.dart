import 'dart:convert';
import 'package:flutter/material.dart';
import '../models/button_config.dart';

class AppConfig {
  static const String buttonsJson = String.fromEnvironment(
    'BUTTONS_CONFIG',
    defaultValue: '[{"label":"X","color":"0xFFFF0000","title":"X Screen"},{"label":"Y","color":"0xFF00FF00","title":"Y Screen"},{"label":"Z","color":"0xFF0000FF","title":"Z Screen"},{"label":"F","color":"0xFFFF9800","title":"F Screen"}]',
  );

  static List<ButtonConfig> getButtons() {
    final List<Map<String, String?>> defaultButtons = [
      {'label': 'X', 'color': '0xFFFF0000', 'title': 'X Screen', 'url': null, 'icon': null},
      {'label': 'Y', 'color': '0xFF4CAF50', 'title': 'Y Screen', 'url': null, 'icon': null},
      {'label': 'Z', 'color': '0xFF2196F3', 'title': 'Z Screen', 'url': null, 'icon': null},
      {'label': 'F', 'color': '0xFFFF9800', 'title': 'F Screen', 'url': null, 'icon': null},
    ];
    
    try {
      if (buttonsJson.isNotEmpty && buttonsJson != '[{"label":"X","color":"0xFFFF0000","title":"X Screen"},{"label":"Y","color":"0xFF00FF00","title":"Y Screen"},{"label":"Z","color":"0xFF0000FF","title":"Z Screen"},{"label":"F","color":"0xFFFF9800","title":"F Screen"}]') {
        return _parseButtonsFromEnvironment(buttonsJson);
      }
    } catch (e) {
      print('Error parsing buttons config: $e');
    }
    
    return defaultButtons.map((button) => ButtonConfig(
      label: button['label']!,
      color: Color(int.parse(button['color']!)),
      screenTitle: button['title']!,
      url: button['url'],
      icon: button['icon'],
    )).toList();
  }

  static List<ButtonConfig> _parseButtonsFromEnvironment(String jsonString) {
    try {
      final List<dynamic> jsonList = jsonDecode(jsonString);
      final List<ButtonConfig> buttons = [];
      
      for (final item in jsonList) {
        if (item is Map<String, dynamic>) {
          buttons.add(ButtonConfig(
            label: item['label'] as String,
            color: Color(int.parse(item['color'] as String)),
            screenTitle: item['title'] as String,
            url: item['url'] as String?,
            icon: item['icon'] as String?,
          ));
        }
      }
      
      if (buttons.isEmpty) {
        throw Exception('No valid buttons found in configuration');
      }
      
      return buttons;
    } catch (e) {
      throw Exception('Failed to parse JSON configuration: $e');
    }
  }
}