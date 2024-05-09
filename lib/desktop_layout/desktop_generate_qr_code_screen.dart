
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_generator_v2/qr_logic.dart';
import 'package:qr_flutter/qr_flutter.dart';

class DesktopLayout extends StatefulWidget {
  const DesktopLayout({super.key});

  @override
  State<DesktopLayout> createState() => _DesktopLayoutState();
}

class _DesktopLayoutState extends State<DesktopLayout> with QrCodeLogic {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body:
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          Container(
            color: Colors.grey[900],
            width: 600,
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: ListView(
                children: <Widget>[
                  const SizedBox(height: 20.0),
                  const Text(
                    "Customize QR Code",
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32.0),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: qrDataController,
                        style: const TextStyle(color: Colors.black),
                        decoration: const InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          hintText: "Enter your data",
                          border: InputBorder.none, // Add this line
                        ),
                        onChanged: (value) {
                          setState(() {
                            qrData = value;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 32.0),
                  Card(
                    color: Colors.grey[200],
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 30,
                            child: LayoutBuilder(
                              builder: (BuildContext context,
                                  BoxConstraints constraints) {
                                return ToggleButtons(
                                  renderBorder: false,
                                  borderRadius: BorderRadius.circular(8.0),
                                  color: Colors.black,
                                  fillColor: Colors.white,
                                  selectedColor: Colors.black,
                                  isSelected: [
                                    colorType == ColorType.qrBackground,
                                    colorType == ColorType.cornerEye,
                                    colorType == ColorType.dots,
                                  ],
                                  onPressed: (int index) {
                                    setState(() {
                                      switch (index) {
                                        case 0:
                                          colorType = ColorType.qrBackground;
                                          break;
                                        case 1:
                                          colorType = ColorType.cornerEye;
                                          break;
                                        case 2:
                                          colorType = ColorType.dots;
                                          break;
                                      }
                                    });
                                  },
                                  children: <Widget>[
                                    SizedBox(
                                      width: constraints.maxWidth / 3,
                                      child: const Center(
                                          child: Text("QR Background")),
                                    ),
                                    SizedBox(
                                      width: constraints.maxWidth / 3,
                                      child: const Center(
                                          child: Text("Corner Eye")),
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
                            color: getColor(),
                            onColorChanged: (Color color) =>
                                setState(() => setColor(color)),
                            pickersEnabled: const <ColorPickerType, bool>{
                              ColorPickerType.wheel:
                                  true, // Enable the wheel picker
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 32.0),
                  Card(
                    color: Colors.grey[200],
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "QR Size: ${qrSize.round()}",
                              ),
                              Slider(
                                activeColor: Colors.grey.shade900,
                                value: qrSize,
                                min: 100.0,
                                max: 500.0,
                                onChanged: (double value) {
                                  setState(() {
                                    qrSize = value;
                                  });
                                },
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "QR Padding: ${qrPadding.top.round()}",
                              ),
                              Slider(
                                activeColor: Colors.grey.shade900,
                                value: qrPadding.top,
                                min: 0.0,
                                max: 50.0,
                                onChanged: (double value) {
                                  setState(() {
                                    qrPadding = EdgeInsets.all(value);
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 32.0),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              const Text(
                                "Corner Shape",
                              ),
                              ToggleButtons(
                                selectedColor: Colors.grey.shade900,
                                isSelected: [
                                  qrEyeShape == QrEyeShape.square,
                                  qrEyeShape == QrEyeShape.circle,
                                ],
                                onPressed: (int index) {
                                  setState(() {
                                    qrEyeShape = index == 0
                                        ? QrEyeShape.square
                                        : QrEyeShape.circle;
                                  });
                                },
                                children: <Widget>[
                                  Icon(Icons.crop_square,
                                      color: Colors.grey.shade900),
                                  Icon(Icons.radio_button_unchecked,
                                      color: Colors.grey.shade900),
                                ],
                              ),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              const Text(
                                "Dots Shape",
                              ),
                              ToggleButtons(
                                selectedColor: Colors.grey.shade900,
                                isSelected: [
                                  qrDotsShape == QrDataModuleShape.square,
                                  qrDotsShape == QrDataModuleShape.circle,
                                ],
                                onPressed: (int index) {
                                  setState(() {
                                    qrDotsShape = index == 0
                                        ? QrDataModuleShape.square
                                        : QrDataModuleShape.circle;
                                  });
                                },
                                children: <Widget>[
                                  Icon(
                                    Icons.crop_square,
                                    color: Colors.grey.shade900,
                                  ),
                                  Icon(
                                    Icons.radio_button_unchecked,
                                    color: Colors.grey.shade900,
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              alignment: Alignment.center,
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  const Spacer(),
                  RepaintBoundary(
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
                  const Spacer(),
                ],
              ),
            ),
          )
        ]),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.grey[900],
          onPressed: () {
            setState(() {
              qrData = qrDataController.text;
              saveQrCode(qrKey, context);
            });
          },
          child: const Icon(Icons.download, color: Colors.white),
        ));
  }
}
