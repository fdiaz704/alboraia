import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:mysql1/mysql1.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import 'package:http/http.dart' as http;

// import 'package:alboraia/components/personal_data.dart';
import 'package:alboraia/constants/constants_bdd_1.dart';
// import 'package:alboraia/models/promotions.dart';
// import 'package:alboraia/models/documentation.dart';
import 'package:alboraia/components/screen_dos.dart';
// import 'package:alboraia/components/abonos.dart';
// import 'package:alboraia/components/tickets.dart';
import 'package:alboraia/database/bdd_aparcabicis1.dart';
import 'package:alboraia/constants/provider.dart' as Globals;

List jsonResult = [];
List<Marker> allBusStops = [];
List<LatLng> polylineCoordinates = [];
PolylinePoints polylinePoints = PolylinePoints();
String googleAPiKey = "AIzaSyAr74HUqgxFQCOZ4N7cQk270hzQxoYZPL4";

@override
Future<void> loadJson() async {
  // API SAE estimaciones de llegada a las paradas

  var request1 = http.Request('POST',
      Uri.parse('http://sm.r3recymed.com/saealboraya/apis/Paradas_info/key'));
  var streamedResponse1 = await request1.send();
  var response1 = await http.Response.fromStream(streamedResponse1);
  final result1 = jsonDecode(response1.body);

  var uwu4 = result1;

  // Lectura del JSON con todos los tótems instalados

  String data = await rootBundle.loadString('assets/totems.json');
  jsonResult = json.decode(data);

  allBusStops.clear();

  // Incopora los markers de los tótems a la lista de markers

  String uwuFinal = "";
  for (int i = 0; i < jsonResult.length; i++) {
    String uwu = (jsonResult[i]['direcc']);
    String uwu1 = (jsonResult[i]['id']);

    allBusStops.add(
      Marker(
          point: LatLng(double.parse(jsonResult[i]['latitud']),
              double.parse(jsonResult[i]['longitud'])),
          width: 35,
          height: 35,
          builder: (context) => GestureDetector(
              onTap: () {
                for (int i = 0; i < uwu4.length; i++) {
                  if (uwu4[i]['id_totem'].toString() == uwu1) {
                    uwuFinal = uwu4[i]['time'].toString();
                  }
                }
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('$uwu - $uwuFinal min'),
                ));
              },
              child: const Image(image: AssetImage('assets/psaplaya.png')))),
    );
  }

  String data1 = await rootBundle.loadString('assets/marquesinas.json');
  jsonResult = json.decode(data1);

  // Incorpora los markers de marquesinas a la lista de markers

  for (int i = 0; i < jsonResult.length; i++) {
    String uwu = (jsonResult[i]['direcc']);
    String uwu1 = (jsonResult[i]['id']);
    allBusStops.add(
      Marker(
        point: LatLng(double.parse(jsonResult[i]['latitud']),
            double.parse(jsonResult[i]['longitud'])),
        width: 35,
        height: 35,
        builder: (context) => GestureDetector(
            onTap: () {
              for (int i = 0; i < uwu4.length; i++) {
                if (uwu4[i]['id_totem'] == uwu1) {
                  uwuFinal = uwu4[i]['time'].toString();
                }
              }

              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('$uwu - $uwuFinal min'),
              ));
            },
            child: const Image(image: AssetImage('assets/psaplaya.png'))),
      ),
    );
  }
}

_getPolyline() async {
  List uwu2 = await BddControler1().getRuta();
  double cont = 1;
  double latitudOrigen = 0.0;
  double longitudOrigen = 0.0;
  for (var ruta in uwu2) {
    if (cont % 2 == 0) {
      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
          googleAPiKey,
          PointLatLng(latitudOrigen, longitudOrigen),
          PointLatLng(
              double.parse(ruta['latitud']), double.parse(ruta['longitud'])),
          travelMode: TravelMode.transit);
      if (result.points.isNotEmpty) {
        result.points.forEach((PointLatLng point) {
          polylineCoordinates.add(LatLng(point.latitude, point.longitude));
        });
      }
      cont = 0.0;
    } else {
      latitudOrigen = double.parse(ruta['latitud']);
      longitudOrigen = double.parse(ruta['longitud']);
    }

    ++cont;
  }
}

