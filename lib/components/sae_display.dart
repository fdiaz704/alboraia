import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:alboraia/database/bdd_aparcabicis.dart';


class Homepage extends StatelessWidget {
  @override
  // late String unicon, nombre, documentid, telefono, direccion, ciudad;
  // late int hijos0a2, resto;
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
            future: BddControler().getData(),
            builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [CircularProgressIndicator()],
                  ),
                );
              }
              if (snapshot.data!.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Sin datos la consulta"),
                    ],
                  ),
                );
              }
              return ListView.builder(
                  itemCount: snapshot.data == null ? 0 : snapshot.data!.length,
                  itemBuilder: (context, item) {

                    return Container(
                        margin: EdgeInsets.symmetric(
                            vertical: 1.0, horizontal: 1.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: Colors.lightBlueAccent,
                        ),
                        padding: const EdgeInsets.all(10.0),
                        child: Column(children: <Widget>[
                          ExpansionTile (
                              title: Text(snapshot.data![item]['id'].toString()+' '+snapshot.data![item]['direccion'].toString()),
                              children: <Widget>[
                                Divider(color: Colors.grey,),
                                ListTile (
                                  title: Text("Llamar"),
                                  leading: Icon(Icons.phone),
                                  onTap: () {},
                                ),
                                Divider(color: Colors.grey,),
                                ListTile (
                                  title: Text("Data SAE"),
                                  onTap: () {
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(builder: (context) => UcScreen(unicon, nombre, documentid, telefono, direccion, ciudad, hijos0a2, resto)),
                                  // );
                                  },
                                ),
                                Divider(color: Colors.grey,),


                              ]
                          ),

                        ]));
                  });
            })
    );
  }

}

