import 'package:mysql1/mysql1.dart';
import 'package:alboraia/constants/constants_bdd.dart';
import 'package:alboraia/constants/provider.dart' as Globals;


class BddControlerbusca {
  Future<List<dynamic>> getData(apbid, elect) async {
    final conn = await MySqlConnection.connect(ConnectionSettings(
      host: constantesBdd.host,
      port: constantesBdd.port,
      user: constantesBdd.user,
      password: constantesBdd.password,
      db: constantesBdd.db,
    ));

    var results1 =
    await conn.query('select pla_id FROM PLAZAS WHERE pla_apbid = $apbid AND pla_swocupado = 0 AND pla_elect = $elect');
    List lista = results1.toList();
    Globals.GlobalData.plaza = lista[0]["pla_id"];
print(Globals.GlobalData.plaza);
    return results1.toList();
  }
}