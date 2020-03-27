import 'package:flutter/material.dart';
import 'package:permafrost/ui/shared/custom_colors.dart';
import 'package:permafrost/ui/shared/permafrost_icons.dart';

class CompartmentIcon extends StatelessWidget {
  final double size;
  final String color;
  final String icon;
  const CompartmentIcon({Key key, this.size, this.color, this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          width: this.size,
          height: this.size,
        ),
        Positioned(
          right: 0.0,
          top: 0.0,
          child: Container(
            width: size - (0.125 * size),
            height: size - (0.125 * size),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: CustomColors.compartmentColors[color].withAlpha(70)),
          ),
        ),
        Positioned(
          bottom: 0.0,
          left: 0.0,
          child: Icon(PermafrostIcon.IconsMap[icon],
              color: CustomColors.compartmentColors[color].withAlpha(220),
              size: size - (0.25 * size)),
        ),
      ],
    );
  }
}
