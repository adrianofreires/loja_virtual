import 'package:flutter/material.dart';
import 'package:loja_virtual/common/custom_icon_button.dart';
import 'package:loja_virtual/models/item_size.dart';

class EditItemSize extends StatelessWidget {
  final ItemSize size;
  final VoidCallback onRemove;
  final VoidCallback onMoveUp;
  final VoidCallback onMoveDown;

  EditItemSize({Key key, this.size, this.onRemove, this.onMoveUp, this.onMoveDown}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 30,
          child: TextFormField(
            initialValue: size.name,
            decoration: InputDecoration(
              labelText: 'Tamanho',
              isDense: true,
            ),
            validator: (name){
              if(name.isEmpty)
                return 'Inválido';
              return null;
            },
            onChanged: (name) => size.name = name,
          ),
        ),
        const SizedBox(width: 4.0,),
        Expanded(
          flex: 30,
          child: TextFormField(
            initialValue: size.stock?.toString(),
            decoration: InputDecoration(
              labelText: 'Estoque',
              isDense: true,
            ),
            keyboardType: TextInputType.number,
            validator: (stock){
              if(int.tryParse(stock) == null)
                return 'Inválido';
              return null;
            },
              onChanged: (stock) => size.stock = int.tryParse(stock),
          ),
        ),
        const SizedBox(width: 4.0,),
        Expanded(
          flex: 40,
          child: TextFormField(
            initialValue: size.price?.toStringAsFixed(2),
            decoration: InputDecoration(
              labelText: 'Preço',
              isDense: true,
              prefixText: 'R\$ ',
            ),
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            validator: (price){
              if(num.tryParse(price) == null)
                return 'Inválido';
              return null;
            },
            onChanged: (price) => size.price = num.tryParse(price),
          ),
        ),
        CustomIconButton(
          iconData: Icons.remove_circle_outline_outlined,
          color: Colors.red,
          onTap: onRemove,
        ),
        CustomIconButton(
          iconData: Icons.arrow_circle_up,
          color: Colors.black,
          onTap: onMoveUp,
        ),
        CustomIconButton(
          iconData: Icons.arrow_circle_down,
          color: Colors.black,
          onTap: onMoveDown,
        ),
      ],
    );
  }
}
