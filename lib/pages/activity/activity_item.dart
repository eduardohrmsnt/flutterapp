import 'package:flutter/material.dart';
import 'package:AjudaEu/manager/activity_manager.dart';
import 'package:AjudaEu/models/activity.dart';
import 'package:provider/provider.dart';
//Tela de alteracoes de Atividade
class ActivityItemScreen extends StatefulWidget {
  ActivityItemScreen(Activity c)
      : editing = c != null,
        activity = c != null ? c.clone() : Activity();

  final Activity activity;
  final bool editing;

  @override
  _ActivityItemScreenState createState() => _ActivityItemScreenState();
}

class _ActivityItemScreenState extends State<ActivityItemScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: widget.activity,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.editing ? 'Editar atividade' : "Criar atividade",
              style: TextStyle(fontSize: 18)),
          actions: [
            if (widget.editing)
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
                        initialValue: widget.activity.name,
                        decoration: const InputDecoration(labelText: "Nome"),
                        onSaved: (name) => widget.activity.name = name,
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
                        initialValue: widget.activity.description,
                        decoration:
                            const InputDecoration(labelText: "Descrição"),
                        onSaved: (description) =>
                            widget.activity.description = description,
                      ),
                    ),
                    SizedBox(height: 80),
                    Container(
                      width: 250,
                      child: CheckboxListTile(
                        value: widget.activity.completed,
                        onChanged: (value) {
                          setState(() {
                            widget.activity.completed = value;
                          });
                        },
                        secondary: CircleAvatar(
                            child: Icon(widget.activity.completed
                                ? Icons.check
                                : Icons.error)),
                        title: Text('Concluído'),
                      ),
                    ),
                    SizedBox(height: 60),
                    Consumer<Activity>(
                      builder: (_, activity, __) {
                        return Container(
                          width: 200,
                          child: RaisedButton(
                            onPressed: !activity.loading
                                ? () async {
                                    if (formKey.currentState.validate()) {
                                      formKey.currentState.save();
                                      await activity.save();
                                      context
                                          .read<ActivityManager>()
                                          .update(activity);
                                      Navigator.of(context).pop();
                                    }
                                  }
                                : null,
                            child: activity.loading
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
              'Excluir a atividade',
              style: TextStyle(fontSize: 20),
            ),
            content:
                Text('Deseja realmente excluir a atividade ${widget.activity.name}?'),
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
                      context.read<ActivityManager>().delete(widget.activity);
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
