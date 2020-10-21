import 'package:flutter/material.dart';
import 'package:loja_virtual/models/product.dart';

import 'components/images_form.dart';

class EditProductScreen extends StatelessWidget {

  final Product product;

  EditProductScreen({this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Produto'),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          ImagesForm(product: product,),
        ],
      ),
    );
  }
}
