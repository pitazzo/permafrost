import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_udid/flutter_udid.dart';
import 'package:permafrost/core/models/fridge/compartment.dart';
import 'package:permafrost/core/models/fridge/fridge.dart';
import 'package:permafrost/core/models/fridge/item.dart';
import 'package:permafrost/core/models/user.dart';

class FirestoreService {
  DocumentReference _fridgeReference;
  DocumentReference _userReference;
  StreamSubscription<DocumentSnapshot> _documentSubscription;

  Future _initFridgeReference(String fridgeUUID) async {
    _fridgeReference =
        Firestore.instance.collection('fridges').document(fridgeUUID);
  }

  Future _initUserReference() async {
    String deviceUUID = await FlutterUdid.consistentUdid;
    _userReference =
        Firestore.instance.collection('users').document(deviceUUID);
  }

  Future<DocumentReference> getUserReference() async {
    if (_userReference == null) {
      await _initUserReference();
    }
    return _userReference;
  }

  Future<void> refreshFridgeReference(String fridgeUUID) async {
    _initFridgeReference(fridgeUUID);
  }

  Future<DocumentReference> getFridgeReference({String fridgeUUID}) async {
    if (fridgeUUID == null && _fridgeReference == null) {
      throw Exception('Fridge reference not initialized and no UUID provided');
    }
    if (_fridgeReference == null) {
      await _initFridgeReference(fridgeUUID);
    }
    return _fridgeReference;
  }

  Future<User> getUser() async {
    DocumentReference reference = await this.getUserReference();
    DocumentSnapshot snap = await reference.get();
    if (!snap.exists || snap.data == null) {
      return null;
    }
    return User.fromJson(snap.data);
  }

  Future<void> updateUser(User user) async {
    DocumentReference reference = await this.getUserReference();
    await reference.setData(user.toJson());
  }

  Future<Fridge> getFridge({String fridgeUUID}) async {
    DocumentReference reference =
        await this.getFridgeReference(fridgeUUID: fridgeUUID);
    DocumentSnapshot snap = await reference.get();
    if (!snap.exists || snap.data == null) {
      throw Exception('Can not find fridge  user in database');
    }
    return Fridge(
      owner: '',
      compartments: snap.data['compartments']
          .map<Compartment>((element) => Compartment.fromJson(element))
          .toList(),
      items: snap.data['items']
          .map<Item>((element) => Item.fromJson(element))
          .toList(),
    );
  }

  Future<void> updateFridge(Fridge fridge, {String fridgeUUID}) async {
    DocumentReference reference =
        await this.getFridgeReference(fridgeUUID: fridgeUUID);
    await reference.setData({
      'compartments': fridge.compartments
          .map((compartment) => compartment.toJson())
          .toList(),
      'items': fridge.items.map((item) => item.toJson()).toList()
    });
  }

  void registerListener(Function(DocumentSnapshot) listener) {
    _documentSubscription = _fridgeReference.snapshots().listen(listener);
  }

  Future unregisterListener() async {
    await _documentSubscription.cancel();
  }
}
