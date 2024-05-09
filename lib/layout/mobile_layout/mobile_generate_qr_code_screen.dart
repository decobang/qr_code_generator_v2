import 'package:flutter/material.dart';
import 'package:qr_code_generator_v2/utils/qr_logic.dart';
import 'package:qr_code_generator_v2/widgets/color_type_picker_card_widget.dart';
import 'package:qr_code_generator_v2/widgets/data_input_card_widget.dart';
import 'package:qr_code_generator_v2/widgets/padding_and_sizing_card_widget.dart';
import 'package:qr_code_generator_v2/widgets/shape_selector_card_widget.dart';
import 'package:qr_flutter/qr_flutter.dart';

class MobileLayout extends StatefulWidget {
  const MobileLayout({super.key});

  @override
  State<MobileLayout> createState() => _MobileLayoutState();
}

class _MobileLayoutState extends State<MobileLayout> with QrCodeLogic {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: RepaintBoundary(
                  key: qrKey,
                  child: QrImageView(
                    data: qrData,
                    version: QrVersions.auto,
                    size: qrSize,
                    padding: qrPadding,
                    backgroundColor: qrBackgroundColor,
                    eyeStyle: QrEyeStyle(
                      eyeShape: qrEyeShape, // Use the qrEyeShape variable
                      color: qrCornerEyesColor,
                    ),
                    dataModuleStyle: QrDataModuleStyle(
                      dataModuleShape:
                          qrDotsShape, // Use the qrDotsShape variable
                      color: qrDotsColor,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.grey[900],
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: ListView(
                    children: <Widget>[
                      DataInputCard(
                        qrDataController: qrDataController,
                        onChanged: (String value) {
                          setState(() {
                            qrData = value;
                          });
                        },
                      ),
                      const SizedBox(height: 8),
                      ColorTypeSelectorCard(
                        colorType: colorType,
                        color: getColor(),
                        onColorTypeChanged: (ColorType value) {
                          setState(() {
                            colorType = value;
                          });
                        },
                        onColorChanged: (Color value) {
                          setState(() {
                            setColor(value);
                          });
                        },
                      ),
                      const SizedBox(height: 8),
                      QrSizePaddingCard(
                        qrSize: qrSize,
                        qrPadding: qrPadding,
                        onSizeChanged: (double value) {
                          setState(() {
                            qrSize = value;
                          });
                        },
                        onPaddingChanged: (double value) {
                          setState(() {
                            qrPadding = EdgeInsets.all(value);
                          });
                        },
                      ),
                      const SizedBox(height: 8),
                      ShapeSelectorCard(
                        qrEyeShape: qrEyeShape,
                        qrDotsShape: qrDotsShape,
                        onEyeShapeChanged: (int index) {
                          setState(() {
                            qrEyeShape = index == 0
                                ? QrEyeShape.square
                                : QrEyeShape.circle;
                          });
                        },
                        onDotsShapeChanged: (int index) {
                          setState(() {
                            qrDotsShape = index == 0
                                ? QrDataModuleShape.square
                                : QrDataModuleShape.circle;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          onPressed: () {
            setState(() {
              saveQrCode(qrKey, context);
            });
          },
          child: Icon(Icons.download, color: Colors.grey[900]),
        ));
  }
}
