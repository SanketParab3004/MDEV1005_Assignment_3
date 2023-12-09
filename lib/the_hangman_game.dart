import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(HangmanGameApp());
}

class HangmanGameApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HangmanGame(),
    );
  }
}

class HangmanGame extends StatefulWidget {
  @override
  _HangmanGameState createState() => _HangmanGameState();
}

class _HangmanGameState extends State<HangmanGame> {
  late String targetWord;
  late List<String> displayWord;
  late List<String> incorrectGuesses;
  int remainingAttempts = 6;

  @override
  void initState() {
    super.initState();
    initializeGame();
  }

  void initializeGame() {
    // List of words for the game
    List<String> words = ['flutter', 'dart', 'hangman', 'mobile', 'developer'];

    // Select a random word from the list
    targetWord = words[Random().nextInt(words.length)];

    // Initialize displayWord with underscores
    displayWord = List.filled(targetWord.length, '_');

    // Randomly select two pre-written letters to reveal
    int preWrittenIndex1 = Random().nextInt(targetWord.length);
    int preWrittenIndex2 = (preWrittenIndex1 + Random().nextInt(targetWord.length - 1) + 1) % targetWord.length;
    displayWord[preWrittenIndex1] = targetWord[preWrittenIndex1];
    displayWord[preWrittenIndex2] = targetWord[preWrittenIndex2];

    // Initialize incorrectGuesses list
    incorrectGuesses = [];

    // Reset remaining attempts
    remainingAttempts = 6;
  }

  void makeGuess(String letter) {
    setState(() {
      if (targetWord.contains(letter)) {
        // Update displayWord with correctly guessed letter
        for (int i = 0; i < targetWord.length; i++) {
          if (targetWord[i] == letter) {
            displayWord[i] = letter;
          }
        }
      } else {
        // Incorrect guess
        incorrectGuesses.add(letter);

        // Decrease remaining attempts
        remainingAttempts--;

        // Check if the player has run out of attempts
        if (remainingAttempts == 0) {
          showGameOverDialog(false);
        }
      }

      // Check if the word has been completely guessed
      if (!displayWord.contains('_')) {
        showGameOverDialog(true);
      }
    });
  }

  void showGameOverDialog(bool playerWon) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(playerWon ? 'Congratulations! You Won!' : 'Game Over!'),
          content: Text(playerWon
              ? 'You guessed the word: $targetWord'
              : 'The word was: $targetWord'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HangmanGame()),
                );
              },
              child: Text('Play Again'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hangman Game', style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFF2A2A2A),
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Color(0xFF2A2A2A),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                displayWord.join(' '),
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Incorrect Guesses: ${incorrectGuesses.join(', ')}',
              style: TextStyle(fontSize: 18, color: Colors.red),
            ),
            SizedBox(height: 20),
            Text(
              'Remaining Attempts: $remainingAttempts',
              style: TextStyle(fontSize: 18, color: Colors.blue),
            ),
            SizedBox(height: 20),
            GridView.builder(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 6,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              itemCount: 26,
              itemBuilder: (context, index) {
                // Convert index to ASCII code and then to a character
                String letter = String.fromCharCode(index + 'A'.codeUnitAt(0));

                return ElevatedButton(
                  onPressed: () {
                    makeGuess(letter.toLowerCase());
                  },
                  child: Text(letter, style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF2A2A2A), // Background color of the button
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
