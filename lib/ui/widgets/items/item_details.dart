import 'package:flutter/material.dart';
import 'package:permafrost/core/models/fridge/item.dart';

import 'package:permafrost/ui/shared/utils.dart';
import 'package:permafrost/ui/widgets/misc/save_button.dart';

class ItemDetails extends StatefulWidget {
  final Item item;
  final Function(int, double) onAmountEdit;

  const ItemDetails({Key key, @required this.item, @required this.onAmountEdit})
      : super(key: key);

  @override
  _ItemDetailsState createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails> {
  double _amount;

  @override
  void initState() {
    super.initState();
    _amount = widget.item.amount;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(height: 10),
              Text(widget.item.name,
                  style: Theme.of(context)
                      .textTheme
                      .headline3
                      .copyWith(color: Theme.of(context).accentColor)),
              Divider(),
              Container(height: 5),
              Text('desde el ' + dateToString(widget.item.entryDate),
                  style: Theme.of(context).textTheme.bodyText2),
              Container(height: 5),
              Text('antes del ' + dateToString(widget.item.expiryDate),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyText2),
              Container(height: 10),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Slider(
                        min: 0,
                        max: widget.item.amount,
                        divisions: widget.item.units == 'uds.'
                            ? widget.item.amount.ceil()
                            : null,
                        value: _amount,
                        onChanged: (amount) =>
                            setState(() => _amount = amount)),
                  ),
                  Text(
                    amountToString(_amount, widget.item.units),
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .headline3
                        .copyWith(fontSize: 25),
                  ),
                ],
              ),
              SaveButton(onSave: () {
                widget.onAmountEdit(widget.item.id, _amount);
                Navigator.of(context).pop();
              })
            ],
          ),
        )
      ],
    );
  }
}
