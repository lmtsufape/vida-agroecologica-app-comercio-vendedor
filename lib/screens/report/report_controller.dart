import 'dart:developer';
import 'package:get/get.dart';
import 'package:thunderapp/screens/home/home_screen_repository.dart';
import 'package:thunderapp/screens/orders/orders_controller.dart';
import 'package:thunderapp/shared/core/models/banca_model.dart';
import 'package:thunderapp/shared/core/models/pedido_model.dart';
import '../../shared/core/user_storage.dart';
import 'report_repository.dart';
import 'report_screen.dart';

class ReportController extends GetxController {
  int quantPedidos = 0;
  BancaModel? bancaModel;
  HomeScreenRepository homeRepository = HomeScreenRepository();
  List<PedidoModel> orders = [];
  List<ReportCard> listaPedidos = [];
  late Future<List<dynamic>> orderData;
  ReportRepository repository = ReportRepository();
  List<PedidoModel> get getOrders => orders;
  var isLoading = true.obs;

  Future<List<ReportCard>> populateReportCard() async {
    isLoading(true); // Inicia o carregamento
    List<ReportCard> list = [];
    UserStorage userStorage = UserStorage();
    var token = await userStorage.getUserToken();
    var userId = await userStorage.getUserId();
    bancaModel = await homeRepository.getBancaPrefs(token, userId);
    var pedidos = await repository.getReports(userId);

    quantPedidos = pedidos.length;

    for (int i = 0; i < pedidos.length; i++) {
      if (pedidos[i].status != "aguardando confirmação") {
        ReportCard card = ReportCard(pedidos[i], OrdersController());
        list.add(card);
      }
    }

    if (list.isNotEmpty) {
      update();
      isLoading(false); // Finaliza o carregamento
      listaPedidos = list;
      return listaPedidos;
    } else {
      log('CARD VAZIO');
      isLoading(false); // Finaliza o carregamento
      return list;
    }
  }

  Future<void> fetchOrders() async {
    UserStorage userStorage = UserStorage();
    String userId = await userStorage.getUserId();
    try {
      var fetchedOrders = await repository.getReports(userId);
      fetchedOrders.sort((a, b) => b.id!.compareTo(a.id!));
      orders.assignAll(fetchedOrders); // Atualiza a lista de pedidos
      await populateReportCard(); // Atualiza os cartões de pedidos
      update(); // Notifica a tela sobre a atualização
    } catch (e) {
      print('Erro ao buscar pedidos: $e');
    }
  }

  Future<String> fetchUserDetails(int userId) async {
    try {
      var userDetails = await repository.fetchUserDetails(userId);
      if (userDetails != null && userDetails.containsKey('user')) {
        return userDetails['user']['name']; // Retorna apenas o nome do usuário
      } else {
        return "Nome não encontrado"; // Retorna uma mensagem padrão
      }
    } catch (e) {
      print('Erro ao buscar nome do usuário: $e');
      return "Erro ao buscar usuário"; // Retorna uma mensagem de erro
    }
  }

  @override
  void onInit() async {
    super.onInit();
    fetchOrders();
  }
}
