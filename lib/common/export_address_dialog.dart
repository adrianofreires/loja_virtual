import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:loja_virtual/models/address.dart';
import 'package:screenshot/screenshot.dart';

class ExportAddressDialog extends StatefulWidget {
  final Address address;

  ExportAddressDialog(this.address);

  @override
  _ExportAddressDialogState createState() => _ExportAddressDialogState();
}

class _ExportAddressDialogState extends State<ExportAddressDialog> {
  final ScreenshotController screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Endereço de Entrega'),
      content: Screenshot(
        controller: screenshotController,
        child: Container(
          padding: EdgeInsets.all(10.0),
          color: Colors.white,
          child: Text(
            '${widget.address.street}, ${widget.address.number}, ${widget.address.complement}\n'
            '${widget.address.district}\n'
            '${widget.address.city} - ${widget.address.state}\n'
            '${widget.address.zipCode}',
          ),
        ),
      ),
      contentPadding: EdgeInsets.fromLTRB(16, 16, 8, 0),
      actions: [
        FlatButton(
          onPressed: () async {
            Navigator.of(context).pop();
            final file = await screenshotController.capture();
            await GallerySaver.saveImage(file.path);
          },
          child: Text('Exportar'),
        )
      ],
    );
  }
}
