import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'global.dart';

class AddObj extends StatefulWidget {
  @override
  _AddObj createState() => _AddObj();
}

class _AddObj extends State<AddObj> {
  bool emprestimo = false;
  bool doar = false;
  bool doacao = false;
  String tipo;

  void send() {
    Firestore.instance.collection('objeto').document().setData({
      'nome': _objeto.text,
      'descricao': _descricao.text,
      'telefone': telefone,
      'autor': usuario,
      'instituicao': instituicao,
      'tipo': tipo,
      'excluido': false,
    });
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text("Pronto!"),
            content: new Text("Objeto ou serviço cadastrado com sucesso!"),
            actions: <Widget>[
              new FlatButton(
                child: new Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  bool verifica() {
    if (_objeto.text.isEmpty) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: new Text("Erro"),
              content: new Text("Escreva o nome do objeto ou serviço"),
              actions: <Widget>[
                new FlatButton(
                  child: new Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
      return false;
    }
    if (!emprestimo && !doar && !doacao) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: new Text("Erro"),
              content: new Text(
                  "Escolha uma opção entre \"Preciso emprestado\",\"Quero doar\" ou \"Preciso de doação\""),
              actions: <Widget>[
                new FlatButton(
                  child: new Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
      return false;
    }
    send();
    return true;
  }

  Widget checkbox(String title, bool boolValue) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Checkbox(
          value: boolValue,
          onChanged: (bool value) {
            /// manage the state of each value
            setState(() {
              switch (title) {
                case "Preciso emprestado":
                  tipo = 'emprestimo';
                  emprestimo = value;
                  doar = doacao = false;
                  break;
                case "Quero doar":
                  tipo = 'paradoar';
                  doar = value;
                  emprestimo = doacao = false;
                  break;
                case "Preciso de doação":
                  tipo = 'precisadedoacao';
                  doacao = value;
                  emprestimo = doar = false;
                  break;
              }
            });
          },
        ),
        Text(title)
      ],
    );
  }

  TextEditingController _objeto = new TextEditingController();
  TextEditingController _descricao = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.blue, title: Text("Novo objeto")),
      body: Container(
        padding: EdgeInsets.only(top: 10, left: 40, right: 40),
        color: Colors.white,
        child: ListView(
          children: <Widget>[
            TextFormField(
              // autofocus: true,
              keyboardType: TextInputType.text,
              controller: _objeto,
              decoration: InputDecoration(
                labelText: "Objeto ou serviço",
                labelStyle: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
              ),
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              // autofocus: true,
              keyboardType: TextInputType.text,
              controller: _descricao,
              decoration: InputDecoration(
                labelText: "Descrição (opcional)",
                labelStyle: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
              ),
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                checkbox("Preciso emprestado", emprestimo),
                checkbox("Quero doar", doar),
                checkbox("Preciso de doação", doacao),
              ],
            ),
            Container(
              height: 50,
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.3, 1],
                  colors: [
                    Colors.blue,
                    Colors.blueGrey,
                  ],
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(25),
                ),
              ),
              child: SizedBox.expand(
                child: FlatButton(
                  child: Text(
                    "Cadastrar",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  onPressed: () {
                    verifica();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
