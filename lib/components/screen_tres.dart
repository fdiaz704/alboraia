import 'package:alboraia/components/screen_cuatro.dart';
import 'package:alboraia/constants/provider.dart' as Globals;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

class Screen3 extends StatefulWidget {
  @override
  State<Screen3> createState() => _Screen3State();
}

class _Screen3State extends State<Screen3> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.chevron_left_rounded),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Text(Globals.GlobalData.title),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: Center(
                    child: Container(
                        width: 100,
                        height: 100,
                        /*decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),*/
                        child: Image.asset('assets/splashscreen_image.png')),
                  ),
                ),
                Padding(
                  //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 30),
                  child: TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                        hintText: 'Indique su email de registro'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 0, bottom: 0),
                  //padding: EdgeInsets.symmetric(horizontal: 15),
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Constraseña',
                        hintText: 'Indique su contraseña'),
                  ),
                ),
/*
              FlatButton(
                onPressed: (){
                },
                child: Text(
                  'Olvidó su contraseña',
                  style: TextStyle(color: Colors.blue, fontSize: 15),
                ),
              ),
*/
                Container(
                  height: 50,
                  width: 250,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(20)),
/*
                child: FlatButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) =>
                        Screen4(1)),);
                  },
                  child: Text(
                    'Entrar',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
*/
                ),
                SizedBox(
                  height: 130,
                ),
                Text('¿Nuevo Usuario? Crear Cuenta')
              ],
            ),
          ),
        ));
  }
}
