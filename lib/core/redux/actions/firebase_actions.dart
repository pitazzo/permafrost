import 'dart:async';

import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_udid/flutter_udid.dart';
import 'package:permafrost/core/models/fridge/compartment.dart';
import 'package:permafrost/core/models/fridge/fridge.dart';
import 'package:permafrost/core/models/fridge/item.dart';
import 'package:permafrost/core/models/user.dart';
import 'package:permafrost/core/redux/app_state.dart';
import 'package:permafrost/core/services/firestore.dart';
import 'package:permafrost/locator.dart';
import 'package:uuid_enhanced/uuid.dart';

class InitialSetup extends ReduxAction<AppState> {
  @override
  Future<AppState> reduce() async {
    FirestoreService firestoreService = locator<FirestoreService>();
    User user = await firestoreService.getUser();
    if (user != null) {
      Fridge fridge = await firestoreService.getFridge(fridgeUUID: user.currentFridge);
      dispatch(NavigateAction.pushNamedAndRemoveAll('/'));
      startListeningFridge(store);
      return state.copy(user: user, fridge: fridge);
    } else {
      dispatch(NavigateAction.pushNamedAndRemoveAll('createUser'));
      return null;
    }
  }
}

class CreateUserAction extends ReduxAction<AppState> {
  final String username;

  CreateUserAction({@required this.username});

  @override
  Future<AppState> reduce() async {
    FirestoreService firestoreService = locator<FirestoreService>();

    String fridgeUUID = Uuid.fromTime().toString();
    String userUUID = await FlutterUdid.consistentUdid;

    User user = User(
      name: this.username,
      currentFridge: fridgeUUID,
      accesibleFridges: [fridgeUUID],
    );
    Fridge fridge = Fridge(
      owner: userUUID,
      compartments: [],
      items: [],
    );

    await firestoreService.updateUser(user);
    await firestoreService.updateFridge(fridge, fridgeUUID: fridgeUUID);
    startListeningFridge(store);
    dispatch(NavigateAction.pushNamedAndRemoveAll('/'));
    return state.copy(user: user, fridge: fridge);
  }
}

class SetStateAction extends ReduxAction<AppState> {
  AppState newState;

  SetStateAction({@required this.newState});

  @override
  AppState reduce() {
    return this.newState;
  }
}

void startListeningFridge(Store store) {
  FirestoreService firestoreService = locator<FirestoreService>();
  firestoreService.registerListener((event) {
    if (event.data != null) {
      AppState newState = store.state.copy(
          fridge: store.state.fridge.copy(
              compartments: event.data['compartments']
                  .map<Compartment>((element) => Compartment.fromJson(element))
                  .toList(),
              items: event.data['items']
                  .map<Item>((element) => Item.fromJson(element))
                  .toList()));
      if (newState.fridge.items != store.state.fridge.items ||
          newState.fridge.compartments != store.state.fridge.compartments) {
        store.dispatch(SetStateAction(newState: newState));
      }
    }
  });
}
