import 'package:mysql1/mysql1.dart';
import 'package:alboraia/constants/constants_bdd.dart';
import 'package:alboraia/constants/provider.dart' as Globals;

class BddControlerabre {
  Future<List<dynamic>> getData() async {
    final conn = await MySqlConnection.connect(ConnectionSettings(
      host: constantesBdd.host,
      port: constantesBdd.port,
      user: constantesBdd.user,
      password: constantesBdd.password,
      db: constantesBdd.db,
    ));
int ?apbiid1=Globals.GlobalData.apbiid;
int ?plazaid=Globals.GlobalData.plaza;
print(apbiid1);
print(plazaid);
    var results =
    await conn.query('UPDATE PLAZAS SET pla_apertura = 1, pla_email = "amesnau@gmail.com", pla_taraplicable = 1, pla_tariff = 1 WHERE pla_apbid = $apbiid1 AND pla_id = $plazaid');

    return results.toList();
  }
}