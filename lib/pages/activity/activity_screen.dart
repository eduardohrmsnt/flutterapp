import 'package:flutter/material.dart';
import 'package:AjudaEu/common/custom_drawer/custom_drawer.dart';
import 'package:AjudaEu/manager/activity_manager.dart';
import 'package:AjudaEu/pages/activity/components/activity_list_tile.dart';
import 'package:provider/provider.dart';
//Tela de Atividades
class ActivityScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        actions: [
          FlatButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/activity_item');
              },
              child: Text(
                'Crie sua atividade',
                style: TextStyle(fontSize: 18, color: Colors.white),
              )),
        ],
        title: const Text('Atividades',
            style: TextStyle(fontSize: 16)),
      ),
      body: Consumer<ActivityManager>(
        builder: (_, activityManager, __) {
          return activityManager.allActivity.isEmpty
              ? Center(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                'Nenhuma atividade cadastrada',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          )
              : ListView.builder(
              padding: const EdgeInsets.all(4),
              itemCount: activityManager.allActivity.length,
              itemBuilder: (_, index) {
                return ActivityListTile(
                    activityManager.allActivity[index]);
              });
        },
      ),
    );
  }
}
