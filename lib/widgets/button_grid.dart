import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math';
import '../models/button_config.dart';
import 'button_screen.dart';

class ButtonGrid extends StatelessWidget {
  final List<ButtonConfig> buttons;

  const ButtonGrid({
    super.key,
    required this.buttons,
  });

  @override
  Widget build(BuildContext context) {
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

  int _calculateGridSize(int buttonCount) {
    if (buttonCount <= 4) return 2;
    if (buttonCount <= 9) return 3;
    if (buttonCount <= 16) return 4;
    return (sqrt(buttonCount).ceil());
  }

  Widget _buildButton(BuildContext context, ButtonConfig config) {
    return Material(
      color: config.color,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ButtonScreen(config: config),
            ),
          );
        },
        borderRadius: BorderRadius.circular(10),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
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