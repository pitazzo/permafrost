import 'package:meta/meta.dart';
import 'package:flutter/material.dart';
import 'package:permafrost/core/models/compartment.dart';
import 'package:permafrost/core/services/validators.dart';
import 'package:permafrost/ui/shared/custom_colors.dart';
import 'package:permafrost/ui/shared/permafrost_icons.dart';
import 'package:permafrost/ui/widgets/compartment_icon.dart';

class CompartmentEditor extends StatefulWidget {
  final Compartment compartment;
  final bool isEditing;
  final Function(int, String, String, String) onSaved;

  CompartmentEditor(
      {Key key,
      this.compartment,
      @required this.isEditing,
      @required this.onSaved})
      : super(key: key);

  @override
  _CompartmentEditorState createState() => _CompartmentEditorState();
}

class _CompartmentEditorState extends State<CompartmentEditor> {
  int _id;
  String _name;
  String _color;
  String _icon;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _id = widget.compartment == null ? -1 : widget.compartment.id;
    _color = widget.isEditing ? widget.compartment.color : 'blue';
    _icon = widget.isEditing ? widget.compartment.icon : 'fish';
  }

  // padding horizontal 30 y grey[200]
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
        Widget>[
      Expanded(
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 35.0, right: 10),
                    child:
                        CompartmentIcon(size: 150, color: _color, icon: _icon),
                  )),
              Container(
                height: 20,
              ),
              TextFormField(
                validator: FormValidators.lengthValidator,
                initialValue: widget.isEditing ? widget.compartment.name : '',
                onSaved: (value) => _name = value,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(hintText: 'Nombre'),
                style: TextStyle(
                    color: Colors.indigo,
                    fontSize: 50.0,
                    fontWeight: FontWeight.bold),
              ),
              Container(
                height: 20,
              ),
              Container(
                height: 150,
                child: GridView.count(
                    scrollDirection: Axis.horizontal,
                    crossAxisCount: 2,
                    children: PermafrostIcon.IconsMap.keys.map((icon) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 0),
                        child: IconButton(
                            onPressed: () => setState(() => _icon = icon),
                            icon: Icon(
                              PermafrostIcon.IconsMap[icon],
                              color: icon == _icon
                                  ? CustomColors.compartmentColors[_color]
                                  : Colors.indigo,
                              size: 45,
                            )),
                      );
                    }).toList()),
              ),
              Divider(),
              Container(
                height: 100,
                child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: CustomColors.compartmentColors.keys.map((color) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: IconButton(
                            onPressed: () => setState(() => _color = color),
                            icon: Icon(
                              color == _color
                                  ? Icons.check_circle
                                  : Icons.brightness_1,
                              color: CustomColors.compartmentColors[color],
                              size: 40,
                            )),
                      );
                    }).toList()),
              ),
              Divider(),
            ],
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: FlatButton(
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
            if (_formKey.currentState.validate()) {
              _formKey.currentState.save();
              widget.onSaved(_id, _name, _color, _icon);
              Navigator.of(context).pop();
            }
          },
        ),
      )
    ]);
  }
}
