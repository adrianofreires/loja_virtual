import 'dart:io';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/models/product.dart';

import 'image_source_sheet.dart';

class ImagesForm extends StatelessWidget {
  final Product product;

  ImagesForm({this.product});

  @override
  Widget build(BuildContext context) {
    return FormField<List<dynamic>>(
      initialValue: List.from(product.images),
      validator: (images) {
        if (images.isEmpty) return 'Insira ao menos uma imagem';
        return null;
      },
      onSaved: (images) => product.newImages = images,
      builder: (state) {
        void onImageSelected(File file) {
          state.value.add(file);
          state.didChange(state.value);
          Navigator.pop(context);
        }

        return Column(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Carousel(
                images: state.value.map<Widget>((image) {
                  return Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      //Imagem
                      image is String
                          ? Image.network(
                              image,
                              fit: BoxFit.cover,
                            )
                          : Image.file(
                              image as File,
                              fit: BoxFit.cover,
                            ),
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                            icon: Icon(Icons.remove_circle_rounded),
                            color: Colors.red,
                            iconSize: 35.0,
                            onPressed: () {
                              state.value.remove(image);
                              state.didChange(state.value);
                            }),
                      ),
                    ],
                  );
                }).toList()
                  ..add(Material(
                    color: Colors.grey[100],
                    child: IconButton(
                      icon: Icon(Icons.add_a_photo),
                      color: Theme.of(context).primaryColor,
                      iconSize: 50.0,
                      onPressed: () {
                        Platform.isAndroid
                            ? showModalBottomSheet(
                                context: context,
                                builder: (_) => ImageSourceSheet(
                                      onImageSelected: onImageSelected,
                                    ))
                            : showCupertinoModalPopup(
                                context: context,
                                builder: (_) => ImageSourceSheet(
                                      onImageSelected: onImageSelected,
                                    ));
                      },
                    ),
                  )),
                dotSize: 4,
                dotSpacing: 15,
                dotBgColor: Colors.transparent,
                dotColor: Theme.of(context).primaryColor,
                autoplay: false,
              ),
            ),
            if (state.hasError)
              Container(
                margin: const EdgeInsets.only(top: 16.0, bottom: 16.0),
                child: Text(
                  state.errorText,
                  style: TextStyle(color: Colors.red, fontSize: 16.0),
                ),
              )
          ],
        );
      },
    );
  }
}
