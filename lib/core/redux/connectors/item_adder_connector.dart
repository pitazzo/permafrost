import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:permafrost/core/redux/actions/item_actions.dart';
import 'package:permafrost/core/redux/app_state.dart';
import 'package:permafrost/ui/widgets/items/item_adder.dart';

class ItemAdderConnector extends StatelessWidget {
  final int compartmentId;

  ItemAdderConnector({Key key, @required this.compartmentId});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState,
            Function(String, double, String, DateTime, DateTime)>(
        converter: (store) => (name, amount, units, entryDate, expiryDate) =>
            store.dispatch(AddItemAction(
                compartmentId: this.compartmentId,
                name: name,
                amount: amount,
                units: units,
                entryDate: entryDate,
                expiryDate: expiryDate)),
        builder: (BuildContext context, Function onItemAdded) {
          return ItemAdder(onAdded: onItemAdded);
        });
  }
}
