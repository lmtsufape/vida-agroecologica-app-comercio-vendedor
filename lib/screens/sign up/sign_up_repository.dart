import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:thunderapp/shared/constants/app_text_constants.dart';
import 'package:thunderapp/shared/core/user_storage.dart';

import '../../shared/core/models/bairro_model.dart';

class SignUpRepository {
  Dio _dio = Dio();
  BairroModel bairroModel = BairroModel();
  UserStorage userStorage = UserStorage();

  Future<List<BairroModel>> getbairros() async {
    List<dynamic> all;
    List<BairroModel> bairros = [];
    try {
      Response response =
          await _dio.get('$kBaseURL/bairros');
      if (response.statusCode == 200) {
        all = response.data['bairros'];
        if (all.isNotEmpty) {
          for (int i = 0; i < all.length; i++) {
            bairroModel = BairroModel(
                id: all[i]['id'],
                nome: all[i]['nome'],
                taxa: all[i]['taxa']);
            bairros.add(bairroModel);
          }
          return bairros;
        } else {
          return [];
        }
      } else {
        print('erro');
        return [];
      }
    } on DioError catch (e) {
      log(e.toString());
      return [];
    }
  }
}
