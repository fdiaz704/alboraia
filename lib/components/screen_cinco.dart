import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:alboraia/constants/provider.dart' as Globals;
import 'package:alboraia/database/bdd_abrir.dart';

class Screen5 extends StatefulWidget {
  const Screen5({Key? key}) : super(key: key);

  @override
  _Screen5State createState() => _Screen5State();
}

class _Screen5State extends State<Screen5> {

  void initState() {
    super.initState();
    BddControlerabre().getData();
    // print(Globals.GlobalData.plaza);

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          // leading: IconButton(
          //   icon: Icon(Icons.chevron_left_rounded),
          //   onPressed: () => Navigator.of(context).pop(),
          // ),
          backgroundColor: Colors.black,
          foregroundColor: Colors.blue,
          title: Text(Globals.GlobalData.title, style: const TextStyle(color: Color(0XFF43b6b3))),
          centerTitle: true,
        ),
        body: Column(children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 10,
              top: 20,
              bottom: 10,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100.0),
              child: Image.asset('assets/usuario.png'),
            ),
          ),
          Center(
              //TODO Cambiar por variable que provenga de tabla
              child: Text(
            "HOLA, LI CHUNG",
            style: TextStyle(fontSize: 28),
          )),
          Padding(
            padding: const EdgeInsets.only(
              top: 10,
              bottom: 20,
              left: 10,
            ),
            child: Center(
              child: Text(
                "Puerta del locker " + Globals.GlobalData.plaza.toString() + " abierta",
                style: TextStyle(fontSize: 28, color: Colors.red),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 25,
            ),
            child: const Center(
              child: Text(
                "Gracias por utilizar nuestros servicios",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 28, color: Colors.red),
              ),
            ),
          ),
        ]
        ),
      ),
    );
  }
}
