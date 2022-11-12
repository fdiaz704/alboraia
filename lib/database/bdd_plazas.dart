import 'package:mysql1/mysql1.dart';
import 'package:alboraia/constants/constants_bdd.dart';

class BddControler {
  Future<List<dynamic>> getData() async {
    final conn = await MySqlConnection.connect(ConnectionSettings(
      host: constantesBdd.host,
      port: constantesBdd.port,
      user: constantesBdd.user,
      password: constantesBdd.password,
      db: constantesBdd.db,
    ));

    var results =
    await conn.query('select nrounicon, nombre, documentid, telefono, direccion, ciudad, hijos0a2, resto FROM PLAZAS');
    return results.toList();
  }
}