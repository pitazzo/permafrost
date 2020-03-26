import 'package:flutter/material.dart';
import 'package:permafrost/core/redux/connectors/compartments_grid_connector.dart';
import 'package:permafrost/core/redux/connectors/drawer_connector.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 35.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Builder(
                    builder: (context) => GestureDetector(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Icon(
                            Icons.menu,
                            color: Colors.indigo[300],
                            size: 30,
                          ),
                        ),
                        onTap: () => Scaffold.of(context).openDrawer()),
                  ),
                  Icon(Icons.ac_unit, size: 150, color: Colors.indigo[200]),
                ],
              ),
            ),
            RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                      text: 'Hola, Eva\n',
                      style: TextStyle(
                          color: Colors.indigo,
                          fontSize: 50.0,
                          fontFamily: 'Baloo 2',
                          fontWeight: FontWeight.bold)),
                  TextSpan(
                      text: 'Esto es lo que hay en el congelador\n',
                      style: TextStyle(color: Colors.black54, fontSize: 20.0, fontFamily: 'Baloo 2',)),
                ],
              ),
            ),
            CompartmentsGridConnector()
          ],
        ),
      ),
      drawer: DrawerConnector(),
    );
  }
}
