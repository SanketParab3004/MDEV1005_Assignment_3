// main.dart
import 'package:flutter/material.dart';
import 'HomePage.dart';
import 'todo_page.dart';
import 'ApiPage.dart';
import 'currency_converter_page.dart';
import 'the_hangman_game.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Assignment-3-Flutter',
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/calculator': (context) => ToDoPage(),
        '/api': (context) => QuotesPage(),
        '/notes': (context) => CurrencyConverterPage(),
        '/TicTacToe': (context) => HangmanGameApp(),
      },
    );
  }
}
