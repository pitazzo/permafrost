import 'package:flutter/material.dart';
import 'package:permafrost/core/redux/connectors/compartment_details_connector.dart';
import 'package:permafrost/core/redux/connectors/item_editor_connector.dart';

class CompartmentView extends StatelessWidget {
  final int compartmentId;

  CompartmentView({Key key, @required this.compartmentId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: CompartmentDetailsConnector(compartmentId: compartmentId)),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () => showModalBottomSheet(
                isScrollControlled: true,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15.0),
                      topRight: Radius.circular(15.0)),
                ),
                context: context,
                builder: (_) =>
                    ItemEditorConnector(compartmentId: compartmentId))));
  }
}
