import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:permafrost/core/models/compartment.dart';
import 'package:permafrost/core/redux/actions/compartment_actions.dart';
import 'package:permafrost/core/redux/app_state.dart';
import 'package:permafrost/ui/widgets/compartments/compartment_editor.dart';

class CompartmentEditorConnector extends StatelessWidget {
  final bool isEditing;
  final Compartment compartment;
  
  CompartmentEditorConnector({Key key, @required this.isEditing, this.compartment});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
        model: ViewModel(),
        builder: (BuildContext context, ViewModel model) {
      return CompartmentEditor(isEditing: isEditing, compartment: compartment, onSaved: model.onSaved);
    });
  }
}

class ViewModel extends BaseModel<AppState> {
  ViewModel();

  Function(int, String, String, String) onSaved;

  ViewModel.build({@required this.onSaved}) : super();

  @override
  ViewModel fromStore() => ViewModel.build(
      onSaved: (id, name, color, icon) => dispatch(
          SaveCompartmentAction(
              id: id,
              name: name,
              color: color,
              icon: icon)));
}
