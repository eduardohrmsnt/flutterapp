import 'package:flutter/material.dart';
import 'package:AjudaEu/manager/page_manager.dart';
import 'package:AjudaEu/pages/activity/activity_screen.dart';
import 'package:AjudaEu/pages/company/company_screen.dart';
import 'package:provider/provider.dart';

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => PageManager(pageController),
      child: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          CompanyScreen(),  //sequencia que aparece no menu
          ActivityScreen(),
        ],
      ),
    );
  }
}
