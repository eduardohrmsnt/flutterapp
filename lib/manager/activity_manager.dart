import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:AjudaEu/models/activity.dart';

class ActivityManager extends ChangeNotifier {
  ActivityManager() {
    _loadAllActivity();
  }

  final FirebaseFirestore fireStore = FirebaseFirestore.instance;

  List<Activity> allActivity = [];

  Future<void> _loadAllActivity() async {
    final QuerySnapshot snapActivity = await fireStore
        .collection('activity')
        .where('excluded', isEqualTo: false)
        .get();
    allActivity =
        snapActivity.docs.map((c) => Activity.fromDocument(c)).toList();
    notifyListeners();
  }

  void update(Activity activity) {
    allActivity.removeWhere((c) => c.id == activity.id);
    allActivity.add(activity);
    notifyListeners();
  }

  void delete(Activity activity) {
    activity.delete();
    allActivity.removeWhere((c) => c.id == activity.id);
    notifyListeners();
  }
}
