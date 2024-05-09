import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_generator_v2/utils/qr_logic.dart';

class ColorTypeSelectorCard extends StatefulWidget {
  final ColorType colorType;
  final Color color;
  final Function(ColorType) onColorTypeChanged;
  final Function(Color) onColorChanged;

  const ColorTypeSelectorCard({
    super.key,
    required this.colorType,
    required this.color,
    required this.onColorTypeChanged,
    required this.onColorChanged,
  });

  @override
  ColorTypeSelectorCardState createState() => ColorTypeSelectorCardState();
}

class ColorTypeSelectorCardState extends State<ColorTypeSelectorCard> {
  late ColorType _colorType;
  late Color _color;

  @override
  void initState() {
    super.initState();
    _colorType = widget.colorType;
    _color = widget.color;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[200],
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              height: 30,
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return ToggleButtons(
                    renderBorder: false,
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.black,
                    fillColor: Colors.white,
                    selectedColor: Colors.black,
                    isSelected: [
                      _colorType == ColorType.qrBackground,
                      _colorType == ColorType.cornerEye,
                      _colorType == ColorType.dots,
                    ],
                    onPressed: (int index) {
                      setState(() {
                        switch (index) {
                          case 0:
                            _colorType = ColorType.qrBackground;
                            break;
                          case 1:
                            _colorType = ColorType.cornerEye;
                            break;
                          case 2:
                            _colorType = ColorType.dots;
                            break;
                        }
                        widget.onColorTypeChanged(_colorType);
                      });
                    },
                    children: <Widget>[
                      SizedBox(
                        width: constraints.maxWidth / 3,
                        child: const Center(child: Text("QR Background")),
                      ),
                      SizedBox(
                        width: constraints.maxWidth / 3,
                        child: const Center(child: Text("Corner Eye")),
                      ),
                      SizedBox(
                        width: constraints.maxWidth / 3,
                        child: const Center(child: Text("Dots")),
                      ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 8),
            ColorPicker(
              padding: const EdgeInsets.all(0),
              color: _color,
              onColorChanged: (Color color) {
                setState(() {
                  _color = color;
                  widget.onColorChanged(_color);
                });
              },
              pickersEnabled: const <ColorPickerType, bool>{
                ColorPickerType.wheel: true,
              },
            ),
          ],
        ),
      ),
    );
  }
}
