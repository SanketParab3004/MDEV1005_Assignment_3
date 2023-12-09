// HomePage.dart
import 'package:flutter/material.dart';
import 'todo_page.dart';
import 'ApiPage.dart';
import 'currency_converter_page.dart';
import 'the_hangman_game.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Image.asset(
            'assets/tenor.gif', // Replace with your image asset
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),

          // Dark Layer
          Container(
            color: Colors.black.withOpacity(0.5), // Dark layer with 50% opacity
            width: double.infinity,
            height: double.infinity,
          ),

          // Content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Welcome Message
                Text(
                  'Welcome to the Home Page!',
                  style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                ), // White text

                // Buttons to navigate to other pages
                SizedBox(height: 40),
                // Grid View for Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildNavigationButton(context, 'To-Do\nList', ToDoPage(), buttonSize: 80),
                    _buildNavigationButton(context, 'API', QuotesPage(), buttonSize: 80),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildNavigationButton(context, 'Convert\nCurrencies', CurrencyConverterPage(), buttonSize: 80),
                    _buildNavigationButton(
                      context,
                      'The\nHangman\nGame', // Split "The Hangman Game" into two lines
                      HangmanGameApp(),
                      buttonSize: 80,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationButton(BuildContext context, String buttonText, Widget page, {double buttonSize = 60}) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Text(
          buttonText,
          textAlign: TextAlign.center, // Center text in the button
          style: TextStyle(color: Colors.white, fontSize: 14),
        ),
      ), // White text
      style: ElevatedButton.styleFrom(
        primary: Colors.black, // Grey
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        minimumSize: Size(buttonSize, buttonSize),
        side: BorderSide(color: Colors.transparent), // Invisible grid lines
      ),
    );
  }
}
