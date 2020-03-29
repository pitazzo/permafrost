import 'package:flutter/material.dart';

class PermafrostDrawer extends StatelessWidget {
  final String selectedMenu;
  final Function(String) onMenuSelected;

  PermafrostDrawer(
      {@required this.selectedMenu, @required this.onMenuSelected});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(
      children: <Widget>[
        Expanded(
          child: Padding(
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
              child: Column(
                children: <Widget>[
                  Container(height: 10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () => Navigator.of(context).pop()),
                  ),
                  Container(height: 20),
                  ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Text('E',
                          style: Theme.of(context)
                              .textTheme
                              .headline2
                              .copyWith(color: Colors.white)),
                    ),
                    title: Text('Eva',
                        style: Theme.of(context).textTheme.headline3),
                  ),
                  Expanded(
                    child: ListView(
                      children: <Widget>[
                        _buildTile(context, "/", "Cajones", Icons.border_all,
                            selectedMenu),
                        _buildTile(context, "items", "Elementos", Icons.list,
                            selectedMenu),
                        _buildTile(context, "settings", "Ajustes",
                            Icons.settings, selectedMenu)
                      ],
                    ),
                  ),
                ],
              )),
        ),
        Divider(),
        Container(
          height: 100,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: ListTile(
              leading: Icon(Icons.ac_unit,
                  color: Theme.of(context).primaryColorLight, size: 40),
              title: Text('Permafrost v. 0.1',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      .copyWith(color: Colors.black)),
              subtitle: Text('por pedromalo.dev',
                  style: Theme.of(context).textTheme.subtitle1),
            ),
          ),
        )
      ],
    ));
  }

  Widget _buildTile(BuildContext context, String id, String name,
      IconData iconData, String selectedTile) {
    return GestureDetector(
        onTap: () => onMenuSelected(id),
        child: id == selectedTile
            ? Container(
                decoration: BoxDecoration(
                    color: Colors.indigo[100],
                    borderRadius: BorderRadius.circular(30.0)),
                child: ListTile(
                  leading: Icon(
                    iconData,
                    color: Theme.of(context).accentColor,
                  ),
                  title: Text(
                    name,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
              )
            : ListTile(
                leading: Icon(
                  iconData,
                  color: Colors.grey,
                ),
                title: Text(
                  name,
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(color: Colors.black),
                ),
              ));
  }
}
