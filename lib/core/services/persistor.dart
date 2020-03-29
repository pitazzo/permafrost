import 'package:async_redux/async_redux.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:permafrost/core/models/fridge/compartment.dart';
import 'package:permafrost/core/models/fridge/fridge.dart';
import 'package:permafrost/core/models/fridge/item.dart';
import 'package:permafrost/core/redux/app_state.dart';
import 'package:permafrost/core/services/firestore.dart';
import 'package:permafrost/locator.dart';

class PermaPersistor extends Persistor {
  @override
  Future<void> deleteState() async {
    FirestoreService firestore = locator<FirestoreService>();
    DocumentReference reference = await firestore.getFridgeReference();
    await reference.delete();
  }

  @override
  Future<void> persistDifference({lastPersistedState, newState}) async {
    AppState state = (newState as AppState);
    AppState lastState = (lastPersistedState as AppState);
    if (lastState != null &&
        (state.fridge.compartments != lastState.fridge.compartments ||
            state.fridge.items != lastState.fridge.items)) {
      FirestoreService firestore = locator<FirestoreService>();
      DocumentReference reference = await firestore.getFridgeReference();

      await reference.setData({
        'compartments': state.fridge.compartments
            .map((compartment) => compartment.toJson())
            .toList(),
        'items': state.fridge.items.map((item) => item.toJson()).toList()
      });
    }
  }

  @override
  Future<AppState> readState() async {
    FirestoreService firestore = locator<FirestoreService>();
    DocumentReference reference = await firestore.getFridgeReference();
    DocumentSnapshot document = await reference.get();
    if (document.data == null) {
      return null;
    }

    Fridge fridge = Fridge(
        owner: '',
        compartments: document.data['compartments']
            .map<Compartment>((element) => Compartment.fromJson(element))
            .toList(),
        items: document.data['items']
            .map<Item>((element) => Item.fromJson(element))
            .toList());

    return AppState.initialState().copy(fridge: fridge);
  }
}
