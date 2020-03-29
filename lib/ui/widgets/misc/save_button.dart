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
            Icon(Icons.check_circle_outline,
                color: Theme.of(context).accentColor),
            Text(
              '  GUARDAR',
              style: Theme.of(context)
                  .textTheme
                  .button
                  .copyWith(color: Theme.of(context).accentColor, fontSize: 20),
            ),
          ],
        ),
        onPressed: onSave);
  }
}
