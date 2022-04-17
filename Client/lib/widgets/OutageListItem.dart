import 'package:flutter/material.dart';

import '../models/OutageDto.dart';

/// Representation of the list items that are shown to the user.
class OutageListItem extends StatelessWidget {
  const OutageListItem({
    Key? key,
    required this.outage
  }) : super(key: key);

  final OutageDto outage;

  /// Builds the card widget that will be shown to the user with the outage specific data.
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
           child: Card(
              clipBehavior: Clip.antiAlias,
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.keyboard_arrow_down),
                    title: Text(outage.prefecture, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    subtitle: Text(
                      outage.municipality,
                      style: TextStyle(color: Colors.black.withOpacity(0.6), fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      outage.areaDescription,
                      style: TextStyle(color: Colors.black.withOpacity(0.6)),
                    ),
                  ),
                  ButtonBar(
                    alignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                            primary: const Color(0xFF6200EE),
                            fixedSize: const Size.fromWidth(100),
                            padding: const EdgeInsets.all(10)
                        ),
                        icon: const Icon(
                          Icons.code
                        ),
                        label: const Text('More'),
                        onPressed: (){
                          //Code Here
                        },
                      ),
                      Center(
                        child: Ink(
                          height: 45,
                          decoration: const ShapeDecoration(
                            color: Colors.pink,
                            shape: CircleBorder(side: BorderSide(color: Colors.pink)),
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.share),
                            color: Colors.white,
                            onPressed: () {},
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
