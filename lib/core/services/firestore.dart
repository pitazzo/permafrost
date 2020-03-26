import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_udid/flutter_udid.dart';

class FirestoreService {
  DocumentReference _reference;
  StreamSubscription<DocumentSnapshot> _documentSubscription;

  Future _initReference() async {
    String deviceUUID = "e7ee8a08129fbb56f7f6b748511812c6e9983e3732f30b54fe9b20a0f1268f8c"; //await FlutterUdid.consistentUdid;
    _reference =  Firestore.instance.collection('appstates').document(deviceUUID);
  }

  Future<DocumentReference> getReference() async{
    if(_reference == null){
      await _initReference();
    }
    return _reference;
  }

  void registerListener(Function(DocumentSnapshot) listener) {
    _documentSubscription = _reference.snapshots().listen(listener);
  }

  Future unregisterListener() async {
    await _documentSubscription.cancel();
  }
}