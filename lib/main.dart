import 'package:flutter/material.dart';
import 'dart:convert';
import 'config/button_config.dart' as config_loader;
import 'models/button_config.dart';
import 'widgets/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Router App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: FutureBuilder<List<ButtonConfig>>(
        future: _loadButtonConfigs(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return HomeScreen(buttons: snapshot.data!);
          } else if (snapshot.hasError) {
            return Scaffold(
              backgroundColor: Colors.black,
              body: Center(
                child: Text(
                  'Error loading configuration: ${snapshot.error}',
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            );
          }
          return const Scaffold(
            backgroundColor: Colors.black,
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }

  Future<List<ButtonConfig>> _loadButtonConfigs() async {
    try {
      final configJson = await config_loader.loadButtonConfig();
      final List<dynamic> jsonList = json.decode(configJson);
      return jsonList.map((json) => ButtonConfig.fromJson(json)).toList();
    } catch (e) {
      print('Error parsing buttons config: $e');
      return _getDefaultButtons();
    }
  }

  List<ButtonConfig> _getDefaultButtons() {
    return [
      ButtonConfig(
        label: 'A',
        color: Colors.red,
        screenTitle: 'Screen A',
      ),
      ButtonConfig(
        label: 'B',
        color: Colors.blue,
        screenTitle: 'Screen B',
      ),
      ButtonConfig(
        label: 'C',
        color: Colors.green,
        screenTitle: 'Screen C',
      ),
      ButtonConfig(
        label: 'D',
        color: Colors.orange,
        screenTitle: 'Screen D',
      ),
    ];
  }
}