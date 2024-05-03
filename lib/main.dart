import 'package:flutter/material.dart';
import 'package:qr_code_generator_v2/generate_qr_code_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        title: "QR Code Generator", home: GenerateQRCodeScreen());
  }
}
