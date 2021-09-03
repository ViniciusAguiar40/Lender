import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Termos extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: AppBar(title: Text('Termos de uso')),
      body:Container(
        padding: EdgeInsets.fromLTRB(15,10,15,0),
        child: ListView(children: <Widget>[Text("Ao usar nossos serviços, você está concordando com estes termos. Leia-os com atenção.\n\n\t§ Ao emprestar ou doar:\nColoque as especificações do objeto na descrição. A descrição é opcional, mas, para total clareza, evite deixar em branco;\nGaranta a integridade do seu objeto e seu funcionamento correto antes de passar para outra pessoa;\nVocê não deve cobrar pelos serviços cadastrados. Todos os empréstimos e doações devem ser feitos de forma direta e gratuita, mediante conversa entre os envolvidos.\n\n\t§ Ao receber um objeto emprestado, você deve:\nGarantir que o objeto está em perfeitas condições antes de usar pela primeira vez;\nUtilizar o objeto de forma correta. Não faça atos indevidos ou inadequados e zele pela sua conservação;\nSe comprometer a devolver o objeto ao seu dono de forma íntegra, ou seja, da mesma forma como recebeu sem nenhum defeito.\n\n\t§ Em casos de furto, roubo ou de objetos danificados, a equipe Share it Now não se responsabiliza pelos atos e nem pelos objetos, sendo de total responsabilidade dos usuários toda e qualquer atitude que aconteça fora do aplicativo. Repudiamos quaisquer práticas como as descritas acima, sendo totalmente contra os ideais do projeto.\nAo cumprir com os termos de uso você garante que não haverá problemas entre os usuários e contribui para que mais pessoas adotem a ideia. Respeite o que não é seu e nos ajude na idealização de um mundo mais compartilhado. Obrigado!", style: TextStyle(fontSize: 16
        ),),
      ],
        ),
    ),
    );
  }
}

class Cadastro extends StatefulWidget {
  @override
  _Cadastro createState() => _Cadastro();
}

class _Cadastro extends State<Cadastro> {
  TextEditingController _name = new TextEditingController();
  TextEditingController _email = new TextEditingController();
  TextEditingController _password = new TextEditingController();
  TextEditingController _phone = new TextEditingController();
  TextEditingController _inst = new TextEditingController();
  List<DropdownMenuItem<String>> listDrop = [];
  bool showSenha = false,aceito = false;

  void _toggle() {
    setState(() {
      showSenha = !showSenha;
    });
  }

  void send() {
    Firestore.instance
        .collection('user')
        .where('email', isEqualTo: _email.text)
        .getDocuments()
        .then((QuerySnapshot docs) {
      if (docs.documents.isNotEmpty) {
        // existe = true
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: new Text("E-mail inválido"),
                content: new Text("Este e-mail já está cadastrado"),
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
      } else {
        String _passwordMd5;
        _passwordMd5 = md5.convert(utf8.encode(_password.text)).toString();
        Firestore.instance.collection('user').document().setData({
          'email': _email.text,
          'nome': _name.text,
          'senha': _passwordMd5,
          'phone': _phone.text,
          'instituicao': _inst.text,
        });

        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: new Text("Cadastro realizado com sucesso"),
                content: new Text(
                    "Agora você já pode fazer login em sua conta! Bem vindo!"),
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
    });
  }

  bool verifica() {
    // verificando o nome
    if (_name.text.isEmpty) {
      //manda bota nome
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: new Text("Atenção"),
              content: new Text("Preencha o campo \"Nome\""),
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

    RegExp vEmail = RegExp(r"^[a-z0-9.]+@[a-z]+\.[a-z]+(\.)?([a-z]+)?$");
    if (!vEmail.hasMatch(_email.text)) {
      //manda ve o email
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: new Text("E-mail inválido"),
              content: new Text("Entre com um e-mail valido"),
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

    // verificando a senha
    if (_password.text.length < 4) {
      // manda verifica a senha
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: new Text("Senha inválida"),
              content: new Text("A senha deve conter ao menos 5 caracteres"),
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

    // verificando a instituicao
    if (_inst.text.length < 3) {
      // manda verifica a senha
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: new Text("Instituição inválida"),
              content: new Text("A instituição deve conter ao menos 3 caracteres"),
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

    RegExp vPhone = RegExp(r"^[0-9]+$");
    if (!vPhone.hasMatch(_phone.text) ||
        _phone.text.length < 10 ||
        _phone.text.length > 11) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: new Text("Número inválido"),
              content: new Text(
                  "Coloque o número com o DDD, sem espaços.\nExemplo: 99 9 99999999"),
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
              aceito = value;
            });
          },
        ),
        FlatButton(
          child: Text(title, style: TextStyle(color: Colors.blue,fontWeight: FontWeight.w400,fontSize: 20,decoration: TextDecoration.underline)),
          onPressed:(){
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => Termos(),
              ),
            );
          }

        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false, // pra sumir com a barra amarela

        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text("Cadastro"),
        ),
        body: Container(
            padding: EdgeInsets.only(top: 10, left: 40, right: 40),
            color: Colors.white,
            child: Column(
              children: <Widget>[
                TextField(
                  // autofocus: true,
                  controller: _name,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: "Nome",
                    icon: Icon(Icons.account_box),
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
                SizedBox(
                  height: 20,
                ),
                TextField(
                  // autofocus: true,
                  controller: _email,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: "Email",
                    icon: Icon(Icons.mail),
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
                SizedBox(
                  height: 20,
                ),

                Stack(
                  alignment: Alignment.bottomRight,
                  children: <Widget>[
                    TextFormField(
                      // autofocus: true,
                      keyboardType: TextInputType.text,
                      controller: _password,
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
                SizedBox(
                  height: 20,
                ),
                TextField(
                  // autofocus: true,
                  controller: _phone,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: "Celular (DDD+Número)",
                    icon: Icon(Icons.phone),
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
                SizedBox(
                  height: 30,
                ),
                TextField(
                  // autofocus: true,
                  controller: _inst,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: "Instituição (Ex.: Inatel)",
                    icon: Icon(Icons.account_balance),
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
                checkbox("Aceito os termos",aceito),
                Container(
                  height: 50,
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      stops: [0.3, 1],
                      colors: aceito?[
                        Colors.blue,
                        Colors.blueGrey,
                      ]:[
                        Colors.grey,
                        Colors.black45,
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
                        if(aceito)
                          verifica();
                      },
                    ),
                  ),
                ),
              ],
            )
        )
    );
  }
}
