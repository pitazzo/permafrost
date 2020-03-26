import 'package:flutter/material.dart';
import 'package:permafrost/core/models/item.dart';
import 'package:permafrost/ui/shared/utils.dart';

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
              Text(
                widget.item.name,
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.w600, fontFamily: 'Baloo 2'),
              ),
              Divider(),
              Container(height: 5),
              Text(
                'desde el ' + dateToString(widget.item.entryDate),
                style: TextStyle(fontSize: 15, fontFamily: 'Baloo 2')
              ),
              Container(height: 5),
              Text(
                'antes del ' + dateToString(widget.item.expiryDate),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15, fontFamily: 'Baloo 2')

              ),
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
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600, fontFamily: 'Baloo 2'),
                  ),
                ],
              ),
              FlatButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.check_circle_outline, color: Colors.indigo),
                    Text(
                      '  GUARDAR',
                      style: TextStyle(color: Colors.indigo, fontSize: 20, fontFamily: 'Baloo 2'),
                    ),
                  ],
                ),
                onPressed: () {
                  widget.onAmountEdit(widget.item.id, _amount);
                  Navigator.of(context).pop();
                },
              )
            ],
          ),
        )
      ],
    );
  }
}
