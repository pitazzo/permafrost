import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:permafrost/core/models/fridge/item.dart';
import 'package:permafrost/core/services/validators.dart';
import 'package:permafrost/ui/widgets/misc/save_button.dart';

class ItemEditor extends StatefulWidget {
  final Item originalItem;
  final Function(String, double, String, DateTime, DateTime) onAdded;
  Function(int, int, String, double, String, DateTime, DateTime) onEdited;

  ItemEditor(
      {Key key,
      @required this.onAdded,
      @required this.onEdited,
      this.originalItem});

  @override
  _ItemEditorState createState() => _ItemEditorState();
}

class _ItemEditorState extends State<ItemEditor> {
  String _name;
  double _amount;
  String _units;
  DateTime _entryDate;
  DateTime _expiryDate;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    if (widget.originalItem == null) {
      _name = '';
      _amount = 1.0;
      _units = 'uds.';
      _entryDate = DateTime.now();
      _expiryDate = DateTime.now().add(Duration(days: 30));
    } else {
      _name = widget.originalItem.name;
      _amount = widget.originalItem.amount;
      _units = widget.originalItem.units;
      _entryDate = widget.originalItem.entryDate;
      _expiryDate = widget.originalItem.expiryDate;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var outlineInputBorder = OutlineInputBorder(
      borderSide: BorderSide(color: Theme.of(context).accentColor, width: 2.0),
      borderRadius: BorderRadius.circular(15.0),
    );
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Wrap(
        children: <Widget>[
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    initialValue: _name,
                    validator: FormValidators.lengthValidator,
                    keyboardType: TextInputType.multiline,
                    style: Theme.of(context).textTheme.subtitle1,
                    decoration: InputDecoration(
                      labelText: "Nombre",
                      border: outlineInputBorder,
                    ),
                    onChanged: (value) => _name = value,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: TextFormField(
                          initialValue: widget.originalItem == null
                              ? ''
                              : _amount.toInt().toString(),
                          validator: _units == 'uds.'
                              ? FormValidators.intAmountValidator
                              : FormValidators.doubleAmountValidator,
                          keyboardType: TextInputType.number,
                          style: Theme.of(context).textTheme.subtitle1,
                          decoration: InputDecoration(
                            labelText: "Cantidad",
                            border: outlineInputBorder,
                          ),
                          onChanged: (value) => _amount = double.parse(value),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: DropdownButton<String>(
                          items: <String>['gr.', 'kg.', 'ltr.', 'uds.']
                              .map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                            );
                          }).toList(),
                          onChanged: (units) => setState(() => _units = units),
                          value: _units,
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: DateTimeField(
                            resetIcon: null,
                            format: DateFormat('dd/MM/yyyy'),
                            initialValue: _entryDate,
                            style: Theme.of(context).textTheme.subtitle1,
                            decoration: InputDecoration(
                              labelText: "Fecha de entrada",
                              border: outlineInputBorder,
                            ),
                            onShowPicker: (context, currentValue) =>
                                showDatePicker(
                                    context: context,
                                    initialDate: currentValue,
                                    firstDate: DateTime.now()
                                        .subtract(Duration(days: 30)),
                                    lastDate: DateTime.now()),
                            onChanged: (date) => _entryDate = date),
                      ),
                      Container(width: 20.0),
                      Expanded(
                        child: DateTimeField(
                            resetIcon: null,
                            format: DateFormat('dd/MM/yyyy'),
                            style: Theme.of(context).textTheme.subtitle1,
                            initialValue: _expiryDate,
                            decoration: InputDecoration(
                              labelText: "Fecha de caducidad",
                              border: outlineInputBorder,
                            ),
                            onShowPicker: (context, currentValue) =>
                                showDatePicker(
                                    context: context,
                                    initialDate: currentValue,
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime.now()
                                        .add(Duration(days: 365 * 2))),
                            onChanged: (date) => _expiryDate = date),
                      )
                    ],
                  ),
                )
              ]),
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: SaveButton(onSave: () {
                if (_formKey.currentState.validate()) {
                  if (widget.originalItem == null) {
                    widget.onAdded(
                      _name,
                      _amount,
                      _units,
                      _entryDate,
                      _expiryDate,
                    );
                  } else {
                    widget.onEdited(
                      widget.originalItem.id,
                      widget.originalItem.compartmentId,
                      _name,
                      _amount,
                      _units,
                      _entryDate,
                      _expiryDate,
                    );
                  }
                  Navigator.of(context).pop();
                }
              }))
        ],
      ),
    );
  }
}
