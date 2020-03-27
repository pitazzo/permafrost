import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:permafrost/core/services/validators.dart';
import 'package:permafrost/ui/widgets/save_button.dart';

class ItemAdder extends StatefulWidget {
  final Function(String, double, String, DateTime, DateTime) onAdded;

  ItemAdder({Key key, @required this.onAdded});

  @override
  _ItemAdderState createState() => _ItemAdderState();
}

class _ItemAdderState extends State<ItemAdder> {
  String _name;
  double _amount;
  String _units;
  DateTime _entryDate;
  DateTime _expiryDate;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _units = 'uds.';
    _entryDate = DateTime.now();
    _expiryDate = DateTime.now().add(Duration(days: 30));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var outlineInputBorder = OutlineInputBorder(
      borderSide: BorderSide(color: Colors.indigo, width: 2.0),
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
                  widget.onAdded(
                      _name, _amount, _units, _entryDate, _expiryDate);
                  Navigator.of(context).pop();
                }
              }))
        ],
      ),
    );
  }
}
