import 'package:flutter/material.dart';

class NewCompartmentBox extends StatelessWidget {
  const NewCompartmentBox({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(4.0),
        child: InkWell(
          onTap: () => Navigator.of(context).pushNamed('newCompartment'),
          child: Card(
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Center(
                child: Icon(
                  Icons.add,
                  size: 80,
                  color: Colors.indigo,
                ),
              )),
        ));
  }
}
