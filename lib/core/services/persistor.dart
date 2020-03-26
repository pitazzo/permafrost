import 'package:async_redux/async_redux.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:permafrost/core/models/compartment.dart';
import 'package:permafrost/core/models/item.dart';
import 'package:permafrost/core/redux/app_state.dart';
import 'package:permafrost/core/services/firestore.dart';
import 'package:permafrost/locator.dart';

class PermaPersistor extends Persistor {
  @override
  Future<void> deleteState() async {
    FirestoreService firestore = locator<FirestoreService>();
    DocumentReference reference = await firestore.getReference();
    await reference.delete();
  }

  @override
  Future<void> persistDifference({lastPersistedState, newState}) async {
    AppState state = (newState as AppState);
    AppState lastState = (lastPersistedState as AppState);
    if (lastState != null &&
        (state.compartments != lastState.compartments ||
            state.items != lastState.items)) {
      FirestoreService firestore = locator<FirestoreService>();
      DocumentReference reference = await firestore.getReference();

      await reference.setData({
        'compartments': state.compartments
            .map((compartment) => compartment.toJson())
            .toList(),
        'items': state.items.map((item) => item.toJson()).toList()
      });
    }
  }

  @override
  Future<AppState> readState() async {
    FirestoreService firestore = locator<FirestoreService>();
    DocumentReference reference = await firestore.getReference();
    DocumentSnapshot document = await reference.get();
    if (document.data == null) {
      return null;
    }

    return AppState.initialState().copy(
        compartments: document.data['compartments']
            .map<Compartment>((element) => Compartment.fromJson(element))
            .toList(),
        items: document.data['items']
            .map<Item>((element) => Item.fromJson(element))
            .toList());
  }
}
