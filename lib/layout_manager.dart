import 'package:flutter/material.dart';

enum ScreenType { mobile, desktop }

class LayoutManager extends StatelessWidget {
  final Widget mobile;
  final Widget desktop;

  const LayoutManager({super.key, required this.mobile, required this.desktop});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          return mobile;
        } else {
          return desktop;
        }
      },
    );
  }
}
