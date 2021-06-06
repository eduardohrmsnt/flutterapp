import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:AjudaEu/models/company.dart';

class CompanyManager extends ChangeNotifier {
  CompanyManager() {
    _loadAllCompany();
  }

  final FirebaseFirestore fireStore = FirebaseFirestore.instance;

  List<Company> allCompany = [];
  //Carrega todas as empresas que nao estao excluidas
  Future<void> _loadAllCompany() async {
    final QuerySnapshot snapActivity = await fireStore
        .collection('institution')
        .where('excluded', isEqualTo: false)
        .get();
    allCompany = snapActivity.docs.map((c) => Company.fromDocument(c)).toList();
    notifyListeners();
  }
 //Atualiza a empresa
  void update(Company company) {
    allCompany.removeWhere((c) => c.id == company.id);
    allCompany.add(company);
    notifyListeners();
  }
//Delete a empresa
  void delete(Company company) {
    company.delete();
    allCompany.removeWhere((c) => c.id == company.id);
    notifyListeners();
  }
}
