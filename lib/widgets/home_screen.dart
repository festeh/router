import 'package:flutter/material.dart';
import '../models/button_config.dart';
import 'button_grid.dart';

class HomeScreen extends StatelessWidget {
  final List<ButtonConfig> buttons;

  const HomeScreen({
    super.key,
    required this.buttons,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Router App'),
        backgroundColor: Colors.grey[900],
      ),
      body: Center(
        child: ButtonGrid(buttons: buttons),
      ),
    );
  }
}