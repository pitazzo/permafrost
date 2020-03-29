import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:permafrost/core/models/fridge/item.dart';

import 'package:permafrost/core/redux/actions/item_actions.dart';
import 'package:permafrost/core/redux/app_state.dart';
import 'package:permafrost/ui/widgets/items/item_details.dart';

class ItemDetailsConnector extends StatelessWidget {
  final Item item;

  ItemDetailsConnector({Key key, @required this.item});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Function(int, double)>(
        converter: (store) => (id, newAmount) =>
            store.dispatch(EditItemAmountAction(id: id, amount: newAmount)),
        builder: (BuildContext context, Function onAmountEdit) {
          return ItemDetails(item: item, onAmountEdit: onAmountEdit);
        });
  }
}
