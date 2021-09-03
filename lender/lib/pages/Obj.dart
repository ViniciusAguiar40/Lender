import 'package:flutter/material.dart';
import 'global.dart';
class Objeto extends StatefulWidget {
  @override
  _Objeto createState() => new _Objeto();
}

class _Objeto extends State<Objeto> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text(nome_),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 20, left: 20, right: 0),
        child:Row(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                "Descrição\n",
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                width: 340,
                child: Text(
                  descricao_.isEmpty?'Sem descrição':descricao_,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize:20
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),


              Text(
                "Contato\n",
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Nome: '+autornome_+'\nEmail: '+autor_ + "\nTelefone: ("+telefone_[0]+telefone_[1]+') '+ telefone_.substring(2,7) + '-' +telefone_.substring(7),
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Colors.black,
                    fontSize:20
                ),
              ),


            ],
          ),
        ],
      ),
      ),
    );
  }
}
