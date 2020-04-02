import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:permafrost/core/models/fridge/item.dart';
import 'package:permafrost/core/redux/actions/item_actions.dart';
import 'package:permafrost/core/redux/app_state.dart';
import 'package:permafrost/ui/widgets/items/item_editor.dart';

class ItemEditorConnector extends StatelessWidget {
  final int compartmentId;
  final Item originalItem;

  ItemEditorConnector({Key key, this.compartmentId, this.originalItem});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
        model: ViewModel(this.compartmentId),
        builder: (BuildContext context, ViewModel model) {
          return ItemEditor(
              onAdded: model.onAdded,
              onEdited: model.onEdited,
              originalItem: originalItem);
        });
  }
}

class ViewModel extends BaseModel<AppState> {
  ViewModel(this.compartmentId);
  final int compartmentId;
  Function(String, double, String, DateTime, DateTime) onAdded;
  Function(int, int, String, double, String, DateTime, DateTime) onEdited;

  ViewModel.build({
    this.compartmentId,
    @required this.onAdded,
    @required this.onEdited,
  }) : super();

  @override
  BaseModel fromStore() => ViewModel.build(
        onAdded: (name, amount, units, entryDate, expiryDate) => dispatch(
          AddItemAction(
              compartmentId: this.compartmentId,
              name: name,
              amount: amount,
              units: units,
              entryDate: entryDate,
              expiryDate: expiryDate),
        ),
        onEdited:
            (id, compartmentId, name, amount, units, entryDate, expiryDate) =>
                dispatch(
          EditItemAction(
              itemId: id,
              compartmentId: compartmentId,
              name: name,
              amount: amount,
              units: units,
              entryDate: entryDate,
              expiryDate: expiryDate),
        ),
      );
}
