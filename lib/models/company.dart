import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Company extends ChangeNotifier {
  String id;
  String name;
  String city;
  String address;
  bool excluded;

  Company(
      {this.id, this.name, this.city, this.address, this.excluded = false});

  Company.fromDocument(DocumentSnapshot document) {
    id = document.id;
    name = document.data()['name'] as String;
    city = document.data()['city'] as String;
    address = document.data()['address'] as String;
    excluded = (document.data()['excluded'] ?? false) as bool;
  }

  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  DocumentReference get fireStoreRef => fireStore
      .collection('company')
      .doc(id);

  void delete() {
    fireStoreRef.update({'excluded': true});
  }

  bool _loading = false;
  bool get loading => _loading;
  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Company clone() {
    return Company(
        id: id, name: name, city: city, address: address, excluded: excluded);
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'city': city,
      'address': address,
      'excluded': excluded
    };
  }

  Future<void> save() async {
    loading = true;
    final Map<String, dynamic> data = toMap();

    if (id == null) {
      final doc = await fireStore
          .collection('company')
          .add(data);
      id = doc.id;
    } else {
      await fireStoreRef.update(data);
    }
    loading = false;
  }
}
