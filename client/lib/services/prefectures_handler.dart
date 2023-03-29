import 'package:black_out_groutages/models/prefecture_dto.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' show parse;

/// ----------------------------------------------------------------------------
/// prefectures_handler.dart
/// ----------------------------------------------------------------------------
/// Includes all the related functions to:
/// * Parse HTML and extract prefectures listed with planned outages.
/// * Transform unstructured data into prefecture objects.
/// * Transform PrefectureDto objects into equivalent widgets.
class PrefecturesHandler {
  /// Parses the passed [html] response to find all the available Prefectures
  /// that outages have been reported for.
  ///
  /// 1. Parses the [html] to find the <select> tag with id PrefectureID.
  /// 2. Loops through it's options and extracts the prefectures.
  ///
  /// @returns a [List] of all the extracted prefectures.
  /// @returns an empty [List] if no prefectures could be extracted.
  static List<PrefectureDto> extract(String html) {
    List<PrefectureDto> prefectures = List<PrefectureDto>.empty(growable: true);

    //#region HTML Parser
    try {
      dom.Document document = parse(html);
      // Find the prefecture options.
      dom.Element? slctPrefectureOptions =
          document.getElementById("PrefectureID");
      // Find all the prefecture options and form concrete objects.
      List<dom.Element> options =
          slctPrefectureOptions!.getElementsByTagName("option");
      for (int i = 1; i < options.length; i++) {
        String id = options[i].attributes["value"].toString();
        String name = options[i].innerHtml.toString();
        prefectures.add(PrefectureDto(id, name));
      }
    } catch (e) {
      prefectures = [];
    }
    //#endregion

    return prefectures;
  }
}
