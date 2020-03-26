import 'package:flutter/material.dart';
import 'package:permafrost/core/redux/connectors/drawer_connector.dart';

class SettingsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Builder(
              builder: (context) => Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 50.0),
                      child: Icon(
                        Icons.menu,
                        color: Colors.indigo[300],
                        size: 30,
                      ),
                    ),
                    onTap: () => Scaffold.of(context).openDrawer()),
              ),
            ),
            Container(height: 20),
            Text(
              'Ajustes',
              style: TextStyle(
                  fontFamily: 'Baloo 2',
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo),
            ),
          ],
        ),
      ),
      drawer: DrawerConnector(),
    );
  }
}
