import 'package:flutter/material.dart';

class EmptyList extends StatelessWidget {
  const EmptyList();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Column(
          children: <Widget>[
            Container(height: 40),
            Icon(Icons.ac_unit, size: 60, color: Theme.of(context).primaryColorLight),
            Container(height: 20),
            Text(
              'Aún no has añadido nada',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline2.copyWith(fontSize: 25),
            ),
          ],
        )),
    );
  }
}
