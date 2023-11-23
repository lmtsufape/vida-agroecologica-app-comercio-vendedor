import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thunderapp/screens/home/home_screen_repository.dart';
import 'package:thunderapp/shared/core/models/banca_model.dart';
import 'package:thunderapp/shared/core/user_storage.dart';

class HomeScreenController extends GetxController {
  UserStorage userStorage = UserStorage();
  HomeScreenRepository homeScreenRepository =
      HomeScreenRepository();
  String? userToken;
  BancaModel? bancaModel;
  String? userId;

  Future getBancaPrefs() async {
    SharedPreferences prefs =
        await SharedPreferences.getInstance();
    userId = await userStorage.getUserId();
    userToken = await userStorage.getUserToken();
    bancaModel = await homeScreenRepository.getBancaPrefs(
        userToken, userId);
    print(prefs.getStringList('listaProdutosTabelados'));
    update();
  }

  @override
  void onInit() {
    super.onInit();
    getBancaPrefs();
    update();
  }
}
