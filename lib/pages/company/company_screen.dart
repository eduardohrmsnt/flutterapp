import 'package:flutter/material.dart';
import 'package:AjudaEu/common/custom_drawer/custom_drawer.dart';
import 'package:AjudaEu/manager/company_manager.dart';
import 'package:provider/provider.dart';

import 'components/company_list_tile.dart';

//Tela de empresas
class CompanyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        actions: [
          FlatButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/company_item');
              },
              child: Text(
                'Crie sua empresa',
                style: TextStyle(fontSize: 18, color: Colors.white),
              )),
        ],
        title: const Text('Empresas',
            style: TextStyle(fontSize: 16)),
      ),
      body: Consumer<CompanyManager>(
        builder: (_, companyManager, __) {
          return companyManager.allCompany.isEmpty
              ? Center(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                'Nenhuma empresa cadastrada',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          )
              : ListView.builder(
              padding: const EdgeInsets.all(4),
              itemCount: companyManager.allCompany.length,
              itemBuilder: (_, index) {
                return CompanyListTile(
                    companyManager.allCompany[index]);
              });
        },
      ),
    );
  }
}
