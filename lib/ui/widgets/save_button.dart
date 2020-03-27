import 'package:flutter/material.dart';

class SaveButton extends StatelessWidget {
  final Function onSave;

  SaveButton({@required this.onSave});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.check_circle_outline, color: Colors.indigo),
            Text(
              '  GUARDAR',
              style: Theme.of(context)
                  .textTheme
                  .button
                  .copyWith(color: Colors.indigo, fontSize: 20),
            ),
          ],
        ),
        onPressed: onSave);
  }
}
