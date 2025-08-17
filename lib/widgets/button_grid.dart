import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math';
import '../models/button_config.dart';
import 'button_screen.dart';

class ButtonGrid extends StatelessWidget {
  final List<ButtonConfig> buttons;
  final bool forceGrid2x2;

  const ButtonGrid({
    super.key,
    required this.buttons,
    this.forceGrid2x2 = false,
  });

  @override
  Widget build(BuildContext context) {
    if (forceGrid2x2) {
      return _build2x2Grid(context);
    }
    
    final int gridSize = _calculateGridSize(buttons.length);
    
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: gridSize,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: buttons.length,
      itemBuilder: (context, index) {
        return _buildButton(context, buttons[index]);
      },
    );
  }

  Widget _build2x2Grid(BuildContext context) {
    final List<Widget> buttonWidgets = [];
    
    for (int i = 0; i < 4; i++) {
      if (i < buttons.length) {
        buttonWidgets.add(_buildButton(context, buttons[i]));
      } else {
        buttonWidgets.add(Container());
      }
    }

    return GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 15,
      crossAxisSpacing: 15,
      children: buttonWidgets,
    );
  }

  int _calculateGridSize(int buttonCount) {
    if (buttonCount <= 4) return 2;
    if (buttonCount <= 9) return 3;
    if (buttonCount <= 16) return 4;
    return (sqrt(buttonCount).ceil());
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
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: Colors.white24,
              width: 2,
            ),
          ),
          child: Center(
            child: config.icon != null
                ? SvgPicture.asset(
                    config.icon!,
                    width: 48,
                    height: 48,
                    colorFilter: const ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcIn,
                    ),
                  )
                : Text(
                    config.label,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}