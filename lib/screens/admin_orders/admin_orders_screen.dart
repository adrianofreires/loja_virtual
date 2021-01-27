import 'package:flutter/material.dart';
import 'package:loja_virtual/common/custom_drawer/custom_drawer.dart';
import 'package:loja_virtual/common/empty_card.dart';
import 'package:loja_virtual/models/admin_orders_manager.dart';
import 'file:///D:/Documents/AndroidStudioProjects/loja_virtual/lib/common/order_tile.dart';
import 'package:provider/provider.dart';

class AdminOrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Text('Pedidos Realizados'),
        centerTitle: true,
      ),
      body: Consumer<AdminOrdersManager>(
        builder: (_, orderManager, __) {
          if (orderManager.orders.isEmpty) {
            return EmptyCard(
              title: 'Nenhuma venda realizada',
              iconData: Icons.border_clear,
            );
          }
          return ListView.builder(
              itemCount: orderManager.orders.length,
              itemBuilder: (_, index) {
                return OrderTile(
                  orderManager.orders.reversed.toList()[index],
                  showControls: true,
                );
              });
        },
      ),
    );
  }
}
