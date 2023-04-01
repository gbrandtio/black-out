import 'package:black_out_groutages/services/outage_retrieval_service.dart';
import 'package:flutter/material.dart';
import '../components/saved_outage_list_item.dart';

/// ----------------------------------------------------------------------------
/// saved_outages_dialog.dart
/// ----------------------------------------------------------------------------
/// Offers a common dialog popup for displaying the saved outages.
class SavedOutagesDialog extends StatefulWidget {
  const SavedOutagesDialog({Key? key}) : super(key: key);

  @override
  State<SavedOutagesDialog> createState() => _SelectSavedOutageDialogState();
}

class _SelectSavedOutageDialogState extends State<SavedOutagesDialog> {
  List<SavedOutageListItem> outageListItems =
      List<SavedOutageListItem>.empty(growable: true);

  @override
  void initState() {
    outageListItems =
        OutageRetrievalService().getOutagesFromPersistentStorage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        backgroundColor: Colors.transparent,
        content: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 10),
              child: widgetOutagesList(),
            ),
            widgetPositionedCloseButton(),
          ],
        ));
  }

  Widget widgetPositionedCloseButton() {
    return Positioned(
        top: -5,
        right: -5,
        child: IconButton(
          onPressed: Navigator.of(context).pop,
          icon: const Icon(Icons.close),
          color: Colors.white,
        ));
  }

  Widget widgetOutagesList() {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        child: ListView(
            scrollDirection: Axis.vertical,
            padding: const EdgeInsets.all(10.0),
            children: <Widget>[...outageListItems]));
  }
}
