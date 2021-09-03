import 'package:flutter/material.dart';
import 'PaginaCadastro.dart';
import 'HomePage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'RecSenha.dart';
import 'global.dart';

class Creditos extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: AppBar(title: Text('Sobre o APP')),
      body:Container(
        padding: EdgeInsets.fromLTRB(10,0,10,0),
        child: ListView(
          children: <Widget>[
            Text('\bO aplicativo Share It Now foi desenvolvido como projeto voltado para apresentação na 38º Fetin, a Feira Tecnológica do Inatel - Instituto Nacional de Telecomunicações. Foi idealizado por quatro alunos do curso de Engenharia de Controle e Automação, graduandos do quarto período na instituição.\n\bVisando a Meta 17 da ONU, “Parceria pelas metas”, busca-se desenvolver um trabalho compartilhado entre os usuários, para que suas tarefas cotidianas sejam realizadas de forma mais dinâmica e eficaz. O objetivo é totalmente voltado para trocar ajuda, saindo de uma rotina individualista, evitando gastos desnecessários, diminuindo o consumismo e propagando o altruísmo.', style: TextStyle(fontWeight:FontWeight.w400,fontSize: 18)),
          ],
        ),
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPage createState() => new _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  var showSenha = false;
  TextEditingController _email = new TextEditingController();
  TextEditingController _senha = new TextEditingController();
  void _toggle() {
    setState(() {
      showSenha = !showSenha;
    });
  }
  void verifica()
  {
    String _passwordMd5;
    _passwordMd5 = md5.convert(utf8.encode(_senha.text)).toString();

    Firestore.instance.collection('user').where(
        'email', isEqualTo: _email.text).where('senha',isEqualTo: _passwordMd5).getDocuments().then((QuerySnapshot docs) {
          if (docs.documents.isNotEmpty) {
            usuario = _email.text;
            telefone = docs.documents[0]['phone'];
            instituicao = docs.documents[0]['instituicao'];

            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (BuildContext context) => HomePage()));
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment(50,50), ////////////////// CONFERIR SE ISSO FUNFA
        padding: EdgeInsets.only(top: 0, left: 30, right: 30),
        color: Colors.white,
        child: ListView(
          children: <Widget>[

            SizedBox(
              width: 10,
              height: 150,
              child: Image.asset("assets/logo.png"),
            ),
            TextFormField(
              // autofocus: true,
              keyboardType: TextInputType.emailAddress,
              controller: _email,
              decoration: InputDecoration(
                labelText: "E-mail",
                icon: Icon(Icons.mail),
                labelStyle: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
              ),
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 30,
            ),
            Stack(
              alignment: Alignment.bottomRight,
              children: <Widget>[
                TextFormField(
                  // autofocus: true,
                  keyboardType: TextInputType.text,
                  controller: _senha,
                  obscureText: !showSenha,
                  decoration: InputDecoration(
                    labelText: "Senha",
                    icon: Icon(Icons.lock),
                    labelStyle: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                    ),
                  ),
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  width: 60,
                  child:FlatButton(
                      onPressed:_toggle,
                      child: Icon(showSenha?Icons.visibility_off:Icons.visibility)
                  ),
                )
              ],
            ),
            /*
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                FlatButton(
                  child: Text(
                    "Recuperar Senha",
                    textAlign: TextAlign.left,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ResetPasswordPage(),
                      ),
                    );
                  },
                ),
              ],
            )
            */
            SizedBox(
              height: 15,
            ),
            //Recuperar senha

            SizedBox(
              height: 25,
            ),

            Container(
              height: 50,
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
                    "Login",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 25,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  onPressed: () {
                    verifica();
                  },
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),

            Container(
              height: 50,
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
              child: FlatButton(
                child: Text(
                  "Cadastre-se",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 25,
                  ),
                ),
                onPressed: () {
                  Navigator.push(context,
                    MaterialPageRoute(
                      builder: (context) => Cadastro(),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              width: 160,
              height: 77,
              child:
              FlatButton(
                  onPressed: (){
                    Navigator.push(context,MaterialPageRoute(builder: (context) => Creditos()));
                  },
                  child: Image.asset("assets/logo_oficial_fetin.png")),
            ),
          ],
        ),
      ),
    );
  }
}
