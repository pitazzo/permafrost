import 'package:flutter/material.dart';
import 'package:permafrost/core/redux/connectors/username_selector.dart';

class CreateUserView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: ListView(
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.only(top: 35.0),
                child: Align(
                    alignment: Alignment.centerRight,
                    child: Icon(Icons.ac_unit,
                        size: 150,
                        color: Theme.of(context).primaryColorLight))),
            RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                      text: '¡Hola!\n',
                      style: Theme.of(context).textTheme.headline1),
                  TextSpan(
                      text:
                          """Estás a un paso de empezar a gestionar tu congelador de forma inteligente para reducir los desperdicios. ¿Cómo te llamas?\n""",
                      style: Theme.of(context).textTheme.bodyText2),
                ],
              ),
            ),
            UsernameSelectorConnector()
          ],
        ),
      ),
    );
  }
}
