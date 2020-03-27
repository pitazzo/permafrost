import 'dart:async';

import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  final Function(String) setSearchText;

  SearchBar({@required this.setSearchText});

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  Timer _timer;
  TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: TextField(
            controller: _controller,
            keyboardType: TextInputType.multiline,
            style: Theme.of(context).textTheme.subtitle1,
            decoration: InputDecoration(
              hintText: 'Buscar',
            ),
            onChanged: (value) {
              _timer?.cancel();
              _timer = Timer(Duration(milliseconds: 500), () {
                widget.setSearchText(value);
              });
            },
          ),
        ),
        IconButton(
            icon: Icon(Icons.close, color: Theme.of(context).primaryColor),
            onPressed: () {
              _controller.clear();
              widget.setSearchText('');
            })
      ],
    );
  }
}
