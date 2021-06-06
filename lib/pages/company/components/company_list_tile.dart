import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:AjudaEu/models/company.dart';
import 'package:provider/provider.dart';

class CompanyListTile extends StatelessWidget {
  const CompanyListTile(this.company);

  final Company company;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Company>.value(
      value: company,
      child: Card(
        color: Colors.grey,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        child: Container(
          height: 90,
          padding: const EdgeInsets.all(8),
          child: ListTile(
            isThreeLine: true,
            title: AutoSizeText(company.name,
                maxLines: 2,
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.black87,
                    fontWeight: FontWeight.bold),
                minFontSize: 18,
                overflow: TextOverflow.ellipsis),
            subtitle: AutoSizeText(company.city,
                maxLines: 2,
                style: TextStyle(fontSize: 14, color: Colors.black87),
                minFontSize: 14,
                overflow: TextOverflow.ellipsis),
            trailing: IconButton(
              color: Colors.yellow,
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.of(context)
                    .pushNamed('/company_item', arguments: company);
              },
            ),
          ),
        ),
      ),
    );
  }
}