void main() {
  loadJson();
  _getPolyline();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget example1 = SplashScreenView(
      navigateRoute: Aparcabicis(),
      duration: 3000,
      imageSize: 130,
      imageSrc: "assets/splashscreen_image.png",
      text: "EGUSA",
      textType: TextType.ColorizeAnimationText,
      textStyle: const TextStyle(
        fontSize: 50.0,
      ),
      colors: const [
        Colors.purple,
        Colors.blue,
        Colors.yellow,
        Colors.red,
      ],
      backgroundColor: Colors.white,
    );

    return MaterialApp(
      title: 'Splash screen',
      debugShowMaterialGrid: false,
      debugShowCheckedModeBanner: false,
      home: example1,
    );
  }
}

class Aparcabicis extends StatelessWidget {
  Aparcabicis({Key? key}) : super(key: key);

  final initialPosition = LatLng(39.5001863, -0.3493585);

  // Este widget es la raiz.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'aparcabicis',
      debugShowMaterialGrid: false,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
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
  LocationData? currentLocation;
  late final MapController _mapController;
  bool liveUpdate = false;
  String serviceError = '';
  int interActiveFlags = InteractiveFlag.all;
  final Location locationService = Location();
  List<Marker> allMarkers = [];
  List<Marker> busPosition = [];
  var location = Location();
  // var initialPosition = LatLng(39.5001863, -0.3493585);
  late double latBus;
  late double lonBus;

  // Map<PolylineId, Polyline> polylines = {};

  // Invoco la API para leer la geoposición del autobús

  Future<void> pruebaHttp() async {
    var request = http.Request('POST',
        Uri.parse('http://sm.r3recymed.com/saealboraya/apis/bus_info/key'));
    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    final result = jsonDecode(response.body) as Map<String, dynamic>;
    latBus = double.parse(result['Bus_info']['lat_bus']);
    lonBus = double.parse(result['Bus_info']['lon_bus']);
    busPosition.clear();
    busPosition.add(
      Marker(
          point: LatLng(latBus, lonBus),
          width: 30,
          height: 30,
          builder: (context) => const Icon(
                Icons.add_circle_rounded,
                color: Colors.red,
              )),
      // ),
    );
  }

