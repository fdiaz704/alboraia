import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:alboraia/components/screen_cinco.dart';
import 'package:alboraia/components/tickets.dart';
import 'package:alboraia/components/abonos.dart';
import 'package:alboraia/components/personal_data.dart';
import 'package:alboraia/models/documentation.dart';
import 'package:alboraia/models/promotions.dart';
import 'package:alboraia/constants/provider.dart' as Globals;
import 'package:alboraia/database/bdd_buscalocker.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class Screen4 extends StatefulWidget {
  final int nro;

  const Screen4(this.nro, {Key? key}) : super(key: key);

  @override
  _Screen4State createState() => _Screen4State();
}

class _Screen4State extends State<Screen4> {
  void initState() {
    super.initState();
    BddControlerbusca().getData(widget.nro, 1);
    // print(Globals.GlobalData.plaza);
  }

  void updating() {
    // _isDisable = true;
    // print(_isDisable);
    // BddControlerr().getData(widget.nro, 1);
  }
  Future<void> _vpnConnection() async {
    // var url =
    // Uri.http("100.96.1.2", '8081', {'q': '{Door1}'});

    // Await the http get response, then decode the json-formatted response.
    var response = await http.post(Uri.parse('http://100.96.1.2:8081/door1'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: "");
    print(response.statusCode);
    if (response.statusCode == 200) {
      // var jsonResponse =
      // convert.jsonDecode(response.body) as Map<String, dynamic>;
      // var itemCount = jsonResponse['totalItems'];
      print('Everything ok');
    } else {
      print('NOT OK');
    }
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
          title: Text(
            Globals.GlobalData.title,
            style: const TextStyle(color: Color(0XFF43b6b3)),
          ),
          centerTitle: true,
        ),
        drawer: Container(
            width: MediaQuery.of(context).size.width * 0.6,
            color: Colors.blue,
            child: myDrawer(context)),
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
              child: Text(
            "HOLA, LI CHUNG",
            style: TextStyle(fontSize: 28),
          )),
          Padding(
            padding: const EdgeInsets.only(
              top: 10,
              bottom: 20,
            ),
            child: const Center(
              child: Text(
                "Para abrir el locker",
                style: TextStyle(fontSize: 28, color: Colors.red),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              _vpnConnection();
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Screen5()));
            },
            child: Text("Presione",
                style: TextStyle(fontSize: 28, color: Colors.red)),
            style: ButtonStyle(
              shape: MaterialStateProperty.all(CircleBorder()),
              padding: MaterialStateProperty.all(EdgeInsets.all(50)),
              backgroundColor: MaterialStateProperty.all(Colors.blue),
              // <-- Button color
              overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
                if (states.contains(MaterialState.pressed))
                  return Colors.red; // <-- Splash color
              }),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 25,
            ),
            child: Center(
              child: Text(
                "Su locker asignado es el nro. " +
                    Globals.GlobalData.plaza.toString(),
                style: TextStyle(fontSize: 20, color: Colors.blue),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

Widget myDrawer(BuildContext context) {
  return Drawer(
    child: SingleChildScrollView(
        child: Container(
            margin: const EdgeInsets.only(top: 20),
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 50.0,
                  child: DrawerHeader(
                    margin: EdgeInsets.all(0.0),
                    padding: EdgeInsets.all(0.0),
                    child: Text('Opciones de usuario'),
                  ),
                ),

                ListTile(
                    leading: Icon(Icons.receipt),
                    title: Text("Abonos"),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Abonos()),
                      );
                      // Find peoples button action
                    }),
                ListTile(
                    leading: Icon(Icons.receipt),
                    title: Text("Tickets"),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Tickets()),
                      );
                      // Find peoples button action
                    }),
                ListTile(
                    leading: Icon(Icons.sms),
                    title: Text("Mensajes"),
                    onTap: () {
                      // Home button action
                    }),

                ListTile(
                    leading: Icon(Icons.person),
                    title: Text("Mis datos"),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Personaldata()),
                      );
                      // Find peoples button action
                    }),
                ListTile(
                    leading: Icon(Icons.money),
                    title: Text("Promociones"),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Page2()),
                      );
                      // Find peoples button action
                    }),

                ListTile(
                    leading: Icon(Icons.book),
                    title: Text("Tutorial"),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Page1()),
                      );
                      // Find peoples button action
                    })

                //add more drawer menu here
              ],
            ))),
  );
}
