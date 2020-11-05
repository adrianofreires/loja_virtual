import 'package:flutter/material.dart';
import 'package:loja_virtual/models/home_manager.dart';
import 'package:loja_virtual/models/section.dart';

class AddSectionWidget extends StatelessWidget {

  final HomeManager homeManager;
  AddSectionWidget(this.homeManager);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: FlatButton(
            child: Text('Adicionar Lista'),
            textColor: Colors.white,
            onPressed: () {
              homeManager.addSection(Section(type: 'List'));
            },
          ),
        ),
        Expanded(
          child: FlatButton(
            child: Text('Adicionar Grade'),
            textColor: Colors.white,
            onPressed: () {
              homeManager.addSection(Section(type: 'Staggered'));
            },
          ),
        ),
      ],
    );
  }
}
