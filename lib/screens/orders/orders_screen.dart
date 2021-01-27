import 'package:flutter/material.dart';
import 'package:loja_virtual/common/custom_drawer/custom_drawer.dart';
import 'package:loja_virtual/common/empty_card.dart';
import 'package:loja_virtual/common/login_card.dart';
import 'package:loja_virtual/models/orders_manager.dart';
import 'package:provider/provider.dart';

import '../../common/order_tile.dart';

class OrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Text('Meus Pedidos'),
        centerTitle: true,
      ),
      body: Consumer<OrdersManager>(
        builder: (_, orderManager, __) {
          if (orderManager.user == null) {
            return LoginCard();
          }
          if (orderManager.orders.isEmpty) {
            return EmptyCard(
              title: 'Nenhuma compra encontrada',
              iconData: Icons.border_clear,
            );
          }
          return ListView.builder(
              itemCount: orderManager.orders.length,
              itemBuilder: (_, index) {
                return OrderTile(orderManager.orders.reversed.toList()[index]);
              });
        },
      ),
    );
  }
}
