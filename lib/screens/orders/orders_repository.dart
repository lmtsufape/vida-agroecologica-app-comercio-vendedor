// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import 'package:thunderapp/shared/core/models/pedido_model.dart';
import '../../shared/constants/app_text_constants.dart';
import '../../shared/core/user_storage.dart';

class OrdersRepository extends GetxController {
  late String userToken;
  late int userId;
  final Dio _dio = Dio();

  Future<List<PedidoModel>> getOrders(String userId) async {
    UserStorage userStorage = UserStorage();
    String userToken = await userStorage.getUserToken();

    try {
      var response = await _dio.get(
        '$kBaseURL/transacoes/$userId/vendas',
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "Bearer $userToken",
          },
        ),
      );

      if (response.statusCode == 200) {
        var responseData = response.data;
        log('Response data: $responseData'); // Adding log to check response content
        if (responseData != null && responseData['vendas'] != null) {
          List<dynamic> vendas = responseData['vendas'];
          return vendas.map((json) => PedidoModel.fromJson(json)).toList();
        } else {
          throw Exception('Invalid response data');
        }
      } else {
        throw Exception('Failed to load orders. Status code: ${response.statusCode}');
      }
    } catch (error) {
      log('Error making the request: $error');
      rethrow;
    }
  }

  Future<bool> confirmOrder(int pedidoId, bool confirm) async {
    UserStorage userStorage = UserStorage();
    userToken = await userStorage.getUserToken();

    try {
      var body = {
        "confirmacao": confirm,
      };

      print(body);

      Response response = await _dio.post(
        '$kBaseURL/transacoes/$pedidoId/confirmar',
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "Bearer $userToken",
          },
        ),
        data: body,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      if (e is DioError) {
        final dioError = e;
        if (dioError.response != null) {
          final errorMessage = dioError.response!.data['errors'];
          print('Error: $errorMessage');
          print("Error: ${e.toString()}");
          return false;
        }
      }
      return false;
    }
  }

  Future<bool> confirmDelivery(int pedidoId) async {
    UserStorage userStorage = UserStorage();
    userToken = await userStorage.getUserToken();

    try {
      Response response = await _dio.post(
        '$kBaseURL/transacoes/$pedidoId/enviar',
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "Bearer $userToken",
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      if (e is DioError) {
        final dioError = e;
        if (dioError.response != null) {
          final errorMessage = dioError.response!.data['errors'];
          print('Error: $errorMessage');
          print("Error: ${e.toString()}");
          return false;
        }
      }
      return false;
    }
  }

  Future<Map<String, dynamic>?> fetchUserDetails(int userId) async {
    UserStorage userStorage = UserStorage();
    userToken = await userStorage.getUserToken();

    try {
      Response response = await _dio.get(
        '$kBaseURL/users/$userId',
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "Bearer $userToken",
          },
        ),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.data);
      } else {
        print('Error fetching user details: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error making API call: $e');
      return null;
    }
  }

  Future<Uint8List> getComprovanteBytes(int orderId) async {
    final userToken = await UserStorage().getUserToken();

    String url = '$kBaseURL/transacoes/$orderId/comprovante';

    try {
      Response response = await _dio.get(
        url,
        options: Options(
          headers: {
            'Authorization': 'Bearer $userToken',
          },
          responseType: ResponseType.bytes,
        ),
      );

      if (response.statusCode == 200) {
        return Uint8List.fromList(response.data);
      } else {
        throw Exception('Failed to get receipt bytes');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<String> downloadComprovante(int orderId) async {
    final userToken = await UserStorage().getUserToken();

    String url = '$kBaseURL/transacoes/$orderId/comprovante';

    try {
      String? selectedDirectory = await FilePicker.platform.getDirectoryPath();

      if (selectedDirectory == null) {
        final directory = await getExternalStorageDirectory();
        selectedDirectory = directory?.path ?? '';
      }

      Response response = await _dio.get(
        url,
        options: Options(
          headers: {
            'Authorization': 'Bearer $userToken',
          },
          responseType: ResponseType.bytes,
        ),
      );

      if (response.statusCode == 200) {
        String? contentType = response.headers.value(Headers.contentTypeHeader);
        String fileExtension;

        if (contentType != null) {
          if (contentType == 'application/pdf') {
            fileExtension = 'pdf';
          } else if (contentType == 'image/jpeg') {
            fileExtension = 'jpg';
          } else if (contentType == 'image/png') {
            fileExtension = 'png';
          } else {
            throw Exception('Unsupported content type: $contentType');
          }
        } else {
          throw Exception('Content-Type header not found');
        }

        final file = File('$selectedDirectory/comprovante_$orderId.$fileExtension');
        await file.writeAsBytes(response.data);
        return file.path;
      } else {
        throw Exception('Failed to download receipt');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}