import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thunderapp/shared/core/user_storage.dart';

class StartController extends GetxController {
  UserStorage userStorage = UserStorage();
  String userName = 'teste';

  Future getUserName() async {
    userName = await userStorage.getUserName();
    update();
  }

  @override
  void onInit() {
    super.onInit();
    getUserName();
  }
}
