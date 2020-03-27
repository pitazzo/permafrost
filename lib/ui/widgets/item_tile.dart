import 'package:flutter/material.dart';
import 'package:permafrost/core/models/compartment.dart';
import 'package:permafrost/core/models/item.dart';
import 'package:permafrost/core/redux/connectors/item_details_connector.dart';
import 'package:permafrost/ui/shared/utils.dart';
import 'package:permafrost/ui/widgets/compartment_icon.dart';

class ItemTile extends StatelessWidget {
  final Item item;
  final Compartment compartment;

  ItemTile({@required this.item, this.compartment});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
            isThreeLine: compartment != null,
            leading: compartment != null
                ? CompartmentIcon(
                    color: compartment.color, icon: compartment.icon, size: 40)
                : null,
            title: Text(
              item.name,
              style: Theme.of(context).textTheme.headline6,
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                compartment != null
                ? Text(compartment.name, style: Theme.of(context).textTheme.bodyText2.copyWith(color: Colors.black))
                : Container(),
                Text('antes del ' + dateToString(item.expiryDate),
                    style: Theme.of(context).textTheme.subtitle1),
              ],
            ),
            trailing: Text(amountToString(item.amount, item.units),
                style: Theme.of(context).textTheme.bodyText2),
            onTap: () => showModalBottomSheet(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15.0),
                      topRight: Radius.circular(15.0)),
                ),
                context: context,
                builder: (context) {
                  return ItemDetailsConnector(item: item);
                })),
        Divider()
      ],
    );
  }
}
