import 'package:flutter/material.dart';

class DataInputCard extends StatelessWidget {
  final TextEditingController qrDataController;
  final Function(String) onChanged;

  const DataInputCard({super.key, required this.qrDataController, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          controller: qrDataController,
          style: const TextStyle(color: Colors.black),
          decoration: const InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintText: "Enter your data",
            border: InputBorder.none,
          ),
          onChanged: onChanged,
        ),
      ),
    );
  }
}