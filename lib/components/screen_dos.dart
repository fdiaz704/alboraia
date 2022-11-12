import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:alboraia/constants/provider.dart' as Globals;
import 'package:alboraia/main.dart';

class Screen2 extends StatelessWidget {
  Screen2({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'aparcabicis',
      // debugShowMaterialGrid: false,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        //
        // Tema de la aplicación
        //
        primarySwatch: Colors.blue,
        dividerColor: Colors.orangeAccent,
      ),
      home: const Screen(),
    );
  }
}

class Screen extends StatefulWidget {
  const Screen({Key? key}) : super(key: key);

  @override
  _ScreenState createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  var result1 = [];

  void api() async {
    setState(() {});
    var request1 = http.Request('POST',
        Uri.parse('http://sm.r3recymed.com/saealboraya/apis/Paradas_info/key'));
    var streamedResponse1 = await request1.send();
    var response1 = await http.Response.fromStream(streamedResponse1);
    result1 = await jsonDecode(response1.body);
  }

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 1), (Timer t) => api());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          foregroundColor: Colors.blue,
          leading: IconButton(
              icon: const Icon(Icons.chevron_left_rounded),
              onPressed: () {
                loadJson();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Aparcabicis()),
                );
              }
              // Navigator.of(context).pop(),

              ),
          title: Text(
            Globals.GlobalData.title,
            style: const TextStyle(color: Color(0XFF43b6b3)),
          ),
          centerTitle: true,
          // actions: const <Widget>[
          //   IconButton(
          //       onPressed: null,
          //       icon: Icon(
          //         Icons.settings,
          //         color: Colors.blue,
          //       )),
          // ]
        ),
        body: ListView.builder(
            itemCount: result1.length,
            // itemCount: snapshot.data == null ? 0 : snapshot.data!.length,
            itemBuilder: (context, item) {
              return Card(
                  margin:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                  child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: result1[item]['Habil'] != 0
                          ? Text(
                              '${result1[item]['desc']} - ${result1[item]['time']} min',
                              style: const TextStyle(color: Colors.blue),
                            )
                          : Text(
                              '${result1[item]['desc']} - FUERA DE SERVICIO',
                              style: const TextStyle(color: Colors.red),
                            )));
            }));
  }
}
