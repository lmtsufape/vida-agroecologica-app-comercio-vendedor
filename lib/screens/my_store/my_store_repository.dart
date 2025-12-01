// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thunderapp/shared/constants/app_text_constants.dart';
import 'package:thunderapp/shared/core/models/banca_model.dart';
import 'package:thunderapp/shared/core/user_storage.dart';
import 'package:path_provider/path_provider.dart';

import '../../assets/index.dart';

class MyStoreRepository {
  List<String> checkItems = [];
  bool? entrega;
  FormData body = FormData.fromMap({});
  String formasPagamento = '';
  String role = 'Não entrou';
  UserStorage userStorage = UserStorage();
  final Dio _dio = Dio();

  Future<bool> verificaRole() async {
    UserStorage userStorage = UserStorage();
    String? userToken = await userStorage.getUserToken();
    String? userId = await userStorage.getUserId();

    Response userResponse = await _dio.get(
      '$kBaseURL/users/$userId',
      options: Options(headers: {"Authorization": "Bearer $userToken"}),
    );

    List roles = userResponse.data['user']['roles'];
    bool hasRole4 = roles.any((role) => role['id'] == 4);
    String roleName = roles[0]['nome'];
    role = roleName;
    print('Role Name MyStoreRepository: $role');
    return hasRole4;
  }

  String gerarFormasPagamento(List<bool> isSelected) {
    List<String> selectedItems = [];
    for (int i = 0; i < isSelected.length; i++) {
      if (isSelected[i]) selectedItems.add((i + 1).toString());
    }
    return selectedItems.join(",");
  }

