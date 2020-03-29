import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_udid/flutter_udid.dart';

class FirestoreService {
  DocumentReference _fridgeReference;
  DocumentReference _userReference;
  StreamSubscription<DocumentSnapshot> _documentSubscription;

  Future _initFridgeReference() async {
    String deviceUUID =
        "e7ee8a08129fbb56f7f6b748511812c6e9983e3732f30b54fe9b20a0f1268f8c";
    _fridgeReference =
        Firestore.instance.collection('appstates').document(deviceUUID);
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

  Future<DocumentReference> getFridgeReference() async {
    if (_fridgeReference == null) {
      await _initFridgeReference();
    }
    return _fridgeReference;
  }

  void registerListener(Function(DocumentSnapshot) listener) {
    _documentSubscription = _fridgeReference.snapshots().listen(listener);
  }

  Future unregisterListener() async {
    await _documentSubscription.cancel();
  }
}
