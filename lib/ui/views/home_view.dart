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
                            color: Theme.of(context).primaryColorLight,
                            size: 30,
                          ),
                        ),
                        onTap: () => Scaffold.of(context).openDrawer()),
                  ),
                  Icon(Icons.ac_unit,
                      size: 150, color: Theme.of(context).primaryColorLight),
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
