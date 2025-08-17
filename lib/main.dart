import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late PageController _pageController;
  int _currentPage = 0;
  late List<ButtonConfig> _buttons;
  late int _totalPages;

  @override
  void initState() {
    super.initState();
    _buttons = AppConfig.getButtons();
    _totalPages = (_buttons.length / 4).ceil();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _handleKeyEvent(RawKeyEvent event) {
    if (event is RawKeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
        if (_currentPage < _totalPages - 1) {
          _pageController.nextPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        }
      } else if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
        if (_currentPage > 0) {
          _pageController.previousPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        }
      }
    }
  }

  List<ButtonConfig> _getButtonsForPage(int pageIndex) {
    final startIndex = pageIndex * 4;
    final endIndex = (startIndex + 4).clamp(0, _buttons.length);
    return _buttons.sublist(startIndex, endIndex);
  }

  @override
  Widget build(BuildContext context) {
    const double screenSize = 320.0;

    return RawKeyboardListener(
      focusNode: FocusNode()..requestFocus(),
      onKey: _handleKeyEvent,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Container(
            width: screenSize,
            height: screenSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey[900],
            ),
            child: Stack(
              children: [
                PageView.builder(
                  controller: _pageController,
                  itemCount: _totalPages,
                  onPageChanged: (page) {
                    setState(() {
                      _currentPage = page;
                    });
                  },
                  itemBuilder: (context, pageIndex) {
                    final pageButtons = _getButtonsForPage(pageIndex);
                    return _buildButtonGrid(context, pageButtons);
                  },
                ),
                if (_totalPages > 1)
                  Positioned(
                    bottom: 20,
                    left: 0,
                    right: 0,
                    child: _buildPageIndicator(),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildButtonGrid(BuildContext context, List<ButtonConfig> buttons) {
    final List<Widget> buttonWidgets = [];
    
    for (int i = 0; i < 4; i++) {
      if (i < buttons.length) {
        buttonWidgets.add(_buildButton(context, buttons[i]));
      } else {
        buttonWidgets.add(Container());
      }
    }

    return Padding(
      padding: const EdgeInsets.all(60.0),
      child: GridView.count(
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        mainAxisSpacing: 15,
        crossAxisSpacing: 15,
        children: buttonWidgets,
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

  Widget _buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        _totalPages,
        (index) => Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _currentPage == index
                ? Colors.white
                : Colors.white.withOpacity(0.3),
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