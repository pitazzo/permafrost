import 'package:flutter/material.dart';
import 'package:permafrost/core/models/fridge/compartment.dart';
import 'package:permafrost/ui/shared/custom_colors.dart';
import 'package:permafrost/ui/widgets/compartments/compartment_icon.dart';

class CompartmentBox extends StatefulWidget {
  final Compartment compartment;
  final Function onDelete;
  final int items;
  const CompartmentBox({Key key, this.compartment, this.items, this.onDelete})
      : super(key: key);

  @override
  _CompartmentBoxState createState() => _CompartmentBoxState();
}

class _CompartmentBoxState extends State<CompartmentBox> {
  bool isShowingOptions = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 5.0,
      child: InkWell(
        onTap: () {
          if (!isShowingOptions) {
            Navigator.of(context).pushNamed('compartment',
                arguments: this.widget.compartment.id);
          }
        },
        onLongPress: () => setState(() => isShowingOptions = !isShowingOptions),
        child: isShowingOptions ? buildOptions() : buildIcon(),
      ),
    );
  }

  Column buildOptions() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        RaisedButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
          onPressed: () {
            Navigator.pushNamed(context, 'editCompartment',
                arguments: widget.compartment);
            setState(() => isShowingOptions = !isShowingOptions);
          },
          color: CustomColors.compartmentColors[widget.compartment.color],
          textColor: Colors.white,
          child: Text("Editar".toUpperCase(),
              style: Theme.of(context)
                  .textTheme
                  .button
                  .copyWith(color: Colors.white)),
        ),
        RaisedButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
          onPressed: () {
            setState(() => isShowingOptions = !isShowingOptions);
            widget.onDelete(widget.compartment.id);
          },
          color: CustomColors.compartmentColors[widget.compartment.color],
          textColor: Colors.white,
          child: Text("Eliminar".toUpperCase(),
              style: Theme.of(context)
                  .textTheme
                  .button
                  .copyWith(color: Colors.white)),
        ),
      ],
    );
  }

  Column buildIcon() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Hero(
          tag: 'hero-compartment-' + this.widget.compartment.id.toString(),
          child: CompartmentIcon(
            size: 60,
            icon: widget.compartment.icon,
            color: widget.compartment.color,
          ),
        ),
        Container(height: 10),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(
                  text: widget.compartment.name + '\n',
                  style: Theme.of(context).textTheme.headline6),
              TextSpan(
                  text: widget.items.toString() + ' elemento',
                  style: Theme.of(context).textTheme.subtitle1),
              widget.items == 1
                  ? TextSpan()
                  : TextSpan(
                      text: 's', style: Theme.of(context).textTheme.subtitle1)
            ],
          ),
        ),
      ],
    );
  }
}
