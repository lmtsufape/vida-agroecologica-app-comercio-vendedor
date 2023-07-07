import 'package:flutter/material.dart';
import 'package:thunderapp/screens/screens_index.dart';
import 'package:thunderapp/shared/constants/style_constants.dart';
import 'package:thunderapp/shared/core/http/http_client.dart';
import 'package:thunderapp/shared/core/navigator.dart';
import 'package:thunderapp/shared/core/repositories/transacoes_repository.dart';

import 'package:thunderapp/shared/core/store/transacao_store.dart';


class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  final TransacaoStore store = TransacaoStore(
    repository: TransasoesRepository(
      client: HttpClient(),
    ),
  );

  @override
  void initState() {
    super.initState();
    store.getTransacoes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Relatórios',
          style: kTitle2.copyWith(color: kPrimaryColor),
        ),
      ),
      body: AnimatedBuilder(
        animation: Listenable.merge(
            [store.isLoading, store.state, store.erro]),
        builder: (context, child) {
          if (store.isLoading.value) {
            return const Center(
                child: CircularProgressIndicator());
          }
          if (store.erro.value.isNotEmpty) {
            return Center(
              child: SingleChildScrollView(
                child: Text(
                  store.erro.value,
                  style: const TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }
          if (store.state.value.isEmpty) {
            return const Center(
              child: Text(
                'Nenhum item na lista',
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
            );
          } else {
            return ListView.separated(
              separatorBuilder: (context, index) =>
                  const SizedBox(
                height: 32,
              ),
              padding: const EdgeInsets.all(16),
              itemCount: store.state.value.length,
              itemBuilder: (_, index) {
                final item = store.state.value[index];
                return Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Pedido ${item.id}',
                      style: kBody3.copyWith(
                          fontWeight: FontWeight.bold),
                    ),
                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Cliente',
                          style: kCaption2.copyWith(
                              color: kTextButtonColor),
                        ),
                        Text(
                            'TEMPORARIO: ${item.consumidor_id}',
                            style: kCaption1),
                        IconButton(
                            onPressed: () {
                              navigatorKey.currentState!
                                  .pushNamed(
                                      Screens.orderDetail);
                            },
                            icon: const Icon(
                              Icons.arrow_forward_ios,
                              color: kTextButtonColor,
                            ))
                      ],
                    ),
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }
}
