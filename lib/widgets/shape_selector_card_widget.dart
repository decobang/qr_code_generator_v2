import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ShapeSelectorCard extends StatelessWidget {
  final QrEyeShape qrEyeShape;
  final QrDataModuleShape qrDotsShape;
  final Function(int) onEyeShapeChanged;
  final Function(int) onDotsShapeChanged;

  const ShapeSelectorCard({super.key, 
    required this.qrEyeShape,
    required this.qrDotsShape,
    required this.onEyeShapeChanged,
    required this.onDotsShapeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Column(
              children: <Widget>[
                const Text("Corner Shape"),
                ToggleButtons(
                  selectedColor: Colors.grey.shade900,
                  isSelected: [
                    qrEyeShape == QrEyeShape.square,
                    qrEyeShape == QrEyeShape.circle,
                  ],
                  onPressed: onEyeShapeChanged,
                  children: <Widget>[
                    Icon(Icons.crop_square, color: Colors.grey.shade900),
                    Icon(Icons.radio_button_unchecked, color: Colors.grey.shade900),
                  ],
                ),
              ],
            ),
            Column(
              children: <Widget>[
                const Text("Dots Shape"),
                ToggleButtons(
                  selectedColor: Colors.grey.shade900,
                  isSelected: [
                    qrDotsShape == QrDataModuleShape.square,
                    qrDotsShape == QrDataModuleShape.circle,
                  ],
                  onPressed: onDotsShapeChanged,
                  children: <Widget>[
                    Icon(Icons.crop_square, color: Colors.grey.shade900),
                    Icon(Icons.radio_button_unchecked, color: Colors.grey.shade900),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}