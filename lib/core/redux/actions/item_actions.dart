import 'package:async_redux/async_redux.dart';
import 'package:meta/meta.dart';
import 'package:permafrost/core/models/fridge/item.dart';

import 'package:permafrost/core/redux/app_state.dart';

class AddItemsAction extends ReduxAction<AppState> {
  final List<Item> items;
  AddItemsAction({@required this.items});

  @override
  AppState reduce() {
    return state.copy(
        fridge: state.fridge.copy(items: List.unmodifiable(this.items)));
  }
}

class AddItemAction extends ReduxAction<AppState> {
  final int compartmentId;
  final String name;
  final double amount;
  final String units;
  final DateTime entryDate;
  final DateTime expiryDate;

  AddItemAction(
      {@required this.compartmentId,
      @required this.name,
      @required this.amount,
      @required this.units,
      @required this.entryDate,
      @required this.expiryDate});

  @override
  AppState reduce() {
    int nextId = state.fridge.items
            .fold(0, (max, item) => item.id > max ? item.id : max) +
        1;
    Item newItem = Item(
        id: nextId,
        name: name,
        amount: amount,
        units: units,
        entryDate: entryDate,
        expiryDate: expiryDate,
        compartmentId: compartmentId);
    return state.copy(
        fridge: state.fridge
            .copy(items: state.fridge.items.toList()..add(newItem)));
  }
}

class EditItemAction extends ReduxAction<AppState> {
  final int itemId;
  final int compartmentId;
  final String name;
  final double amount;
  final String units;
  final DateTime entryDate;
  final DateTime expiryDate;

  EditItemAction({
    @required this.itemId,
    @required this.compartmentId,
    @required this.name,
    @required this.amount,
    @required this.units,
    @required this.entryDate,
    @required this.expiryDate,
  });

  @override
  AppState reduce() {
    Item newItem = Item(
        id: itemId,
        name: name,
        amount: amount,
        units: units,
        entryDate: entryDate,
        expiryDate: expiryDate,
        compartmentId: compartmentId);
    return state.copy(
        fridge: state.fridge.copy(
            items: state.fridge.items.toList()
              ..removeWhere((item) => item.id == itemId)
              ..add(newItem)));
  }
}

class EditItemAmountAction extends ReduxAction<AppState> {
  final int id;
  final double amount;

  EditItemAmountAction({@required this.id, @required this.amount});

  @override
  AppState reduce() {
    if (this.amount == 0) {
      return state.copy(
          fridge: state.fridge.copy(
              items: List.unmodifiable(state.fridge.items.toList()
                ..removeWhere((item) => this.id == item.id))));
    } else {
      return state.copy(
          fridge: state.fridge.copy(
              items: List.unmodifiable(state.fridge.items.toList().map((item) {
        if (item.id == this.id) {
          return item.copy(amount: this.amount);
        } else {
          return item;
        }
      }).toList())));
    }
  }
}

class BulkItemsRemoveAction extends ReduxAction<AppState> {
  final List<int> ids;
  BulkItemsRemoveAction({@required this.ids});

  @override
  AppState reduce() {
    return state.copy(
        fridge: state.fridge.copy(
            items: List.unmodifiable(state.fridge.items.toList()
              ..removeWhere((item) => this.ids.contains(item.id)))));
  }
}
