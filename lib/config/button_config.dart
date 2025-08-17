import 'package:flutter/material.dart';

class ButtonConfig {
  final String label;
  final Color color;
  final String screenTitle;

  const ButtonConfig({
    required this.label,
    required this.color,
    required this.screenTitle,
  });
}

class AppConfig {
  static const String buttonsJson = String.fromEnvironment(
    'BUTTONS_CONFIG',
    defaultValue: '[{"label":"X","color":"0xFFFF0000","title":"X Screen"},{"label":"Y","color":"0xFF00FF00","title":"Y Screen"},{"label":"Z","color":"0xFF0000FF","title":"Z Screen"},{"label":"F","color":"0xFFFF9800","title":"F Screen"}]',
  );

  static List<ButtonConfig> getButtons() {
    final List<Map<String, String>> defaultButtons = [
      {'label': 'X', 'color': '0xFFFF0000', 'title': 'X Screen'},
      {'label': 'Y', 'color': '0xFF4CAF50', 'title': 'Y Screen'},
      {'label': 'Z', 'color': '0xFF2196F3', 'title': 'Z Screen'},
      {'label': 'F', 'color': '0xFFFF9800', 'title': 'F Screen'},
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
    )).toList();
  }

  static List<ButtonConfig> _parseButtonsFromEnvironment(String json) {
    final List<ButtonConfig> buttons = [];
    
    final regex = RegExp(r'\{"label":"([^"]+)","color":"([^"]+)","title":"([^"]+)"\}');
    final matches = regex.allMatches(json);
    
    for (final match in matches) {
      buttons.add(ButtonConfig(
        label: match.group(1)!,
        color: Color(int.parse(match.group(2)!)),
        screenTitle: match.group(3)!,
      ));
    }
    
    if (buttons.isEmpty) {
      throw Exception('No valid buttons found in configuration');
    }
    
    return buttons;
  }
}