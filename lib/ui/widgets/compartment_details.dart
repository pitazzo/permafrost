import 'package:flutter/material.dart';
import 'package:permafrost/core/models/compartment.dart';
import 'package:permafrost/core/models/item.dart';
import 'package:permafrost/ui/widgets/compartment_icon.dart';
import 'package:permafrost/ui/widgets/item_tile.dart';

class CompartmentDetails extends StatelessWidget {
  final Compartment compartment;
  final List<Item> items;

  const CompartmentDetails(
      {Key key, @required this.compartment, @required this.items})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Align(
            alignment: Alignment.topRight,
            child: Padding(
                padding: const EdgeInsets.only(top: 35.0, right: 10),
                child: Hero(
                  tag: 'hero-compartment-' + compartment.id.toString(),
                  child: CompartmentIcon(
                      size: 150,
                      color: compartment.color,
                      icon: compartment.icon),
                )),
          ),
          RichText(
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                    text: compartment.name + '\n',
                    style: TextStyle(
                        fontFamily: 'Baloo 2',
                        color: Colors.indigo,
                        fontSize: 50.0,
                        fontWeight: FontWeight.bold)),
                TextSpan(
                    text: items.length.toString() + ' elementos' '\n',
                    style: TextStyle(
                        color: Colors.black54,
                        fontFamily: 'Baloo 2',
                        fontSize: 20.0)),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: List.generate(items.length + 1, (index) {
                if (index < items.length) {
                  return ItemTile(item: items[index]);
                } else {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Icon(Icons.ac_unit,
                          color: Colors.indigo[300], size: 40),
                    ),
                  );
                }
              }),
            ),
          )
        ]);
  }
}
