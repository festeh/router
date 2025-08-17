import 'package:flutter/material.dart';

class CustomPageRoute extends PageRouteBuilder {
  final Widget child;
  
  CustomPageRoute({required this.child})
      : super(
          transitionDuration: const Duration(milliseconds: 400),
          reverseTransitionDuration: const Duration(milliseconds: 300),
          pageBuilder: (context, animation, secondaryAnimation) => child,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // Combined fade and scale animation for smooth transition
            const begin = 0.0;
            const end = 1.0;
            const curve = Curves.easeInOutCubic;

            var fadeTween = Tween(begin: begin, end: end).chain(
              CurveTween(curve: curve),
            );
            
            var scaleTween = Tween(begin: 0.95, end: 1.0).chain(
              CurveTween(curve: curve),
            );

            var fadeAnimation = animation.drive(fadeTween);
            var scaleAnimation = animation.drive(scaleTween);

            return FadeTransition(
              opacity: fadeAnimation,
              child: ScaleTransition(
                scale: scaleAnimation,
                child: child,
              ),
            );
          },
        );
}

class CircularRevealRoute extends PageRouteBuilder {
  final Widget child;
  
  CircularRevealRoute({required this.child})
      : super(
          transitionDuration: const Duration(milliseconds: 500),
          reverseTransitionDuration: const Duration(milliseconds: 400),
          pageBuilder: (context, animation, secondaryAnimation) => child,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = 0.0;
            const end = 1.0;
            
            // Use a custom curve for more natural movement
            final curve = CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutCubic,
              reverseCurve: Curves.easeInCubic,
            );

            return FadeTransition(
              opacity: Tween(begin: begin, end: end).animate(curve),
              child: ScaleTransition(
                scale: Tween(begin: 0.8, end: 1.0).animate(curve),
                child: child,
              ),
            );
          },
        );
}