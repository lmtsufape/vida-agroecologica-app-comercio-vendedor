import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:thunderapp/shared/core/models/banca_model.dart';


import '../../shared/constants/app_text_constants.dart';

class HomeScreenRepository {
  final Dio _dio = Dio();


  Future<BancaModel?> getBancaPrefs(
      String? userToken, String? userId) async {
    print('userId: $userId');
    log('chegou aqui');
    try {
      Response response = await _dio.get(
          '$kBaseURL/bancas/agricultores/$userId',
          options: Options(headers: {
            "Authorization": "Bearer $userToken"
          }));
      if (response.statusCode == 200) {
       
        BancaModel bancaModel = BancaModel(
            response.data["bancas"]["nome"].toString(),
            response.data["bancas"]["descricao"].toString(),
            response.data["bancas"]["horario_funcionamento"]
                .toString(),
            response.data["bancas"]["horario_fechamento"]
                .toString(),
            response.data["bancas"]["preco_minimo"]
                ,
            response.data["bancas"]["tipo_entrega"]
                .toString(),
            response.data["bancas"]["id"],
            response.data["bancas"]["feira_id"],
            response.data["bancas"]["agricultor_id"]);
        log('bancaModel: ${bancaModel.getNome}');
        return bancaModel;
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }
}
