import 'dart:convert';
import 'dart:developer';

import 'dart:io';

import 'package:dio/dio.dart';

import 'package:flutter/services.dart';
import 'package:thunderapp/screens/signin/sign_in_repository.dart';
import 'package:thunderapp/shared/constants/app_text_constants.dart';
import 'package:thunderapp/shared/core/user_storage.dart';

import '../../shared/core/models/bairro_model.dart';

class SignUpRepository {
  Dio _dio = Dio();
  SignInRepository signInRepository = SignInRepository();
  BairroModel bairroModel = BairroModel();
  UserStorage userStorage = UserStorage();
  Future<bool> signUp(
      String name,
      String email,
      String password,
      String apelido,
      String telefone,
      String cpf,
      String rua,
      String bairro,
      String numero,
      String cep,
      String nomeBanca,
      String horarioAbertura,
      String horarioFechamento,
      String precoMin,
      bool entrega,
      String? imgPath) async {
    try {
      Response response =
          await _dio.post('$kBaseURL/produtores',
              options: Options(headers: {
                'Content-Type': 'application/json',
              }),
              data: {
            "name": name,
            "email": email,
            "password": password,
            "apelido": apelido,
            "telefone": telefone,
            "cpf": cpf,
            "rua": rua,
            // 'bairro': bairro,
            "bairro_id": 1,
            "numero": numero,
            "cep": cep,
            "distancia_feira": 100.0,
            "distancia_semana": 100.0
          });
      if (response.statusCode == 201) {
        String emailProdutor =
            response.data["produtor"]["email"];
        String idProdutor =
            response.data["produtor"]["id"].toString();
        signInRepository.signIn(
            email: emailProdutor,
            password: password,
            onSuccess: () async {
              String userToken =
                  await userStorage.getUserToken();
              signUpBanca(
                  idProdutor,
                  userToken,
                  nomeBanca,
                  horarioAbertura,
                  horarioFechamento,
                  precoMin,
                  entrega,
                  imgPath);
            });
        log('cadastro do produtor bem sucedido');

        return true;
      } else {
        log('error dentro do request do cadastro do produtor ${response.statusCode.toString()}');
        return false;
      }
    } catch (e) {
      log('Erro na chamada do cadastro do produtor ${e.toString()}');
      return false;
    }
  }

  Future<bool> signUpBanca(
      String idProdutor,
      String userToken,
      String nomeBanca,
      String horarioAbertura,
      String horarioFechamento,
      String precoMin,
      bool entrega,
      String? imgPath) async {
    String tipoEntega = '';
    try {
      if (entrega == true) {
        tipoEntega = 'ENTREGA';
      } else {
        tipoEntega = 'RETIRADA';
      }
      final body = FormData.fromMap({
        "nome": nomeBanca,
        "descricao": "loja",
        "horario_funcionamento": "$horarioAbertura:00",
        "horario_fechamento": "$horarioFechamento:00",
        "funcionamento": "1",
        "preco_minimo": precoMin,
        "tipo_entrega": tipoEntega,
        "imagem": await MultipartFile.fromFile(
          imgPath!.toString(),
          filename: imgPath.split("\\").last,
        )
      });
      try {
        Response response = await _dio.post(
          '$kBaseURL/bancas',
          options: Options(headers: {
            "Content-Type": "multipart/form-data",
            "Authorization": "Bearer $userToken"
          }),
          data: body,
        );
        if (response.statusCode == 201) {
          log('cadastro da banca bem sucedida');
          return true;
        } else {
          log('erro no cadastro da banca ${response.statusCode.toString()}');
          deleteUserInfo(idProdutor);
          return false;
        }
      } catch (e) {
        log(e.toString());
        deleteUserInfo(idProdutor);
        return false;
      }
    } catch (e) {
      log(e.toString());
      deleteUserInfo(idProdutor);
      return false;
    }
  }

  void deleteUserInfo(String id) async {
    try {
      Response response =
          await _dio.delete('$kBaseURL/produtores/$id');
      if (response.statusCode == 204) {
        userStorage.clearUserCredentials();
        log('deletado com sucesso');
      } else {
        log('erro ao deletar');
      }
    } catch (e) {
      log('Erro ao deletar${e.toString()}');
    }
  }
  // Future<List<BairroModel>> getbairros() async {
  //   List<dynamic> all;
  //   List<BairroModel> bairros = [];
  //   try {
  //     Response response =
  //         await _dio.get('$kBaseURL/bairros');
  //     if (response.statusCode == 200) {
  //       all = response.data['bairros'];
  //       if (all.isNotEmpty) {
  //         for (int i = 0; i < all.length; i++) {
  //           bairroModel = BairroModel(
  //               id: all[i]['id'],
  //               nome: all[i]['nome'],
  //               taxa: all[i]['taxa']);
  //           bairros.add(bairroModel);
  //         }
  //         return bairros;
  //       } else {
  //         return [];
  //       }
  //     } else {
  //       print('erro');
  //       return [];
  //     }
  //   } on DioError catch (e) {
  //     log(e.toString());
  //     return [];
  //   }
  // }
}
