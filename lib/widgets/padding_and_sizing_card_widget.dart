import 'package:flutter/material.dart';

class QrSizePaddingCard extends StatelessWidget {
  final double qrSize;
  final EdgeInsets qrPadding;
  final Function(double) onSizeChanged;
  final Function(double) onPaddingChanged;

  QrSizePaddingCard({
    required this.qrSize,
    required this.qrPadding,
    required this.onSizeChanged,
    required this.onPaddingChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[200],
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("QR Size: ${qrSize.round()}"),
                Slider(
                  activeColor: Colors.grey.shade900,
                  value: qrSize,
                  min: 100.0,
                  max: 350,
                  onChanged: onSizeChanged,
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("QR Padding: ${qrPadding.top.round()}"),
                Slider(
                  activeColor: Colors.grey.shade900,
                  value: qrPadding.top,
                  min: 0.0,
                  max: 50.0,
                  onChanged: onPaddingChanged,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}