import 'package:flutter/material.dart';
import 'package:permafrost/core/models/fridge/compartment.dart';
import 'package:permafrost/ui/widgets/compartments/compartment_box.dart';
import 'package:permafrost/ui/widgets/misc/new_compartment_box.dart';

class CompartmentsGrid extends StatelessWidget {
  final String username;
  final List<Compartment> compartments;
  final Map<int, int> itemsPerCompartment;
  final Function onDelete;

  const CompartmentsGrid(
      {Key key,
      @required this.username,
      @required this.compartments,
      @required this.itemsPerCompartment,
      @required this.onDelete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: <Widget>[
          RichText(
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                    text: 'Hola, ' + username +'\n',
                    style: Theme.of(context).textTheme.headline1),
                TextSpan(
                    text: 'Esto es lo que hay en el congelador\n',
                    style: Theme.of(context).textTheme.bodyText2),
              ],
            ),
          ),
          Expanded(
              child: GridView.count(
                  crossAxisCount: 2,
                  children: List.generate(compartments.length + 1, (index) {
                    if (index == compartments.length) {
                      return NewCompartmentBox();
                    }
                    return Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: CompartmentBox(
                          items: itemsPerCompartment[compartments[index].id],
                          compartment: compartments[index],
                          onDelete: onDelete,
                        ));
                  }))),
        ],
      ),
    );
  }
}
