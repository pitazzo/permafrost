import 'package:async_redux/async_redux.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:permafrost/core/redux/app_state.dart';
import 'package:permafrost/core/services/firestore.dart';
import 'package:permafrost/locator.dart';

class PermaPersistor extends Persistor {
  @override
  Future<void> deleteState() async {
    FirestoreService firestore = locator<FirestoreService>();
    DocumentReference fridgeReference = await firestore.getFridgeReference();
    DocumentReference userReference = await firestore.getFridgeReference();
    await fridgeReference.delete();
    await userReference.delete();
  }

  @override
  Future<void> persistDifference({lastPersistedState, newState}) async {
    AppState state = (newState as AppState);
    AppState lastState = (lastPersistedState as AppState);
    FirestoreService firestore = locator<FirestoreService>();

    if (lastState != null && (state.fridge != lastState.fridge)) {
      firestore.updateFridge(state.fridge);
    }

    if (lastState != null && (state.user != lastState.user)) {
      firestore.updateUser(state.user);
    }
  }

  @override
  Future<AppState> readState() async {
    FirestoreService firestore = locator<FirestoreService>();
    return AppState.initialState().copy(
      fridge: await firestore.getFridge(),
      user: await firestore.getUser(),
    );
  }
}
