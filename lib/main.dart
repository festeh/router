import 'package:flutter/material.dart';

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
              children: [
                _buildButton(context, 'X', Colors.red, const XScreen()),
                _buildButton(context, 'Y', Colors.green, const YScreen()),
                _buildButton(context, 'Z', Colors.blue, const ZScreen()),
                _buildButton(context, 'F', Colors.orange, const FScreen()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context, String label, Color color, Widget screen) {
    return Material(
      color: color,
      borderRadius: BorderRadius.circular(15),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => screen),
          );
        },
        borderRadius: BorderRadius.circular(15),
        child: Center(
          child: Text(
            label,
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

class XScreen extends StatelessWidget {
  const XScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildScreen(context, 'X Screen', Colors.red);
  }
}

class YScreen extends StatelessWidget {
  const YScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildScreen(context, 'Y Screen', Colors.green);
  }
}

class ZScreen extends StatelessWidget {
  const ZScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildScreen(context, 'Z Screen', Colors.blue);
  }
}

class FScreen extends StatelessWidget {
  const FScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildScreen(context, 'F Screen', Colors.orange);
  }
}

Widget _buildScreen(BuildContext context, String title, Color color) {
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
              title,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: color,
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