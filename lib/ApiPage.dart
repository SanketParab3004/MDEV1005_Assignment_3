import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class QuotesPage extends StatefulWidget {
  const QuotesPage({Key? key}) : super(key: key);

  @override
  _QuotesPageState createState() => _QuotesPageState();
}

class _QuotesPageState extends State<QuotesPage> {
  String _quote = '';
  String _author = '';
  String _natureImageUrl = '';
  bool _isLoading = false;
  Key _imageKey = UniqueKey(); // Use a unique key for the Image widget

  @override
  void initState() {
    super.initState();
    _fetchQuote();
    _fetchNatureImage();
  }

  Future<void> _fetchQuote() async {
    setState(() {
      _isLoading = true;
    });

    final response = await http.get(
      Uri.parse('https://api.quotable.io/random'),
    );

    setState(() {
      _isLoading = false;
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        _quote = data['content'];
        _author = data['author'];
      } else {
        // Handle error
        _quote = 'Error fetching quote';
        _author = '';
      }
    });
  }

  Future<void> _fetchNatureImage() async {
    final response = await http.get(
      Uri.parse('https://source.unsplash.com/featured/?nature'),
    );

    setState(() {
      if (response.statusCode == 200) {
        _natureImageUrl = response.request!.url.toString();
      } else {
        // Handle error
        _natureImageUrl = 'Error fetching image';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Random Quote', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Color(0xFF2A2A2A),
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: _isLoading
            ? CircularProgressIndicator()
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16.0),
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Color(0xFF2A2A2A),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                children: [
                  Text(
                    _quote,
                    style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  Text(
                    '- $_author',
                    style: TextStyle(fontStyle: FontStyle.italic, color: Colors.white),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            _natureImageUrl.isNotEmpty
                ? Image.network(
              _natureImageUrl,
              key: _imageKey, // Use the unique key here
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            )
                : Text('Error loading image'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _fetchQuote();
                _fetchNatureImage();
                _imageKey = UniqueKey(); // Assign a new key to trigger a refresh
              },
              child: const Text('Get Another Quote', style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                primary: Color(0xFF2A2A2A),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
