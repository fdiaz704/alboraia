import 'package:mysql1/mysql1.dart';
import 'package:alboraia/constants/constants_bdd_1.dart';
Future<List<dynamic>> _returnData() async {
  final conn = await MySqlConnection.connect(ConnectionSettings(
    host: constantesBdd.host,
    port: constantesBdd.port,
    user: constantesBdd.user,
    password: constantesBdd.password,
    db: constantesBdd.db,
  ));
  var snapshot = await conn.query('select id, direccion FROM alboraya_estado');
  return snapshot.toList();
}