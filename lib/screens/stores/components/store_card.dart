import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:loja_virtual/common/custom_icon_button.dart';
import 'package:loja_virtual/models/store.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:url_launcher/url_launcher.dart';

class StoreCard extends StatelessWidget {
  final Store store;

  StoreCard(this.store);

  @override
  Widget build(BuildContext context) {
    void showError() {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Este dispositivo não possui esta função'),
        backgroundColor: Colors.red,
      ));
    }

    Color colorForStatus(StoreStatus status) {
      switch (status) {
        case StoreStatus.close:
          return Colors.red;
        case StoreStatus.open:
          return Colors.green;
        case StoreStatus.closing:
          return Colors.orange;
      }
    }

    Future<void> openPhone() async {
      if (await canLaunch('tel:${store.cleanPhone}')) {
        launch('tel:${store.cleanPhone}');
      } else {
        showError();
      }
    }

    Future<void> openMap() async {
      try {
        final avaliableMaps = await MapLauncher.installedMaps;
        showModalBottomSheet(
            context: context,
            builder: (_) {
              return SafeArea(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (final map in avaliableMaps)
                    ListTile(
                      onTap: () {
                        map.showMarker(
                            coords: Coords(store.address.latitude, store.address.longitude),
                            title: store.name,
                            description: store.addressText);
                        Navigator.of(context).pop();
                      },
                      title: Text(map.mapName),
                      leading: Image(
                        image: map.icon,
                        width: 30,
                        height: 30,
                      ),
                    ),
                ],
              ));
            });
      } catch (e) {
        showError();
      }
    }

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          Container(
            height: 160,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(
                  store.image,
                  fit: BoxFit.cover,
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white, borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8.0))),
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      store.statusText,
                      style: TextStyle(
                        color: colorForStatus(store.status),
                        fontWeight: FontWeight.w800,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 140.0,
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        store.name,
                        style: TextStyle(fontWeight: FontWeight.w800, fontSize: 17),
                      ),
                      Text(
                        store.addressText,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      Text(
                        store.openingText,
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomIconButton(
                      iconData: Icons.map,
                      color: Theme.of(context).primaryColor,
                      onTap: openMap,
                    ),
                    CustomIconButton(
                      iconData: Icons.phone,
                      color: Theme.of(context).primaryColor,
                      onTap: openPhone,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