  // Função para editar a banca
  Future<bool> editarBanca(
    String nome,
    String horarioAbertura,
    String horarioFechamento,
    String precoMin,
    String? imgPath,
    List<bool> isSelected,
    String pix,
    bool? entrega,
    BancaModel banca,
    [List<String>? diasFuncionamento]) async {

    print("editarBanca - Iniciando edição");
    print("editarBanca - Nome: $nome");
    print("editarBanca - Horário abertura: $horarioAbertura");
    print("editarBanca - Horário fechamento: $horarioFechamento");
    print("editarBanca - Dias funcionamento: $diasFuncionamento");

    // Obter os dias de funcionamento do SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String diasFuncionamentoJsonString = prefs.getString('dias_funcionamento_banca') ?? '{}';
    print("editarBanca - Dias funcionamento JSON: $diasFuncionamentoJsonString");
    
    Map<String, dynamic> diasFuncionamentoMap = jsonDecode(diasFuncionamentoJsonString);
    print("editarBanca - Dias funcionamento Map: $diasFuncionamentoMap");

    String formatTime(String time) {
      if (time.isNotEmpty && time.length >= 5) {
        return time.substring(0, 5);
      }
      return time;
    }

    String formasPagamento = gerarFormasPagamento(isSelected);
    print("editarBanca - Formas pagamento: $formasPagamento");

    if (formasPagamento == '' && checkItems.isEmpty) {
      for (int i = 0; i < isSelected.length; i++) {
        if (isSelected[i]) {
          checkItems.add((i + 1).toString());
        }
      }
      formasPagamento = checkItems.join(",");
    }

    String? userToken = await userStorage.getUserToken();
    print("editarBanca - UserToken obtido: ${userToken != null}");

    try {
      // Criar FormData para enviar à API
      FormData formData = FormData();
      
      // Adicionar campos básicos
      formData.fields.add(MapEntry("nome", nome.isEmpty ? banca.getNome.toString() : nome.toString()));
      formData.fields.add(MapEntry("descricao", "loja"));
      formData.fields.add(MapEntry("horario_abertura", horarioAbertura.isEmpty ? formatTime(banca.getHorarioAbertura.toString()) : formatTime(horarioAbertura)));
      formData.fields.add(MapEntry("horario_fechamento", horarioFechamento.isEmpty ? formatTime(banca.getHorarioFechamento.toString()) : formatTime(horarioFechamento)));
      formData.fields.add(MapEntry("formas_pagamento", formasPagamento.isNotEmpty ? formasPagamento : '1'));
      formData.fields.add(MapEntry("entrega", entrega?.toString() ?? 'false'));
      formData.fields.add(MapEntry("pix", pix.isEmpty ? banca.getPix.toString() : pix.toString()));
      formData.fields.add(MapEntry("bairro_entrega", "1=>4.50"));
      
      // Adicionar preço mínimo se fornecido
      if (precoMin.isNotEmpty) {
        const find = "R\$";
        const replace = "";
        var pMinimo = precoMin.replaceAll(find, replace);
        var preMinimo = pMinimo.replaceAll(",", ".");
        formData.fields.add(MapEntry("preco_minimo", preMinimo.toString()));
      }
      
      // Adicionar dias de funcionamento no formato correto
      diasFuncionamentoMap.forEach((dia, horarios) {
        if (horarios is List && horarios.length >= 2) {
          // Formato específico que a API espera para arrays aninhados
          formData.fields.add(MapEntry("horarios_funcionamento[$dia][]", horarios[0].toString()));
          formData.fields.add(MapEntry("horarios_funcionamento[$dia][]", horarios[1].toString()));
        }
      });
      
      // Adicionar imagem se fornecida
      if (imgPath != null) {
        formData.files.add(MapEntry(
          "imagem",
          await MultipartFile.fromFile(imgPath, filename: imgPath.split("\\").last)
        ));
      }
      
      // Imprimir campos do FormData para debug
      print("editarBanca - Campos do FormData:");
      for (var field in formData.fields) {
        print("Campo: ${field.key} = ${field.value}");
      }
      
      // Enviar requisição
      print("editarBanca - Enviando requisição para: $kBaseURL/bancas/${banca.getId}");
      Response response = await _dio.post(
        '$kBaseURL/bancas/${banca.getId}',
        options: Options(
          headers: {
            "Authorization": "Bearer $userToken",
            "Content-Type": "multipart/form-data",
            "X-HTTP-Method-Override": "PATCH"
          },
        ),
        data: formData,
      );
      
      print("editarBanca - Status code: ${response.statusCode}");
      if (response.statusCode == 200) {
        print('Banca editada com sucesso');
        return true;
      } else {
        print('Erro ao editar a banca. Status Code: ${response.statusCode}');
        if (response.data != null) {
          print("editarBanca - Resposta: ${response.data}");
        }
        return false;
      }
    } catch (e) {
      print("editarBanca - Erro: $e");
      if (e is DioError) {
        if (e.response != null) {
          print("editarBanca - Erro Dio - Status Code: ${e.response?.statusCode}");
          print("editarBanca - Erro Dio - Dados: ${e.response?.data}");
        }
      }
      return false;
    }
  }

