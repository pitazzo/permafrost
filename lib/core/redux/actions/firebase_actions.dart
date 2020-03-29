import 'dart:async';

import 'package:async_redux/async_redux.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:permafrost/core/models/fridge/compartment.dart';
import 'package:permafrost/core/models/fridge/item.dart';

import 'package:permafrost/core/models/user.dart';
import 'package:permafrost/core/redux/app_state.dart';
import 'package:permafrost/core/services/firestore.dart';
import 'package:permafrost/locator.dart';

class InitialSetup extends ReduxAction<AppState> {
  @override
  Future<AppState> reduce() async {
    FirestoreService firestoreService = locator<FirestoreService>();
    DocumentReference userReference = await firestoreService.getUserReference();
    DocumentSnapshot snap = await userReference.get();
    if (snap.exists) {
      User user = User.fromJson(snap.data);

      return state.copy(user: user);
    } else {
      await dispatchFuture(CreateUserAction());
      return null;
    }
  }
}

class CreateUserAction extends ReduxAction<AppState> {
  @override
  FutureOr<AppState> reduce() {
    return state.copy(
        user: User(name: 'Juan Nadie', currentFridge: '', accesibleFidges: []));
  }
}

class LoadFridgeAction extends ReduxAction<AppState> {
  @override
  FutureOr<AppState> reduce() {}
}

class StartListenFirestoreAction extends ReduxAction<AppState> {
  @override
  Future<AppState> reduce() async {
    FirestoreService firestoreService = locator<FirestoreService>();
    firestoreService.registerListener((event) {
      if (event.data != null) {
        AppState newState = state.copy(
            fridge: state.fridge.copy(
                compartments: event.data['compartments']
                    .map<Compartment>(
                        (element) => Compartment.fromJson(element))
                    .toList(),
                items: event.data['items']
                    .map<Item>((element) => Item.fromJson(element))
                    .toList()));
        if (newState.fridge.items != state.fridge.items ||
            newState.fridge.compartments != state.fridge.compartments) {
          dispatch(SetStateAction(newState: newState));
        }
      }
    });
    return null;
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
