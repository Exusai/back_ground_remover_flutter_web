import 'package:flutter/material.dart';
import 'dart:js' as js;

import 'backgroundRemover.dart';

enum Links { github, mail }

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      /* floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.get_app
        ),
        backgroundColor: Color.fromRGBO(255, 61, 111, 1),
        onPressed: (){
          js.context.callMethod("open", ["https://github.com/Exusai/MercadoIPN/blob/Proyecto/MercadoIPN(Beta2.1).apk?raw=true"]);
        },
      ), */
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(0, 0, 0, 0),
        //elevation: 0,
        centerTitle: false,
        title: Text(
          "Quitador de fondos",
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Helvetica',
            //fontStyle: FontStyle.italic,
          ),
        ),
        actions: [
          /*IconButton(
            icon: Icon(Icons.more_horiz),
            color: Colors.black,
            iconSize: 40,
            onPressed: () {
            }
          ),*/
          new PopupMenuButton<Links>(
            //color: Colors.black,
            icon: Icon(Icons.more_horiz, color: Colors.black,),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              ),
            onSelected: (Links result) { setState(() {
              if (result == Links.github) {
                js.context.callMethod("open", ["https://github.com/Exusai"]);
              } else if (result == Links.mail) {
                js.context.callMethod("open", ["mailto:a.a.r.samuel99@gmail.com"]);
              }
            }); },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<Links>>[
              PopupMenuItem<Links>(
                value: Links.github,
                child: ListTile(
                  title: Text("Github"),
                  //leading: Image.asset("images/GitHub.png", height: 30,),
                  leading: Icon(Icons.code, color: Colors.black),
                ),
              ),
              PopupMenuItem<Links>(
                value: Links.mail,
                child: ListTile(
                  title: Text('Mail'),
                  leading: Icon(Icons.mail, color: Colors.black, size: 30),
                ),
              ),
            ],
          )
        ],
      ),
      body: Container(
          //height: size.height,
          width: size.width,
          color: Colors.blueAccent[700],
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                BackgroundRemover(),
              ]
            ),
          ),
        ),  
    );
  }
}