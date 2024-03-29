import 'package:flutter/material.dart';

/// ----------------------------------------------------------------------------
/// chip_widget.dart
/// ----------------------------------------------------------------------------
/// Builds a chip widget to display labelled information.
class ChipWidget extends StatelessWidget {
  final String label;
  final Color color;

  const ChipWidget({Key? key, required this.label, required this.color})
      : super(key: key);

  Widget _buildChip(String label, Color color) {
    return Chip(
      label: Text(label),
      labelStyle: TextStyle(
        color: Colors.white.withOpacity(0.8),
        fontSize: 12,
      ),
      backgroundColor: color,
      elevation: 6.0,
      shadowColor: Colors.grey[60],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(3.0), child: _buildChip(label, color));
  }
}
