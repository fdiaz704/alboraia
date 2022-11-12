import 'package:mysql1/mysql1.dart';
import 'package:alboraia/constants/constants_bdd_1.dart';

class BddControler1 {
  Future<List<dynamic>> getRuta() async {
    final conn = await MySqlConnection.connect(ConnectionSettings(
      host: constantesBdd.host,
      port: constantesBdd.port,
      user: constantesBdd.user,
      password: constantesBdd.password,
      db: constantesBdd.db,
    ));

    var results =
    await conn.query('select latitud, longitud FROM recorrido_alboraya');
    return results.toList();
  }
}