  Future<bool> adicionarBanca(
    String nome,
    String horarioAbertura,
    String horarioFechamento,
    String precoMin,
    String? imgPath,
    List<bool> isSelected,
    bool? entrega,
    String? pix) async {
    String? userToken = await userStorage.getUserToken();
    String? userId = await userStorage.getUserId();

    log("Iniciando adicionarBanca:");
    log("Token: ${userToken != null ? 'Obtido' : 'Nulo'}");
    log("UserId: $userId");

    String formasPagamento = gerarFormasPagamento(isSelected);
    log("Formas de pagamento: $formasPagamento");

    // Obtenha dias da semana dos SharedPreferences como um objeto JSON
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String diasFuncionamentoJson = prefs.getString('dias_funcionamento_banca') ?? '{}';
    
    // Parse o JSON para verificar o conteúdo
    Map<String, dynamic> diasFuncionamentoMap = jsonDecode(diasFuncionamentoJson);
    log("Dias de funcionamento (mapa): $diasFuncionamentoMap");
    
    Map<String, dynamic> formDataMap = {
      "nome": nome,
      "descricao": 'loja',
      "horario_abertura": horarioAbertura,
      "horario_fechamento": horarioFechamento,
      "preco_minimo": precoMin.isNotEmpty ? precoMin : "0",
      "formas_pagamento": formasPagamento.isNotEmpty ? formasPagamento : '1',
      "entrega": entrega?.toString() ?? 'false',
      "pix": pix ?? '',
      "agricultor_id": userId.toString(),
      "feira_id": '1',
      "bairro_entrega": '1=>3.50',
      "horarios_funcionamento": diasFuncionamentoMap
    };

    log("FormDataMap: ${formDataMap.toString()}");

    // Se não houver imagem selecionada, usa a imagem padrão
    try {
      if (imgPath != null) {
        log("Usando imagem do caminho: $imgPath");
        formDataMap["imagem"] = await MultipartFile.fromFile(imgPath);
      } else {
        log("Usando imagem padrão");
        File defaultImage = await _getAssetAsFile(Assets.logoAssociacao);
        formDataMap["imagem"] = await MultipartFile.fromFile(defaultImage.path);
      }
    } catch (e) {
      log("Erro ao processar imagem: $e");
      return false;
    }

    body = FormData.fromMap(formDataMap);
    log("FormData criado com sucesso");

    // Imprimir os campos específicos do FormData
    for (var field in body.fields) {
      log("Campo FormData: ${field.key} = ${field.value}");
    }

    try {
      log("Enviando requisição para: $kBaseURL/bancas");
      Response response = await _dio.post(
        '$kBaseURL/bancas',
        options: Options(headers: {
          "Content-Type": "multipart/form-data",
          "Authorization": "Bearer $userToken"
        }),
        data: body,
      );

      log("Resposta recebida - Status Code: ${response.statusCode}");
      if (response.data != null) {
        log("Corpo da resposta: ${response.data.toString()}");
      }

      if (response.statusCode == 201 || response.statusCode == 200) {
        log('Cadastro da banca bem-sucedido');
        return true;
      } else {
        log('Erro ao criar banca. Status Code: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      if (e is DioError) {
        if (e.response != null) {
          log("Erro Dio - Status Code: ${e.response?.statusCode}");
          log("Erro Dio - Dados: ${e.response?.data.toString()}");
          log("Erro Dio - Headers: ${e.response?.headers.toString()}");
        } else {
          log("Erro Dio sem resposta: ${e.message}");
          log("Erro Dio tipo: ${e.type.toString()}");
        }
      }
      log('Erro completo ao adicionar banca: $e');
      return false;
    }
  }

  Future<bool> adicionarBancaJson(
    String nome,
    String horarioAbertura,
    String horarioFechamento,
    String precoMin,
    String? imgPath,
    List<bool> isSelected,
    bool? entrega,
    String? pix) async {
  
    // Obter as informações necessárias
    String? userToken = await userStorage.getUserToken();
    String? userId = await userStorage.getUserId();
    
    log("Iniciando adicionarBancaJson:");
    log("Token: ${userToken != null ? 'Obtido' : 'Nulo'}");
    log("UserId: $userId");
    
    String formasPagamento = gerarFormasPagamento(isSelected);
    log("Formas de pagamento: $formasPagamento");
    
    // Obter os dias de funcionamento
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String diasFuncionamentoJsonString = prefs.getString('dias_funcionamento_banca') ?? '{}';
    log("JSON dos dias de funcionamento: $diasFuncionamentoJsonString");
    
    Map<String, dynamic> diasFuncionamentoMap = jsonDecode(diasFuncionamentoJsonString);
    log("Map dos dias de funcionamento: $diasFuncionamentoMap");
    
    // Criar o FormData
    FormData formData = FormData();
    
    // Adicionar os campos básicos
    formData.fields.add(MapEntry("nome", nome));
    formData.fields.add(MapEntry("descricao", "loja"));
    formData.fields.add(MapEntry("horario_abertura", horarioAbertura));
    formData.fields.add(MapEntry("horario_fechamento", horarioFechamento));
    formData.fields.add(MapEntry("preco_minimo", precoMin.isNotEmpty ? precoMin : "0"));
    formData.fields.add(MapEntry("formas_pagamento", formasPagamento.isNotEmpty ? formasPagamento : '1'));
    formData.fields.add(MapEntry("entrega", entrega?.toString() ?? 'false'));
    formData.fields.add(MapEntry("pix", pix ?? ''));
    formData.fields.add(MapEntry("agricultor_id", userId.toString()));
    formData.fields.add(MapEntry("feira_id", '1'));
    formData.fields.add(MapEntry("bairro_entrega", '1=>3.50'));
    
    // Adicionar os dias de funcionamento no formato correto
    diasFuncionamentoMap.forEach((dia, horarios) {
      if (horarios is List && horarios.length >= 2) {
        // Formato específico que a API espera para arrays aninhados
        formData.fields.add(MapEntry("horarios_funcionamento[$dia][]", horarios[0].toString()));
        formData.fields.add(MapEntry("horarios_funcionamento[$dia][]", horarios[1].toString()));
      }
    });
    
    // Adicionar a imagem
    try {
      if (imgPath != null) {
        log("Usando imagem do caminho: $imgPath");
        formData.files.add(MapEntry(
          "imagem",
          await MultipartFile.fromFile(imgPath)
        ));
      } else {
        log("Usando imagem padrão");
        File defaultImage = await _getAssetAsFile(Assets.logoAssociacao);
        formData.files.add(MapEntry(
          "imagem",
          await MultipartFile.fromFile(defaultImage.path)
        ));
      }
    } catch (e) {
      log("Erro ao processar imagem: $e");
      return false;
    }
    
    // Imprimir os campos do FormData para debug
    log("Campos do FormData:");
    for (var field in formData.fields) {
      log("Campo: ${field.key} = ${field.value}");
    }
    
    // Enviar a requisição
    try {
      log("Enviando requisição para: $kBaseURL/bancas");
      Response response = await _dio.post(
        '$kBaseURL/bancas',
        options: Options(headers: {
          "Content-Type": "multipart/form-data",
          "Authorization": "Bearer $userToken"
        }),
        data: formData,
      );
      
      log("Resposta recebida - Status Code: ${response.statusCode}");
      if (response.data != null) {
        log("Corpo da resposta: ${response.data.toString()}");
      }
      
      if (response.statusCode == 201 || response.statusCode == 200) {
        log('Cadastro da banca bem-sucedido');
        return true;
      } else {
        log('Erro ao criar banca. Status Code: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      if (e is DioError) {
        if (e.response != null) {
          log("Erro Dio - Status Code: ${e.response?.statusCode}");
          log("Erro Dio - Dados: ${e.response?.data.toString()}");
          log("Erro Dio - Headers: ${e.response?.headers.toString()}");
        } else {
          log("Erro Dio sem resposta: ${e.message}");
          log("Erro Dio tipo: ${e.type.toString()}");
        }
      }
      log('Erro completo ao adicionar banca: $e');
      return false;
    }
  }

  Future<File> _getAssetAsFile(String assetPath) async {
    final ByteData data = await rootBundle.load(assetPath);
    final List<int> bytes = data.buffer.asUint8List();

    Directory? tempDir;
    try {
      tempDir = await getTemporaryDirectory(); // Pode lançar erro
    } catch (e) {
      print("Erro ao acessar getTemporaryDirectory: $e");
    }

    // Se getTemporaryDirectory() falhar, usa getApplicationDocumentsDirectory()
    tempDir ??= await getApplicationDocumentsDirectory();

    final tempFile = File('${tempDir.path}/default_image.png');
    await tempFile.writeAsBytes(bytes, flush: true);
    return tempFile;
  }

  Future<NetworkImage?> getImageStore(int id) async {
    String? userToken = await userStorage.getUserToken();

    if (userToken == null || userToken.isEmpty) {
      print("Token inválido ou ausente. O usuário precisa se autenticar.");
      return null; // Ou redirecionar para a tela de login
    }

    try {
      Response response = await _dio.get(
        '$kBaseURL/bancas/$id/imagem',
        options: Options(
          headers: {
            "Authorization": "Bearer $userToken",
          },
        ),
      );

      if (response.statusCode == 200) {
        print('Imagem da banca obtida com sucesso');
        return await response.data; // Retorna a URL da imagem
      } else if (response.statusCode == 401) {
        print('Erro de autenticação: Token inválido ou expirado');
        // Tente renovar o token ou redirecionar para a tela de login
        return null;
      } else {
        print('Erro ao obter imagem da banca: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Erro ao obter imagem da banca: $e');
      return null;
    }
  }
}