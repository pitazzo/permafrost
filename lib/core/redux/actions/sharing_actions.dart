import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:permafrost/core/models/fridge/fridge.dart';
import 'package:permafrost/core/models/user.dart';
import 'package:permafrost/core/redux/actions/firebase_actions.dart';
import 'package:permafrost/core/redux/app_state.dart';
import 'package:permafrost/core/services/firestore.dart';
import 'package:permafrost/locator.dart';

class SelectFridgeAction extends ReduxAction<AppState> {
  final String newFridge;

  SelectFridgeAction({@required this.newFridge});

  @override
  Future<AppState> reduce() async {
    FirestoreService firestoreService = locator<FirestoreService>();
    await firestoreService.unregisterListener();
    await firestoreService.refreshFridgeReference(newFridge);
    Fridge fridge = await firestoreService.getFridge();
    startListeningFridge(store);
    return state.copy(
        user: state.user.copy(currentFridge: newFridge), fridge: fridge);
  }
}

class AddNewFridgeAction extends ReduxAction<AppState> {
  final String newFridge;

  AddNewFridgeAction({@required this.newFridge});

  @override
  Future<AppState> reduce() async {
    //TODO: validar si el QR es válido
    if (state.user.accesibleFridges.contains(newFridge)) {
      return null;
    }
    User user = state.user
        .copy(accesibleFridges: state.user.accesibleFridges..add(newFridge));
    return state.copy(user: user);
  }
}
