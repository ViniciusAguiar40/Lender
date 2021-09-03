import 'package:flutter/material.dart';
import 'global.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';

class EditPerfil extends StatefulWidget {
  @override
  _EditPerfil createState() => _EditPerfil();
}

class _EditPerfil extends State<EditPerfil> {

  TextEditingController _novaSenha= new TextEditingController();
  TextEditingController _novaInst= new TextEditingController();
  TextEditingController _novoTel= new TextEditingController();
  TextEditingController _antigaSenha = new TextEditingController();

  void verifica()
  {
    String _passwordMd5;
    _passwordMd5 = md5.convert(utf8.encode(_antigaSenha.text)).toString();

    Firestore.instance.collection('user').where(
        'email', isEqualTo: usuario).where('senha',isEqualTo: _passwordMd5).getDocuments().then((QuerySnapshot docs) {
      if (docs.documents.isNotEmpty) {

      }
      else{
        showDialog(
            context: context,
            builder:(BuildContext context){
              return AlertDialog(
                title: new Text("Erro"),
                content: new Text("Usuário e/ou senha inválidos"),
                actions: <Widget>[
                  new FlatButton(
                    child: new Text("OK"),
                    onPressed: (){
                      Navigator.of(context).pop();
                    },
                  )
                ],
              );
            }
        );
      }
    }
    );
  }
  void update(){}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Editar perfil"),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 10, left: 40, right: 40),
        child: Column(
          children: <Widget>[
            TextField(
              // autofocus: true,
              controller: _novaSenha,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: "Nova senha",
                labelStyle: TextStyle(
                  color: Colors.black45,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
              ),
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            TextField(
              // autofocus: true,
              controller: _novaInst,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: "Nova instituição",
                labelStyle: TextStyle(
                  color: Colors.black45,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
              ),
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            TextField(
              // autofocus: true,
              controller: _novoTel,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: "Novo celular",
                labelStyle: TextStyle(
                  color: Colors.black45,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
              ),
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 15,
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
                    "Confirmar alterações",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: new Text("Digite sua senha atual para confirmar"),
                            content: new TextField(
                              // autofocus: true,
                              controller: _antigaSenha,
                              obscureText: true,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                labelText: "Senha atual",
                                icon: Icon(Icons.lock),
                                labelStyle: TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 20,
                                ),
                              ),
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            actions: <Widget>[
                              new FlatButton(
                                child: new Text("OK"),
                                onPressed: () {
                                  verifica();
                                },
                              )
                            ],
                          );
                        }
                    );
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
