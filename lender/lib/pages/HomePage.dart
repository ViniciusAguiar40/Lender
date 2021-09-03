import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Perfil.dart';
import 'global.dart';
import 'Obj.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(instituicao),
        leading: Container(
          height: 40,
          width: 40,
          child: FlatButton(
            child: Icon(Icons.account_circle, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Perfil(),
                ),
              );
            },
          ),
        ),
      ),
      body:StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection('objeto').where('instituicao',isEqualTo: instituicao).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError)
            return new Text('Error: ${snapshot.error}');
          switch (snapshot.connectionState) {
            case ConnectionState.waiting: return new Text('Loading...');
            default:
              return new ListView(
                children: snapshot.data.documents.map((DocumentSnapshot document) {
                  if(document['autor'] != usuario)
                    return new ListTile(
                      title: Container(
                          child: SizedBox.expand(
                            child: FlatButton(
                              child: Align(
                                alignment: Alignment.topLeft,
                                child:Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      document['nome'],
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue,
                                        fontSize: 25,
                                      ),
                                    ),
                                    Text(
                                      document['tipo']=='emprestimo'?'Tenho para emprestar':document['tipo']=='paradoar'?'Aceito a doação':'Tenho para doar',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color: Colors.blueGrey,
                                        fontSize: 20,
                                      ),
                                    ),

                                  ],
                                ),

                              ),
                              onPressed: () {
                                nome_ = document['nome'];
                                inst_ = document['instituicao'];
                                tipo_ = document['tipo'];
                                descricao_ = document['descricao'];
                                telefone_ = document['telefone'];
                                autor_ = document['autor'];
                                Firestore.instance.collection('user').where(
                                    'email', isEqualTo: autor_).getDocuments().then((QuerySnapshot docs) {
                                      autornome_ = docs.documents[0]['nome'];
                                      Navigator.push(context, MaterialPageRoute(builder: (context)  => Objeto()));
                                }
                                );
                              },
                            ),
                          ),
                        height: 100,
                        decoration: BoxDecoration(
                          border: Border.all(color: document['tipo'] == 'emprestimo'?Colors.lightBlue:document['tipo'] == 'paradoar'?Colors.yellow:Colors.redAccent, width: 2.0),
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            stops: [0.3, 1],
                            colors: [
                              Colors.white,
                              Colors.white10,
                            ],
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),


                      ),
                    );
                  else
                    return SizedBox();

                }).toList(),
              );
          }
        },
      )
    );
  }
}
