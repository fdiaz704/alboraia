import 'package:mysql1/mysql1.dart';
import 'package:alboraia/constants/constants_bdd.dart';

class BddControlerr1 {
  Future<List<dynamic>> getData(apbid, elect) async {
    final conn = await MySqlConnection.connect(ConnectionSettings(
      host: constantesBdd.host,
      port: constantesBdd.port,
      user: constantesBdd.user,
      password: constantesBdd.password,
      db: constantesBdd.db,
    ));

    var results1 = await conn.query(
        'select pla_id FROM PLAZAS WHERE pla_apbid = $apbid AND pla_swocupado = 0 AND pla_elect = $elect');
    List lista = results1.toList();
    print(lista);
    int plaza = (lista[0]["pla_id"]);
    var results = await conn.query(
        'UPDATE PLAZAS SET pla_swocupado = 1, pla_email = "amesnau@gmail.com", pla_taraplicable = 1, pla_tariff = 1 WHERE pla_apbid = $apbid AND pla_id = $plaza');
    results = await conn.query(
        'SELECT apbi_sincargadisp FROM APARCABICIS WHERE apbi_id = $apbid');
    lista = results.toList();
    int disponible = lista[0]["apbi_sincargadisp"] - 1;
    results = await conn.query(
        'UPDATE APARCABICIS SET apbi_sincargadisp = $disponible WHERE apbi_id = $apbid');

    return results1.toList();
    //TODO Cerrar la conexión a la base de datos
  }
}
