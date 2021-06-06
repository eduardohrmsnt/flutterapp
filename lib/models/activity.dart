import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Activity extends ChangeNotifier {
  String id;
  String name;
  String description;
  bool completed;
  bool excluded;

  Activity(
      {this.id,
      this.name,
      this.description,
      this.completed = false,
      this.excluded = false});

//Faz a conversao para a classe, tendo o documento vindo do flutter como base
  Activity.fromDocument(DocumentSnapshot document) {
    id = document.id;
    name = document.data()['name'] as String;
    description = document.data()['description'] as String;
    completed = (document.data()['completed'] ?? false) as bool;
    excluded = (document.data()['excluded'] ?? false) as bool;
  }
  //Instancia do firebase
  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  //
  DocumentReference get fireStoreRef =>
      fireStore.collection('activity').doc(id);

  void delete() {
    fireStoreRef.update({'excluded': true});
  }

  bool _loading = false;
  bool get loading => _loading;
  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Activity clone() {
    return Activity(
        id: id,
        name: name,
        description: description,
        completed: completed,
        excluded: excluded);
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'completed': completed,
      'excluded': excluded,
    };
  }

  Future<void> save() async {
    loading = true;
    final Map<String, dynamic> data = toMap();

    if (id == null) {
      final doc = await fireStore.collection('activity').add(data);
      id = doc.id;
    } else {
      await fireStoreRef.update(data);
    }
    loading = false;
  }
}
