import 'package:mysql1/mysql1.dart';
import 'package:alboraia/constants/constants_bdd_1.dart';

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
    await conn.query('select id, direccion, latitud, longitud FROM alboraya_estado');
    return results.toList();
  }
}