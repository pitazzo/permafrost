import 'package:flutter/material.dart';
import 'package:permafrost/core/models/compartment.dart';
import 'package:permafrost/core/models/item.dart';
import 'package:permafrost/ui/widgets/items/item_tile.dart';

class ItemList extends StatelessWidget {
  final List<Item> items;
  final List<Compartment> compartments;

  ItemList({@required this.items, @required this.compartments});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: List.generate(
          items.length,
          (index) => ItemTile(
                item: items[index],
                compartment: compartments.firstWhere((compartment) =>
                    compartment.id == items[index].compartmentId),
              )),
    );
  }
}
