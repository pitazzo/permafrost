import 'package:flutter/material.dart';
import 'package:permafrost/core/models/fridge/compartment.dart';
import 'package:permafrost/core/redux/connectors/compartment_edit_connector.dart';

class EditCompartmentView extends StatelessWidget {
  final bool isEditing;
  final Compartment compartment;

  EditCompartmentView({Key key, @required this.isEditing, this.compartment});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.0),
        child: CompartmentEditorConnector(
          isEditing: isEditing,
          compartment: compartment,
        ),
      ),
    );
  }
}
