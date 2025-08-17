import 'package:flutter/material.dart';
import 'config/button_config.dart';

void main() {
  runApp(const WearOSApp());
}

class WearOSApp extends StatelessWidget {
  const WearOSApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wear OS Router',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const double screenSize = 320.0;
    final buttons = AppConfig.getButtons();
    
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Container(
          width: screenSize,
          height: screenSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey[900],
          ),
          child: Padding(
            padding: const EdgeInsets.all(60.0),
            child: GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 15,
              crossAxisSpacing: 15,
              children: buttons.map((config) => 
                _buildButton(context, config)
              ).toList(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context, ButtonConfig config) {
    return Material(
      color: config.color,
      borderRadius: BorderRadius.circular(15),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ButtonScreen(config: config),
            ),
          );
        },
        borderRadius: BorderRadius.circular(15),
        child: Center(
          child: Text(
            config.label,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class ButtonScreen extends StatelessWidget {
  final ButtonConfig config;
  
  const ButtonScreen({super.key, required this.config});

  @override
  Widget build(BuildContext context) {
    const double screenSize = 320.0;
    
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Container(
          width: screenSize,
          height: screenSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey[900],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                config.screenTitle,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: config.color,
                ),
              ),
              const SizedBox(height: 40),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back),
                label: const Text('Back'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[800],
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}