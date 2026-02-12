import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:expense_tracker/expenses.dart';

var kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 6, 197, 108),
);

//fontFamily: GoogleFonts.spaceMono().fontFamily

void main() {
  runApp(
    MaterialApp(
      theme:
          ThemeData(
            fontFamily: 'SpaceMono',
            textTheme: TextTheme(
              titleLarge: TextStyle(
                fontWeight: FontWeight.bold,
                color: kColorScheme.onSecondaryContainer,
                fontSize: 16,
              ),
            ),
          ).copyWith(
            colorScheme: kColorScheme,
            appBarTheme: AppBarTheme().copyWith(
              backgroundColor: kColorScheme.onPrimaryContainer,
              foregroundColor: kColorScheme.primaryContainer,
            ),
            cardTheme: CardThemeData().copyWith(
              color: kColorScheme.secondaryContainer,
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: kColorScheme.primaryContainer,
              ),
            ),
          ),
      home: Expenses(),
    ),
  );
}
