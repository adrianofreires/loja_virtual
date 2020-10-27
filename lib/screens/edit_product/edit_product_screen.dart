import 'package:flutter/material.dart';
import 'package:loja_virtual/models/product.dart';

import 'components/images_form.dart';
import 'components/sizes_form.dart';

class EditProductScreen extends StatelessWidget {
  final Product product;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  EditProductScreen({this.product});

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Produto'),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Form(
        key: formKey,
        child: ListView(
          children: <Widget>[
            ImagesForm(
              product: product,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    initialValue: product.name,
                    decoration: InputDecoration(
                      hintText: 'Título',
                      border: InputBorder.none,
                    ),
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                    ),
                    validator: (name) {
                      if (name.length < 6) return 'Título muito curto';
                      return null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      'A partir de',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 13.0,
                      ),
                    ),
                  ),
                  Text('R\$', style: TextStyle(color: primaryColor, fontSize: 22.0, fontWeight: FontWeight.bold),),
                  Padding(
                    padding: const EdgeInsets.only(top: 16, bottom: 8),
                    child: Text(
                      'Descrição',
                      style:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ),
                  TextFormField(
                    initialValue: product.description,
                    style: const TextStyle(
                      fontSize: 16.0,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Decoração',
                      border: InputBorder.none,
                    ),
                    maxLines: null,
                    validator: (descricao){
                      if(descricao.length < 10 )
                        return 'Descrição muito curta';
                      return null;
                    },
                  ),
                  SizesForm(product: product,),
                  RaisedButton(
                    onPressed: () {
                      if (formKey.currentState.validate()) {
                      } else {}
                    },
                    child: Text('Salvar'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
