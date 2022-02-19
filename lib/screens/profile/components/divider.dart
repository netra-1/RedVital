import 'package:flutter/material.dart';

class BasicTheme{
  static ThemeData theme(BuildContext context) => ThemeData(
    dividerTheme: DividerThemeData(
      color: Colors.black87,
      space: 0.48,
      indent: 10,
      endIndent: 10,
      thickness: 0.2,

    )
  );
}

class MyProfileDivider{
  static ThemeData theme(BuildContext context) => ThemeData(
      dividerTheme: DividerThemeData(
        color: Colors.black,
        space: 01.1,
        indent: 0,
        endIndent: 0,
        thickness: 0.3,

      )
  );
}