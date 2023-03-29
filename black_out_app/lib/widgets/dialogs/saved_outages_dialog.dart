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
        insetPadding: EdgeInsets.zero,
        content: Container(child: widgetOutagesList()));
  }

  Widget widgetOutagesList() {
    return Container(
        width: MediaQuery.of(context).size.width,
        child: ListView(
            scrollDirection: Axis.vertical,
            padding: const EdgeInsets.all(10.0),
            children: <Widget>[...outageListItems]));
  }
}
