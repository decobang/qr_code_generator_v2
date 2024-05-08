import 'dart:typed_data';

import 'package:flutter/material.dart';

class FullScreenQrCode extends StatelessWidget {
  final Uint8List qrCode;

  FullScreenQrCode({required this.qrCode});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Take ScreenShot of QR Code'),
      ),
      body: Center(
        child: Image.memory(qrCode),
      ),
    );
  }
}
