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