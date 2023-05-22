import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:thunderapp/shared/core/models/banca_model.dart';
import 'package:thunderapp/shared/core/user_storage.dart';

import '../../shared/constants/app_text_constants.dart';

class HomeScreenRepository {
  final Dio _dio = Dio();
  UserStorage userStorage = UserStorage();

  Future<BancaModel?> getBancaPrefs(
      String? userToken, String? userPapelId) async {
    print('userId: $userPapelId');
    log('chegou aqui');
    try {
      Response response = await _dio.get(
          '$kBaseURL/produtores/$userPapelId/bancas',
          options: Options(headers: {
            "Authorization": "Bearer $userToken"
          }));
      if (response.statusCode == 200) {
        print(response.data["Banca"]["nome"].toString());
        BancaModel bancaModel = BancaModel(
            response.data["Banca"]["nome"].toString(),
            response.data["Banca"]["descricao"].toString(),
            response.data["Banca"]["horario_funcionamento"]
                .toString(),
            response.data["Banca"]["horario_fechamento"]
                .toString(),
            response.data["Banca"]["preco_min"].toString(),
            response.data["Banca"]["tipo_entrega"]
                .toString(),
            response.data["Banca"]["id"].toString());
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
