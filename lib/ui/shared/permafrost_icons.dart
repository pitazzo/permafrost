import 'package:flutter/widgets.dart';

class PermafrostIcon {
  PermafrostIcon._();

  static const _kFontFam = 'PermafrostIcon';

  static const IconData snack = IconData(0xe800, fontFamily: _kFontFam);
  static const IconData shrimp = IconData(0xe802, fontFamily: _kFontFam);
  static const IconData cheese = IconData(0xe803, fontFamily: _kFontFam);
  static const IconData drinks = IconData(0xe804, fontFamily: _kFontFam);
  static const IconData ice = IconData(0xe805, fontFamily: _kFontFam);
  static const IconData tuppers = IconData(0xe806, fontFamily: _kFontFam);
  static const IconData fish = IconData(0xe807, fontFamily: _kFontFam);
  static const IconData misc = IconData(0xe808, fontFamily: _kFontFam);
  static const IconData greens = IconData(0xe809, fontFamily: _kFontFam);
  static const IconData meat = IconData(0xe80a, fontFamily: _kFontFam);
  static const IconData bread = IconData(0xe80b, fontFamily: _kFontFam);
  static const IconData fruits = IconData(0xe80c, fontFamily: _kFontFam);
  static const IconData icecream = IconData(0xe80d, fontFamily: _kFontFam);

  static const Map<String, IconData> IconsMap = <String, IconData>{
    'snack': snack,
    'shrimp': shrimp,
    'cheese': cheese,
    'drinks': drinks,
    'ice': ice,
    'tuppers': tuppers,
    'fish': fish,
    'misc': misc,
    'greens': greens,
    'meat': meat,
    'bread': bread,
    'fruits': fruits,
    'icecream': icecream,
  };
}
