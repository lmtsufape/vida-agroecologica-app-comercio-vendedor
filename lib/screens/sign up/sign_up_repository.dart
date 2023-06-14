import 'dart:convert';
import 'dart:developer';

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:thunderapp/screens/signin/sign_in_repository.dart';
import 'package:thunderapp/shared/constants/app_text_constants.dart';
import 'package:thunderapp/shared/constants/style_constants.dart';
import 'package:thunderapp/shared/core/user_storage.dart';

import '../../shared/components/dialogs/default_alert_dialog.dart';
import '../../shared/core/models/bairro_model.dart';
import '../screens_index.dart';

class SignUpRepository {
  Dio _dio = Dio();
  SignInRepository signInRepository = SignInRepository();
  List<String> checkItems = [];
  String formasPagamento = '';
  UserStorage userStorage = UserStorage();
  BairroModel bairroModel = BairroModel();

  //Essa é a função de cadastro, primeiramente ela faz o cadastro do produtor, depois faz o cadastro da banca,
  // caso o cadastro da banca dê errado, o cadastro do produtor é deletado para evitar inconsistências no banco

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
      String? imgPath,
      List<bool> isSelected,
      BuildContext context) async {
    
    //Verifica se o usuário selecionou alguma forma de pagamento e seta a variável formasPagamento
    // a partir do checkItems, ele percorre o isSelected e verifica quais estão true,
    // e adiciona o valor de i + 1 no checkItems o i + 1 é o id da forma de pagamento, em seguida
    // ele percorre o checkItems e adiciona o valor de cada item no formasPagamento
    if (formasPagamento == '' && checkItems.isEmpty) {
      for (int i = 0; i < isSelected.length; i++) {
        if (isSelected[i] == true) {
          checkItems.add((i + 1).toString());
          print(checkItems);
        }
      }
      for (int i = 0; i < checkItems.length; i++) {
        formasPagamento += '${checkItems[i]},';
      }

      formasPagamento = formasPagamento.substring(
          0, formasPagamento.length - 1);
    }
    try {
      //Efetua a chamada da API para o cadastro do produtor
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
            "bairro": bairro,
            "numero": numero,
            "cep": cep,
            "distancia_feira": 200.15,
            "distancia_semana": 200.15
          });
      if (response.statusCode == 201) {
        //Caso o cadastro do produtor dê certo, ele pega o email do produtor e faz o login para pegar o token,
        // depois ele faz o cadastro da banca
        String emailProdutor =
            response.data["produtor"]["email"];
        String idProdutor = response.data["produtor"]
                ["papel_id"]
            .toString();
        log('idProdutor: $idProdutor');
        try {
          Response login = await _dio.post(
            '$kBaseURL/login',
            data: {
              'email': emailProdutor,
              'password': password,
            },
          );
          if (login.statusCode == 200) {
            String userToken =
                login.data['user']['token'].toString();
            userStorage.saveUserCredentials(
                nome: login.data['user']['nome'],
                email: login.data['user']['email'],
                token: userToken,
                id: login.data['user']['id'].toString(),
                papel: login.data['user']['papel_id']
                    .toString(),
                papelId: login.data['user']['papel_id']
                    .toString());

            if (await signUpBanca(
                idProdutor,
                userToken,
                nomeBanca,
                horarioAbertura,
                horarioFechamento,
                precoMin,
                entrega,
                imgPath)) {
              // ignore: use_build_context_synchronously
              showDialog(
                  context: context,
                  builder: (context) => DefaultAlertDialog(
                        title: 'Sucesso',
                        body:
                            'Cadastro realizado com sucesso',
                        cancelText: 'Ok',
                        confirmText: 'Ok',
                        onConfirm: () =>
                            Navigator.pushReplacementNamed(
                                context, Screens.home),
                        confirmColor: kSuccessColor,
                        cancelColor: kErrorColor,
                      ));
              return true;
            } else {
              formasPagamento = '';
              checkItems = [];
              showDialog(
                  context: context,
                  builder: (context) =>
                      DefaultAlertDialogOneButton(
                          title: 'Erro',
                          body:
                              'Ocorreu um erro, verifique os campos e tente novamente',
                          onConfirm: () {},
                          confirmText: 'ok',
                          buttonColor: kAlertColor));

              return false;
            }
          }
        } catch (e) {
          formasPagamento = '';
          checkItems = [];
          log('Erro no login ${e.toString()}');
          return false;
        }

        return false;
      } else {
        formasPagamento = '';
        checkItems = [];
        log('error dentro do request do cadastro do produtor ${response.statusMessage}');
        return false;
      }
    } catch (e) {
      formasPagamento = '';
      checkItems = [];
      log('Erro na chamada do cadastro do produtor ${e.toString()}');
      showDialog(
          context: context,
          builder: (context) => DefaultAlertDialogOneButton(
                title: 'Erro',
                body:
                    'Ocorreu um erro, verifique os campos e tente novamente',
                onConfirm: () {},
                confirmText: 'ok',
                buttonColor: kAlertColor,
              ));
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
      // cria o body para o cadastro da banca, como a imagem é um arquivo, é necessário usar o MultipartFile
      final body = FormData.fromMap({
        "nome": nomeBanca,
        "descricao": "loja",
        "horario_funcionamento": '$horarioAbertura:00',
        "horario_fechamento": '$horarioFechamento:00',
        "funcionamento": "1",
        "preco_minimo": precoMin,
        "tipo_entrega": tipoEntega,
        "imagem": await MultipartFile.fromFile(
          imgPath.toString(),
          filename: imgPath!.split("\\").last,
        ),
        "formas pagamento": formasPagamento,
      });

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
        formasPagamento = '';
        checkItems = [];
        log('erro no cadastro da banca ${response.statusCode.toString()}');
        deleteUserInfo(idProdutor, userToken);
        return false;
      }
    } catch (e) {
      formasPagamento = '';
      checkItems = [];
      deleteUserInfo(idProdutor, userToken);
      if (e is DioError) {
        final dioError = e;
        if (dioError.response != null) {
          final errorMessage =
              dioError.response!.data['errors'];
          print('Erro: $errorMessage');
          print("Erro ${e.toString()}");
          return false;
        }
      }
      return false;
    }
  }

  void deleteUserInfo(String id, String userToken) async {
    UserStorage userStorage = UserStorage();
    userStorage.clearUserCredentials();
    try {
      Response response = await _dio.delete(
          '$kBaseURL/produtores/$id',
          options: Options(headers: {
            "Authorization": "Bearer $userToken"
          }));
      if (response.statusCode == 204) {
        log('deletado com sucesso');
      } else {
        formasPagamento = '';
        checkItems = [];
        log('erro ao deletar');
      }
    } catch (e) {
      formasPagamento = '';
      checkItems = [];
      if (e is DioError) {
        final dioError = e;
        if (dioError.response != null) {
          final errorMessage =
              dioError.response!.data['errors'];
          print('Erro: $errorMessage');
          print("Erro ${e.toString()}");
        }
      }
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
