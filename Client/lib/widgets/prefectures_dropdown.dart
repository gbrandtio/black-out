import 'package:http/http.dart';
import 'package:async/async.dart';
import '../models/prefecture_dto.dart';
import '../services/prefectures_handler.dart';
import 'package:flutter/material.dart';
import '../services/rest.dart';

typedef PrefectureDtoCallback = PrefectureDto Function(PrefectureDto);

class PrefecturesDropdown extends StatefulWidget {
  /// Callback to return the selected prefecture to the parent component.
  final PrefectureDtoCallback currentPrefectureCallback;
  const PrefecturesDropdown(this.currentPrefectureCallback, {Key? key}) : super(key: key);

  @override
  State<PrefecturesDropdown> createState() => _PrefecturesDropdownState();
}

/// Responsible for requesting, extracting and presenting a dropwdown list of all
/// the prefectures available on the DEDDHE website.
class _PrefecturesDropdownState extends State<PrefecturesDropdown> {
  /// The prefecture to be selected by default.
  PrefectureDto defaultPrefecture = PrefectureDto.defaultPrefecture();
  /// List of all the extracted prefectures.
  List<PrefectureDto> prefectures = List<PrefectureDto>.empty(growable: true);
  /// Future to fetch the prefectures only once and not trigger the FutureBuilder continuously.
  late final Future? prefecturesFuture = _getPrefectures();

  /// Performs a request to the DEDDHE website and extracts the prefectures from the HTML.
  Future<List<PrefectureDto>> _getPrefectures() async {
    // Only fetch the prefectures once. No need to request every time,
    // since the list is not often changing.
    if (prefectures.isEmpty){
      Response response = (await Rest.doGET(
          "https://siteapps.deddie.gr/Outages2Public/?Length=4", {}));
      setState(() {
        prefectures = PrefecturesHandler.extract(response.body);
        defaultPrefecture = prefectures.firstWhere((element) => element.id == "10"); // Default prefecture is Attica.
        widget.currentPrefectureCallback(defaultPrefecture); // Set a default value to callback.
      });
    }
    return prefectures;
  }

  /// Builds the dropdown widget of the prefecture objects.
  Widget prefecturesDropdown(BuildContext context) {
    return DropdownButton<PrefectureDto>(
      value: defaultPrefecture,
      icon: const Icon(Icons.keyboard_arrow_down),
      elevation: 16,
      style: const TextStyle(color: Colors.black),
      underline: Container(
        height: 2,
        color: const Color(0xFFB00020),
      ),
      onChanged: (PrefectureDto? newValue) {
        setState(() {
          defaultPrefecture = newValue!;
          widget.currentPrefectureCallback(newValue); // Callback the new selected prefecture.
        });
      },
      items: prefectures.map<DropdownMenuItem<PrefectureDto>>((PrefectureDto value) {
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
