import 'package:flutter/material.dart';
import 'PaginaLogin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'global.dart';
import 'NovoObj.dart';
import 'EditPerfil.dart';

class Perfil extends StatelessWidget {
  @override
  final db = Firestore.instance;
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 10, left: 20, right: 20),
        color: Colors.white,
        child: ListView(
          children: <Widget>[

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
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        "Editar perfil          ",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 22,
                        ),
                      ),
                      Icon(Icons.create, color: Colors.white),
                    ],
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditPerfil(),
                      ),
                    );
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
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      "Novo objeto          ",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 22,
                      ),
                    ),
                    Icon(Icons.add_circle, color: Colors.white),
                  ],
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddObj(),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 30,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.3, 1],
                  colors: [
                    Colors.grey,
                    Colors.black45,
                  ],
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(25),
                ),
              ),
              child: Text(
                "Meus objetos",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 22,
                ),
              ),
            ),
            StreamBuilder<QuerySnapshot>(
                stream: db.collection('objeto').where('autor', isEqualTo: usuario).snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: snapshot.data.documents.map((doc) {
                        return ListTile(
                          title: Text(doc.data['nome']),
                          trailing: IconButton(
                            icon: Icon(Icons.cancel),
                            onPressed: () async {
                              await db
                                  .collection('objeto')
                                  .document(doc.documentID)
                                  .delete();
                            },
                          ),
                        );
                      }).toList(),
                    );
                  }
                  else {
                    return SizedBox();
                  }
                }),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Meu perfil"),
        actions: <Widget>[ FlatButton(
          child: Icon(Icons.exit_to_app),
          textColor: Colors.white,
          onPressed: () {
          usuario = '';
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (BuildContext context) => LoginPage()));
          },
        ),
      ]
      ),
    );
  }
}
