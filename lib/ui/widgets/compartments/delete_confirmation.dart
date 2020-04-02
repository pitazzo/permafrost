import 'package:flutter/material.dart';

class CompartmentDeleteConfirmation extends StatelessWidget {
  final Function onDelete;

  CompartmentDeleteConfirmation({@required this.onDelete});

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
                '¿Estás seguro?',
                style: Theme.of(context)
                    .textTheme
                    .headline3
                    .copyWith(color: Theme.of(context).accentColor),
              ),
              Text(
                'Si borras este cajón, todos los elementos que contiene serán también eliminados sin posibilidad de recuperarlos',
                style: Theme.of(context).textTheme.bodyText2,
              ),
              Divider(),
              Row(
                children: <Widget>[
                  FlatButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.delete_forever,
                              color: Theme.of(context).accentColor),
                          Text(
                            '  CONFIRMAR',
                            style: Theme.of(context).textTheme.button.copyWith(
                                color: Theme.of(context).accentColor,
                                fontSize: 20),
                          ),
                        ],
                      ),
                      onPressed: () {
                        this.onDelete();
                        Navigator.of(context).pop();
                      }),
                  FlatButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.cancel, color: Colors.red),
                        Text(
                          '  CANCELAR',
                          style: Theme.of(context)
                              .textTheme
                              .button
                              .copyWith(color: Colors.red, fontSize: 20),
                        ),
                      ],
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  )
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
