import 'package:black_out_groutages/models/prefecture_dto.dart';
import 'package:black_out_groutages/widgets/components/prefectures_dropdown.dart';
import 'package:flutter/material.dart';

/// ----------------------------------------------------------------------------
/// select_prefecture.dart
/// ----------------------------------------------------------------------------
/// Offers a common dialog popup that can be used for prefecture selection.
class SelectPrefectureDialog extends StatefulWidget {
  final ValueChanged<PrefectureDto> onDefaultPrefectureChanged;

  const SelectPrefectureDialog(
      {Key? key, required this.onDefaultPrefectureChanged})
      : super(key: key);

  @override
  State<SelectPrefectureDialog> createState() => _SelectPrefectureDialogState();
}

class _SelectPrefectureDialogState extends State<SelectPrefectureDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: const Text(
          "Update the default prefecture",
        ),
        content: PrefecturesDropdown((value) {
          widget.onDefaultPrefectureChanged(value);
          return PrefectureDto.defaultPrefecture();
        }));
  }
}