  // Lectura de los equipos instalados y la info proveniente del SAE

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      initLocationService();
    });

    Future<List> prueba = _handleTap();

    _mapController = MapController();

    // initLocationService();
  }

  void initLocationService() async {
    LocationData? location;
    bool serviceEnabled;
    bool serviceRequestResult;
    try {
      serviceEnabled = await locationService.serviceEnabled();

      if (serviceEnabled) {
        location = await locationService.getLocation();
        currentLocation = location;
        locationService.onLocationChanged.listen((LocationData result) async {
          if (mounted) {
            // print(currentLocation);

            setState(() {
              currentLocation = result;
              // if (liveUpdate) {

              // _mapController.move(
              //     LatLng(39.502448, -0.345763),
              //     // LatLng(
              //     //     currentLocation!.latitude!, currentLocation!.longitude!),
              //     17);

              // }
            });
            allMarkers.clear();
            allMarkers.add(
              Marker(
                point: LatLng(
                    currentLocation!.latitude!, currentLocation!.longitude!),
                width: 25,
                height: 25,
                builder: (context) => GestureDetector(
                  onTap: () {
                    // print("pasé por aquí");
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Usted está aquí'),
                    ));
                  },
                  child: const Icon(Icons.account_circle),
                ),
              ),
            );

            pruebaHttp();
          }
        });
      } else {
        serviceRequestResult = await locationService.requestService();
        if (serviceRequestResult) {
          initLocationService();
          return;
        }
      }
    } on PlatformException catch (e) {
      debugPrint(e.toString());
      if (e.code == "PERMISSION_DENIED") {
        serviceError = e.message.toString();
      } else if (e.code == 'SERVICE_STATUS_ERROR') {
        serviceError = e.message.toString();
      }
      location = null;
    }
    await locationService.changeSettings(
      accuracy: LocationAccuracy.high,
      interval: 1000,
    );
  }

  @override
  Widget build(BuildContext context) {
    LatLng currentLatLng;
    if (currentLocation != null) {
      currentLatLng =
          LatLng(currentLocation!.latitude!, currentLocation!.longitude!);
      // print(currentLatLng);

    } else {
      currentLatLng = LatLng(0, 0);
    }

    return Scaffold(
        floatingActionButton: FloatingActionButton(
            mini: true,
            onPressed: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Screen2()),
                  )
                },
            child: const Image(
              image: AssetImage('assets/busmarker.png'),
              height: 30.0,
              width: 30.0,
            )),
        bottomNavigationBar:
            BottomAppBar(color: Colors.black, child: Container(height: 30.0)),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        appBar: AppBar(
            // leading: IconButton( //menu icon button at start left of appbar
            //   onPressed: (){
            //     //code to execute when this button is pressed
            //   },
            //   icon: Icon(Icons.menu),
            // ),
            backgroundColor: Colors.black,
            foregroundColor: Colors.blue,
            title: Text(
              Globals.GlobalData.title,
              style: const TextStyle(color: Color(0XFF43b6b3)),
            ),
            centerTitle: true,
            actions: const <Widget>[
              // IconButton(
              //     onPressed: null,
              //     icon: Icon(
              //       Icons.settings,
              //       color: Colors.blue,
              //     )),
            ]),
        // drawer: Container(
        //     color: Colors.blue,
        //     width: MediaQuery.of(context).size.width * 0.6,
        //     child: myDrawer(context)),
        body: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Column(
            children: [
              Flexible(
                //COMM Mapa en parte de la pantalla
                // height: MediaQuery.of(context).size.height -
                //     (MediaQuery.of(context).size.height / 1),
                // width: MediaQuery.of(context).size.width,
                // decoration:
                //     BoxDecoration(border: Border.all(color: Colors.blue, width: 2)),

                child: FlutterMap(
                  mapController: _mapController,
                  options: MapOptions(
                    center: LatLng(39.502448, -0.345763),
                    //COMM Futura activación por posición del usuario
                    // center: LatLng(currentLatLng.latitude, currentLatLng.longitude),
                    // minZoom: 14.0,
                    zoom: 17,
                    // maxZoom: 19.0,

                    interactiveFlags:
                        InteractiveFlag.all & ~InteractiveFlag.rotate,

                    // onTap: _handleTap,
                  ),
                  nonRotatedChildren: [
                    AttributionWidget.defaultWidget(
                      source: 'Alboraya',
                    ),
                  ],
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://api.mapbox.com/styles/v1/fdiaz704/cl8a7duxf006t14kem62nc5rb/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiZmRpYXo3MDQiLCJhIjoiY2w4N2dlc2kzMGV4YzNvbXRob2UxZXppdCJ9.2pVffDuI9l4bgyfrJN3R3g',
                    ),
                    PolylineLayer(
                      polylineCulling: false,
                      polylines: [
                        Polyline(
                            points: polylineCoordinates,
                            color: Colors.blue,
                            strokeWidth: 3.0),
                      ],
                    ),
                    MarkerLayer(
                      markers: allBusStops,
                    ),
                    MarkerLayer(
                      markers: busPosition,
                    ),
                    MarkerLayer(
                      markers: allMarkers,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Future<List<dynamic>> _handleTap() async {
    final conn = await MySqlConnection.connect(ConnectionSettings(
      host: constantesBdd.host,
      port: constantesBdd.port,
      user: constantesBdd.user,
      password: constantesBdd.password,
      db: constantesBdd.db,
    ));

    var results = await conn
        .query('select id, direccion, latitud, longitud FROM alboraya_estado');
    // print(results);
    return results.toList();
  }

//   // setState(() {
//   // });
}

// Widget myDrawer(BuildContext context) {
//   return Drawer(
//     child: SingleChildScrollView(
//         child: Container(
//             margin: const EdgeInsets.only(top: 20),
//             child: Column(
//               children: <Widget>[
//                 const SizedBox(
//                   height: 50.0,
//                   child: DrawerHeader(
//                     margin: EdgeInsets.all(0.0),
//                     padding: EdgeInsets.all(0.0),
//                     child: Text('Opciones de usuario'),
//                   ),
//                 ),
//                 ListTile(
//                     leading: Icon(Icons.receipt),
//                     title: Text("Abonos"),
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => Abonos()),
//                       );
//                       // Find peoples button action
//                     }),
//                 ListTile(
//                     leading: Icon(Icons.receipt),
//                     title: Text("Tickets"),
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => Tickets()),
//                       );
//                       // Find peoples button action
//                     }),
//                 ListTile(
//                     leading: Icon(Icons.sms),
//                     title: Text("Mensajes"),
//                     onTap: () {
//                       // Home button action
//                     }),
//                 ListTile(
//                     leading: Icon(Icons.person),
//                     title: Text("Mis datos"),
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => Personaldata()),
//                       );
//                       // Find peoples button action
//                     }),
//                 ListTile(
//                     leading: Icon(Icons.money),
//                     title: Text("Promociones"),
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => Page2()),
//                       );
//                       // Find peoples button action
//                     }),
//                 ListTile(
//                     leading: Icon(Icons.book),
//                     title: Text("Tutorial"),
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => Page1()),
//                       );
//                       // Find peoples button action
//                     })
//               ],
//             ))),
//   );
// }
