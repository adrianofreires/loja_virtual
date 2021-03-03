import 'package:flutter/material.dart';
import 'package:loja_virtual/models/order.dart';

class CancelOrderDialog extends StatefulWidget {
  final Order order;
  CancelOrderDialog(this.order);

  @override
  _CancelOrderDialogState createState() => _CancelOrderDialogState();
}

class _CancelOrderDialogState extends State<CancelOrderDialog> {
  bool loading = false;
  String error;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: AlertDialog(
        title: Text('Cancelar ${widget.order.formatedID}'),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(loading ? 'Cancelando...' : 'Esta ação não poderá ser desfeita'),
            if (error != null)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  error,
                  style: TextStyle(color: Colors.red),
                ),
              ),
          ],
        ),
        actions: [
          FlatButton(
            onPressed: !loading
                ? () {
                    Navigator.of(context).pop();
                  }
                : null,
            child: Text('Voltar'),
          ),
          FlatButton(
            onPressed: !loading
                ? () async {
                    setState(() {
                      loading = true;
                    });
                    try {
                      await widget.order.cancel();
                      Navigator.of(context).pop();
                    } catch (e) {
                      setState(() {
                        loading = false;
                        error = e.toString();
                      });
                    }
                  }
                : null,
            textColor: Colors.red,
            child: Text('Cancelar Pedido'),
          ),
        ],
      ),
    );
  }
}
