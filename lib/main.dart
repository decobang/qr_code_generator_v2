import 'package:flutter/material.dart';
import 'package:qr_code_generator_v2/desktop_layout/desktop_generate_qr_code_screen.dart';
import 'package:qr_code_generator_v2/layout_manager.dart';
import 'package:qr_code_generator_v2/mobile_layout/mobile_generate_qr_code_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "QR Code Generator",
        home: LayoutManager(
  mobile: MobileLayout(),
  desktop: DesktopLayout(),
));
  }
}
