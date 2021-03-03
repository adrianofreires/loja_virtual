import 'package:flutter/material.dart';
import 'package:loja_virtual/common/cancel_order_dialog.dart';
import 'package:loja_virtual/common/export_address_dialog.dart';
import 'package:loja_virtual/models/order.dart';
import 'package:loja_virtual/screens/orders/components/order_product_tile.dart';

class OrderTile extends StatelessWidget {
  final Order order;
  final bool showControls;

  OrderTile(this.order, {this.showControls = false});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      child: ExpansionTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  order.formatedID,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                Text(
                  'R\$ ${order.price.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    fontSize: 14.0,
                  ),
                ),
              ],
            ),
            Text(
              order.statusText,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                color: order.status == Status.canceled ? Colors.red : Colors.green,
                fontSize: 14.0,
              ),
            ),
          ],
        ),
        children: <Widget>[
          Column(
            children: order.items.map((e) {
              return OrderProductTile(e);
            }).toList(),
          ),
          if (showControls && order.status != Status.canceled)
            SizedBox(
              height: 60,
              child: Wrap(direction: Axis.vertical, children: [
                Row(
                  children: [
                    FlatButton(
                      onPressed: () {
                        showDialog(
                            context: context, barrierDismissible: false, builder: (_) => CancelOrderDialog(order));
                      },
                      child: Column(
                        children: [
                          Icon(Icons.cancel_outlined),
                          Text('Cancelar'),
                        ],
                      ),
                      textColor: Colors.red,
                    ),
                    FlatButton(
                      onPressed: order.back,
                      child: Column(
                        children: [
                          Icon(Icons.arrow_back),
                          Text('Retroceder'),
                        ],
                      ),
                    ),
                    FlatButton(
                      onPressed: order.advance,
                      child: Column(
                        children: [
                          Icon(Icons.arrow_forward),
                          Text('Avançar'),
                        ],
                      ),
                    ),
                    FlatButton(
                      onPressed: () {
                        showDialog(context: context, builder: (_) => ExportAddressDialog(order.address));
                      },
                      child: Column(
                        children: [
                          Icon(Icons.mail_outlined),
                          Text('Endereço'),
                        ],
                      ),
                    ),
                  ],
                ),
              ]),
            ),
        ],
      ),
    );
  }
}
