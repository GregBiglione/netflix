import 'dart:ui';

class Utils {
  static String convertLocale(Locale locale) {
    String localeString = locale.toString();

    if(localeString.contains("_")){

      return localeString.replaceAll("_", "-");
    }
    else {
      return localeString;
    }
  }
}