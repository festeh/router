import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/button_config.dart';
import 'button_grid.dart';

class HomeScreen extends StatefulWidget {
  final List<ButtonConfig> buttons;

  const HomeScreen({
    super.key,
    required this.buttons,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PageController _pageController;
  int _currentPage = 0;
  late int _totalPages;

  @override
  void initState() {
    super.initState();
    _totalPages = (widget.buttons.length / 4).ceil();
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
    final endIndex = (startIndex + 4).clamp(0, widget.buttons.length);
    return widget.buttons.sublist(startIndex, endIndex);
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
                    return Padding(
                      padding: const EdgeInsets.all(60.0),
                      child: ButtonGrid(
                        buttons: pageButtons,
                        forceGrid2x2: true,
                      ),
                    );
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