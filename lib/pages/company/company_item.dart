import 'package:flutter/material.dart';
import 'package:AjudaEu/manager/company_manager.dart';
import 'package:AjudaEu/models/company.dart';
import 'package:provider/provider.dart';
//Tela de alteracoes de empresa
class CompanyItemScreen extends StatelessWidget {
  CompanyItemScreen(Company c)
      : editing = c != null,
        company = c != null ? c.clone() : Company();

  final Company company;
  final bool editing;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: company,
      child: Scaffold(
        appBar: AppBar(
          title: Text(editing ? 'Editar empresa' : "Criar empresa",
              style: TextStyle(fontSize: 18)),
          actions: [
            if (editing)
              IconButton(
                  icon: Icon(Icons.delete),
                  color: Colors.deepOrange,
                  onPressed: () {
                    modalDelete(context);
                  }),
          ],
        ),
        body: Form(
          key: formKey,
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: TextFormField(
                        initialValue: company.name,
                        decoration: const InputDecoration(labelText: "Nome"),
                        onSaved: (name) => company.name = name,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Nome não foi preenchido';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: TextFormField(
                        initialValue: company.city,
                        decoration: const InputDecoration(labelText: "Cidade"),
                        onSaved: (city) => company.city = city,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: TextFormField(
                        initialValue: company.address,
                        maxLines: null,
                        decoration: const InputDecoration(
                            labelText: "Endereço (opcional)"),
                        onSaved: (address) => company.address = address,
                      ),
                    ),
                    SizedBox(height: 80),
                    Consumer<Company>(
                      builder: (_, company, __) {
                        return Container(
                          width: 200,
                          child: RaisedButton(
                            onPressed: !company.loading
                                ? () async {
                                    if (formKey.currentState.validate()) {
                                      formKey.currentState.save();
                                      await company.save();
                                      context
                                          .read<CompanyManager>()
                                          .update(company);
                                      Navigator.of(context).pop();
                                    }
                                  }
                                : null,
                            child: company.loading
                                ? CircularProgressIndicator(
                                    valueColor:
                                        AlwaysStoppedAnimation(Colors.white),
                                  )
                                : const Text('Salvar'),
                            color: Colors.green,
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  modalDelete(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Excluir a empresa',
              style: TextStyle(fontSize: 20),
            ),
            content:
                Text('Deseja realmente excluir a empresa ${company.name}?'),
            actions: [
              Row(
                children: [
                  FlatButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(
                      'Não',
                      style: TextStyle(color: Colors.red, fontSize: 16),
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      context.read<CompanyManager>().delete(company);
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Sim',
                      style: TextStyle(color: Colors.green, fontSize: 16),
                    ),
                  ),
                ],
              ),
            ],
          );
        });
  }
}
