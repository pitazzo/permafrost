import 'dart:math' as math;
import 'package:flutter/material.dart';

class PermafrostProgressIndicator extends StatefulWidget {

  final double size;

  PermafrostProgressIndicator({this.size = 100});

  _PermafrostProgressIndicatorState createState() =>
      _PermafrostProgressIndicatorState();
}

class _PermafrostProgressIndicatorState
    extends State<PermafrostProgressIndicator>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _rotator;

  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    _rotator = Tween(begin: math.pi * 2, end: 0.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.ease),
    )..addListener(() {
        setState(() {});
      });
    _controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
        angle: _rotator.value,
        child: Icon(
          Icons.ac_unit,
          size: widget.size,
          color: Theme.of(context).primaryColor,
        ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
