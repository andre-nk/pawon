part of "shared.dart";

class ColorModel{
  static Color kWhite = HexColor("F7F7F7");
  static Color kBlack = HexColor("000000");
  static Color kBorder = HexColor("E9E9EF");
  static Color kText = HexColor("B2B1B6");
  static Color majorText = HexColor("535358");
  static Color primaryRed = HexColor("DE7973");
  static Color disabledRed = HexColor("E69B96");
  static Color activeRed = HexColor("B14842");
  static Color kBlue = HexColor("1808E8");
  static Color kYellow = HexColor("FFC400");
  static Color kGreen = HexColor("55AC59"); 
  static Map<int, Color> color =
  {
    50:Color.fromRGBO(221,121,115, .1),
    100:Color.fromRGBO(221,121,115, .2),
    200:Color.fromRGBO(221,121,115, .3),
    300:Color.fromRGBO(221,121,115, .4),
    400:Color.fromRGBO(221,121,115, .5),
    500:Color.fromRGBO(221,121,115, .6),
    600:Color.fromRGBO(221,121,115, .7),
    700:Color.fromRGBO(221,121,115, .8),
    800:Color.fromRGBO(221,121,115, .9),
    900:Color.fromRGBO(221,121,115, 1),
  };
}