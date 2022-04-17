import 'package:flutter/material.dart';

class ChipWidget extends StatelessWidget {
  final String label;
  final Color color;

  const ChipWidget({Key? key, required this.label, required this.color})
      : super(key: key);

  Widget _buildChip(String label, Color color) {
    return Chip(
      labelPadding: const EdgeInsets.all(2.0),
      label: Text(
        label,
        style: TextStyle(
          color: Colors.white.withOpacity(0.8),
        ),
      ),
      backgroundColor: color,
      elevation: 6.0,
      shadowColor: Colors.grey[60],
      padding: const EdgeInsets.all(8.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.all(3.0), child: _buildChip(label, color));
  }
}
