import 'package:black_out_groutages/controllers/prefectures/prefectures_context.dart';
import '../../models/prefecture_dto.dart';
import 'package:flutter/material.dart';

typedef PrefectureDtoCallback = PrefectureDto Function(PrefectureDto);

/// ----------------------------------------------------------------------------
///prefectures_dropdown.dart
/// ----------------------------------------------------------------------------
/// Implements a reusable dropdown that contains a list of prefectures fetched
/// from the official DEDDHE source.
class PrefecturesDropdown extends StatefulWidget {
  /// Callback to return the selected prefecture to the parent component.
  final PrefectureDtoCallback onPrefectureSelected;

  const PrefecturesDropdown(this.onPrefectureSelected, {Key? key})
      : super(key: key);

  @override
  State<PrefecturesDropdown> createState() => _PrefecturesDropdownState();
}

/// Responsible for requesting, extracting and presenting a dropdown list of all
/// the prefectures available on the DEDDHE website.
class _PrefecturesDropdownState extends State<PrefecturesDropdown> {
  /// The prefecture to be selected by default.
  late PrefectureDto activePrefecture;

  /// List of all the extracted prefectures.
  List<PrefectureDto> prefectures = List<PrefectureDto>.empty(growable: true);

  /// Future to fetch the prefectures only once and not trigger the FutureBuilder continuously.
  late final Future? prefecturesFuture;

  @override
  void initState() {
    debugPrint("building prefectures...");

    super.initState();
    activePrefecture = PrefectureDto.defaultPrefecture();
    prefecturesFuture = _getPrefectures();
  }

  Future<List<PrefectureDto>> _getPrefectures() async {
    debugPrint("active prefecture ${activePrefecture.name}");

    PrefecturesContext prefecturesContext = PrefecturesContext();
    prefectures = await prefecturesContext.execute();

    debugPrint("Retrieved prefectures: ${prefectures.length}");

    activePrefecture = PrefectureDto.defaultPrefecture();
    widget.onPrefectureSelected(activePrefecture);

    return prefectures;
  }

  /// Builds the dropdown widget of the prefecture objects.
  Widget prefecturesDropdown(BuildContext context) {
    return DropdownButton<PrefectureDto>(
      value: activePrefecture,
      icon: const Icon(Icons.keyboard_arrow_down),
      elevation: 16,
      style: const TextStyle(color: Colors.black),
      underline: Container(
        height: 2,
        color: const Color(0xFFB00020),
      ),
      onChanged: (PrefectureDto? newValue) {
        setState(() {
          debugPrint("selected prefecture ${newValue?.name}");
          activePrefecture = newValue!;
          widget.onPrefectureSelected(
              newValue); // Notify about the new selected prefecture.
        });
      },
      items: prefectures
          .map<DropdownMenuItem<PrefectureDto>>((PrefectureDto value) {
        return DropdownMenuItem<PrefectureDto>(
          value: value,
          child: Text(value.name),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: prefecturesFuture,
        builder: (context, snapshot) {
          return prefecturesDropdown(context);
        });
  }
}
