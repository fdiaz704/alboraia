import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:alboraia/constants/provider.dart' as Globals;
import 'package:alboraia/database/bdd_reservar.dart';
import 'package:alboraia/database/bdd_reservar1.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

// void main() => runApp(Screen2());

class Screen2r extends StatefulWidget {
  final String name;
  final int nro;
  final int plazas;
  final String address;
  final String city;
  final int disp;
  final double latitud;
  final double longitud;
  final int concarga;
  final int sincarga;
  // double result = double.parse('2');



  Screen2r(this.name, this.nro, this.plazas, this.address, this.city, this.disp, this.latitud, this.longitud, this.concarga, this.sincarga,
      {Key? key})
      : super(key: key);

  @override
  _Screen2rState createState() => _Screen2rState();
}

class _Screen2rState extends State<Screen2r> {
  Future<void>? _launched;
  String _phone = '';
  List<Marker> allMarkers = [];
  final Set<Polyline> _polyline = {};
  List<LatLng> latlng = [];
  LatLng _new = LatLng(39.4956023, -0.3691913);
  // LatLng _news = LatLng(39.4970238, -0.3695309);
  // LatLng _news = LatLng(widget.latitud, -0.3695309);
  Map<MarkerId, Marker> markers = {};
  // Map<MarkerId, Marker> allMarkers = {};
  late GoogleMapController mapController;
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  String googleAPiKey = "AIzaSyAr74HUqgxFQCOZ4N7cQk270hzQxoYZPL4";

  bool _isDisable= false;
  bool togle = true;


  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    super.initState();
    _isDisable=false;

    allMarkers.add(Marker(
      markerId: MarkerId('myMarker'),
      draggable: false,
      position: LatLng(39.4956023, -0.3691913),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
    ));
    allMarkers.add(Marker(
      markerId: MarkerId(widget.name),
      draggable: false,
      position: LatLng(widget.latitud, widget.longitud),
      // position: LatLng(39.4970238, -0.3695309),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
    ));
    latlng.add(_new);
    LatLng _news = LatLng(widget.latitud, widget.longitud);
    latlng.add(_news);
    _polyline.add(Polyline(
      polylineId: PolylineId("Prueba"),
      color: Colors.red,
      width: 5,
      visible: true,
      //latlng is List<LatLng>
      points: latlng,
    ));
    _getPolyline();

  }
  void updating() {
    _isDisable = true;
    print(_isDisable);
    BddControlerr().getData(widget.nro, 1);
  }
  void updating1() {
    _isDisable = true;
    print(_isDisable);
    BddControlerr1().getData(widget.nro, 0);
  }



  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'aparcabicis',
        theme: ThemeData(
          //
          // Tema de la aplicación
          //
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.black,
              foregroundColor: Colors.blue,
              centerTitle: true,
              leading: IconButton(
                icon: const Icon(Icons.chevron_left_rounded),
                onPressed: () => Navigator.of(context).pop(),
              ),
              title: Text(Globals.GlobalData.title, style: const TextStyle(color: Color(0XFF43b6b3)),),
            ),
            body: Column(
              children: [
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(children: [
                      Image.asset(
                        "assets/splashscreen_image.png",
                        width: 80,
                        height: 80,
                      ),
                    ]),
                    Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              widget.name,
                              style: const TextStyle(
                                  color: Colors.red, fontSize: 26),
                            ),
                            Text(widget.address, style: const TextStyle(fontSize: 18),),
                            Text(widget.city, style: const TextStyle(fontSize: 18),),
                          ]),
                    ),
                    Column(
                      children: [
                        IconButton(
                            onPressed: () => setState(() {
                              togle = !togle;
                              // launch("tel://629112612");
                                }),
                            icon: togle ? Icon(Icons.favorite_border) : Icon(Icons.favorite),
                            color: Colors.red),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 5),
                Center(
                  child: Column(
                    children: [
                      Text("Número de plazas: " + widget.plazas.toString(),
                          style: TextStyle(fontSize: 16)),
                      // Text(widget.nro),
                      Text("Plazas disponibles: " + widget.disp.toString(),
                          style: TextStyle(fontSize: 16)),
                      const SizedBox(height: 10,),
                      // Text("con carga elect.: " + widget.concarga.toString() + "    sin carga elect.: " + widget.sincarga.toString()),
                      const Text("Presione el botón del tipo de plaza a reservar:", style: TextStyle(fontSize: 16),),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Center(

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      ElevatedButton(
                        // style: ,
                        // Botón de reserva para slot con carga
                        onPressed: () {_isDisable ? null : updating();},
                        child: Text('con carga elect. ' + '(' + widget.concarga.toString() + ')'),
                      ),
                      ElevatedButton(
                        // Botón de reserva para slot sin carga
                        // onPressed: _isDisable? null : callBackFunction,
                        onPressed: () {_isDisable ? null : updating1();},

                        child: Text('sin carga elect. ' + '(' + widget.sincarga.toString() +')'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10,),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue, width: 2)),
                    height: MediaQuery.of(context).size.height -
                        (MediaQuery.of(context).size.height / 2.4),
                    width: MediaQuery.of(context).size.width,
                    child: GoogleMap(
                      mapType: MapType.normal,
                      onMapCreated: _onMapCreated,
                      initialCameraPosition: CameraPosition(
                          target: LatLng(39.4956023, -0.3691913), zoom: 16),
                      markers: Set.from(allMarkers),
                      polylines: Set<Polyline>.of(polylines.values),
                    ),
                  ),
                )
              ],
            )));
  }
  void _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
  }

  _addPolyLine() {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
        polylineId: id, color: Colors.blue, width: 5, points: polylineCoordinates);
    polylines[id] = polyline;
    setState(() {});
  }
  _getPolyline() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        googleAPiKey,
        const PointLatLng(39.4956023, -0.3691913),
        PointLatLng(widget.latitud, widget.longitud),
        travelMode: TravelMode.walking);
    // wayPoints: [PolylineWayPoint(location: "Orriols, Valencia Spain")]);
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }
    _addPolyLine();
  }

}
