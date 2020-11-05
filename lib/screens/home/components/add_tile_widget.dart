import 'dart:io';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/models/section.dart';
import 'package:loja_virtual/models/section_item.dart';
import 'package:loja_virtual/screens/edit_product/components/image_source_sheet.dart';

class AddTileWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final section = context.watch<Section>();
    void onImageSelected(File file){
      section.addItem(SectionItem(image: file));
      Navigator.pop(context);
    }
    return AspectRatio(
      aspectRatio: 1,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.0),
        child: GestureDetector(
          onTap: () {
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
          child: Container(
            color: Colors.white.withAlpha(100),
            child: Icon(
              Icons.add_circle_outline_rounded,
              color: Colors.white,
              size: 40.0,
            ),
          ),
        ),
      ),
    );
  }
}
