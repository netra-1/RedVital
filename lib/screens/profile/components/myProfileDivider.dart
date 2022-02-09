import 'package:flutter/material.dart';

class MyProfileDivider{
  static ThemeData theme(BuildContext context) => ThemeData(
      dividerTheme: DividerThemeData(
        color: Colors.black,
        space: 1.4,
        indent: 0,
        endIndent: 0,
        thickness: 0.3,

      )
  );
}