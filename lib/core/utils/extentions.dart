import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:appbase/core/utils/Utils.dart';

extension Photo on String {
  String png([String? path = "images"]) => 'assets/$path/$this.png';
  String svg([String path = "icons"]) => 'assets/$path/$this.svg';
  String jpeg([String path = "icons"]) => 'assets/$path/$this.jpg';
}

extension Dates on String {
  String formattedDate([String format = "d - M - y"]) {
    if (isNotEmpty) {
      DateTime date = DateTime.parse(this);
      return DateFormat(format, "ar").format(date);
    }

    return "";
  }
}

extension Times on String {
  String get to24h {
    // should be en_us to send
    final parse = DateFormat("hh:mm a", Utils.local).parse(this);
    return DateFormat("HH:mm", "en_us").format(parse);
  }
}

// context extentions

extension ContextExtensions on BuildContext {
  // size
  double get height => MediaQuery.of(this).size.height;
  double get width => MediaQuery.of(this).size.width;

  // theme
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => Theme.of(this).textTheme;
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  bool get isDark => Theme.of(this).brightness == Brightness.dark;
  bool get isLight => Theme.of(this).brightness == Brightness.light;
}

// WIDGET EXTENTIONS

extension WidgetExtensions on Widget {
  //to sliver
  Widget get toSliver => SliverToBoxAdapter(child: this);
}

// Get name file from link
extension NameFromUrl on String {
  String nameFromUrl() {
    int index = lastIndexOf("/") + 1;
    return replaceRange(0, index, "") /* .replaceAll(".pdf", "") */;
  }
}
