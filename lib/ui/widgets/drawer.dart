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
                          style:
                              TextStyle(fontFamily: 'Baloo 2', fontSize: 40)),
                    ),
                    title: Text('Eva',
                        style: TextStyle(fontFamily: 'Baloo 2', fontSize: 30)),
                  ),
                  Expanded(
                    child: ListView(
                      children: <Widget>[
                        _buildTile(
                            "/", "Cajones", Icons.border_all, selectedMenu),
                        _buildTile(
                            "items", "Elementos", Icons.list, selectedMenu),
                        _buildTile(
                            "settings", "Ajustes", Icons.settings, selectedMenu)
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
                leading: Icon(Icons.ac_unit, color: Colors.indigo[300], size: 40),
                title: Text('Permafrost v. 0.1', style: TextStyle(fontFamily: 'Baloo 2')),
                subtitle: Text('por pedromalo.dev', style: TextStyle(fontFamily: 'Baloo 2')),
              ),  
            ),
        )
      ],
    ));
  }

  Widget _buildTile(
      String id, String name, IconData iconData, String selectedTile) {
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
                    color: Colors.indigo,
                  ),
                  title: Text(
                    name,
                    style: TextStyle(
                        color: Colors.indigo,
                        fontFamily: 'Baloo 2',
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
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
                  style: TextStyle(
                      fontFamily: 'Baloo 2',
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ));
  }
}
