import 'dart:async';

import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:permafrost/core/models/compartment.dart';
import 'package:permafrost/core/models/item.dart';
import 'package:permafrost/core/redux/app_state.dart';
import 'package:permafrost/core/services/firestore.dart';
import 'package:permafrost/locator.dart';

class SetStateAction extends ReduxAction<AppState> {
  AppState newState;

  SetStateAction({@required this.newState});

  @override
  AppState reduce() {
    return this.newState;
  }
}

class StartListenFirestoreAction extends ReduxAction<AppState> {
  @override
  Future<AppState> reduce() async {
    FirestoreService firestoreService = locator<FirestoreService>();
    firestoreService.registerListener((event) {
      if (event.data != null) {
        AppState newState = state.copy(
            compartments: event.data['compartments']
                .map<Compartment>((element) => Compartment.fromJson(element))
                .toList(),
            items: event.data['items']
                .map<Item>((element) => Item.fromJson(element))
                .toList());
        if (newState.items != state.items || newState.compartments != state.compartments) {
          dispatch(SetStateAction(newState: newState));
        }
      }
    });
    return null;
  }
}
