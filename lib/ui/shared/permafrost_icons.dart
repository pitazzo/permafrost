import 'package:flutter/widgets.dart';

class PermafrostIcon {
  PermafrostIcon._();

  static const _kFontFam = 'PermafrostIcon';

  static const IconData snack = const IconData(0xe800, fontFamily: _kFontFam);
  static const IconData freezer = const IconData(0xe801, fontFamily: _kFontFam);
  static const IconData shrimp = const IconData(0xe802, fontFamily: _kFontFam);
  static const IconData cheese = const IconData(0xe803, fontFamily: _kFontFam);
  static const IconData drinks = const IconData(0xe804, fontFamily: _kFontFam);
  static const IconData ice = const IconData(0xe805, fontFamily: _kFontFam);
  static const IconData tuppers = const IconData(0xe806, fontFamily: _kFontFam);
  static const IconData fish = const IconData(0xe807, fontFamily: _kFontFam);
  static const IconData misc = const IconData(0xe808, fontFamily: _kFontFam);
  static const IconData greens = const IconData(0xe809, fontFamily: _kFontFam);
  static const IconData meat = const IconData(0xe80a, fontFamily: _kFontFam);
  static const IconData bread = const IconData(0xe80b, fontFamily: _kFontFam);
  static const IconData fruits = const IconData(0xe80c, fontFamily: _kFontFam);
  static const IconData icecream = const IconData(0xe80d, fontFamily: _kFontFam);
  static const IconData fridge = const IconData(0xe80e, fontFamily: _kFontFam);

  static const Map<String, IconData> IconsMap = <String, IconData>{
    'snack' : snack,
    'freezer' : freezer,
    'shrimp' : shrimp,
    'cheese' : cheese,
    'drinks' : drinks,
    'ice' : ice,
    'tuppers' : tuppers,
    'fish' : fish,
    'misc' : misc,
    'greens' : greens,
    'meat' : meat,
    'bread' : bread,
    'fruits' : fruits,
    'icecream' : icecream,
    'fridge' : fridge
  };
}
