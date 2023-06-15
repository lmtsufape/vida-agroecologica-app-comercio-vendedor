import 'package:dio/dio.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../shared/constants/app_text_constants.dart';
import '../../shared/core/user_storage.dart';

class AddProductsRepository extends GetxController {
  late String userToken;

  Future<List<String>> getProducts() async {
    Dio dio = Dio();
    UserStorage userStorage = UserStorage();
    List<String> products = [];

    userToken = await userStorage.getUserToken();

    var response = await dio.get('$kBaseURL/produtos',
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "Bearer $userToken"
          },
        ));

    print(response.data);

    List<dynamic> data =
        response.data['produtos'] as List<dynamic>;

    print(response.statusCode);
    if (response.statusCode == 200 ||
        response.statusCode == 201) {
      for (int i = 0; i < data.length; i++) {
        products.add(data[i]['nome']);
      }
      return products;
    }
    return [];
  }
}
