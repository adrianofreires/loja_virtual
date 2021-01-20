import 'package:flutter/material.dart';
import 'package:loja_virtual/models/address.dart';
import 'package:loja_virtual/models/cart_manager.dart';
import 'package:provider/provider.dart';
import 'address_input_field.dart';
import 'cep_input_field.dart';

class AddressCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 4.0),
        child: Consumer<CartManager>(
          builder: (_, cartManager, __) {
            final address = cartManager.address ?? Address();
            return Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Endereço de Entrega',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.0),
                  ),
                  CepInputField(address),
                  AddressInputField(address),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
