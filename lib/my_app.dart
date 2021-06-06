import 'package:flutter/material.dart';
import 'package:AjudaEu/manager/activity_manager.dart';
import 'package:AjudaEu/manager/company_manager.dart';
import 'package:AjudaEu/models/activity.dart';
import 'package:AjudaEu/models/company.dart';
import 'package:AjudaEu/pages/activity/activity_item.dart';
import 'package:AjudaEu/pages/company/company_item.dart';
import 'package:AjudaEu/pages/menu/menu.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => CompanyManager(),
          ),
          ChangeNotifierProvider(
            create: (_) => ActivityManager(),
          ),
        ],
        child: MaterialApp( //Tela lateral
          title: 'AjudaEu',
          debugShowCheckedModeBanner: false,
          onGenerateRoute: (settings) {
            switch (settings.name) {
              case '/company_item':
                return MaterialPageRoute(
                    builder: (_) =>
                        CompanyItemScreen(settings.arguments as Company));
              case '/activity_item':
                return MaterialPageRoute(
                    builder: (_) =>
                        ActivityItemScreen(settings.arguments as Activity));
              case '/':
              default:
                return MaterialPageRoute(builder: (_) => Menu());
            }
          },
        ));
  }
}
