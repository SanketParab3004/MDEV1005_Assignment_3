import 'package:flutter/material.dart';

class CurrencyConverterPage extends StatefulWidget {
  const CurrencyConverterPage({Key? key}) : super(key: key);

  @override
  _CurrencyConverterPageState createState() => _CurrencyConverterPageState();
}

class _CurrencyConverterPageState extends State<CurrencyConverterPage> {
  final TextEditingController _amountController = TextEditingController();
  String _fromCurrency = 'USD';
  String _toCurrency = 'EUR';
  double _convertedAmount = 0.0;

  final Map<String, double> conversionRates = {
    'USD': 1.0,
    'EUR': 0.85,
    'GBP': 0.73,
    'JPY': 110.0,
    'CAD': 1.25,
    // Add more currencies with their conversion rates
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Currency Converter', style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFF2A2A2A),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: 'Enter Amount',
                border: OutlineInputBorder(),
                labelStyle: TextStyle(color: Colors.white),
              ),
              style: TextStyle(color: Colors.white), // Set the text color to white
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildCurrencyDropdown('From', _fromCurrency, _updateFromCurrency),
                _buildCurrencyDropdown('To', _toCurrency, _updateToCurrency),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _convertCurrency,
              child: const Text('Convert', style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                primary: Color(0xFF2A2A2A),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Converted Amount: $_convertedAmount $_toCurrency',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrencyDropdown(String label, String value, Function(String?) onChanged) {
    return DropdownButton<String>(
      value: value,
      onChanged: onChanged,
      items: conversionRates.keys.map<DropdownMenuItem<String>>((String currency) {
        return DropdownMenuItem<String>(
          value: currency,
          child: Text(currency, style: TextStyle(color: Colors.white)),
        );
      }).toList(),
      hint: Text(label, style: TextStyle(color: Colors.white)),
      style: TextStyle(color: Colors.white),
      dropdownColor: Color(0xFF2A2A2A),
    );
  }

  void _updateFromCurrency(String? value) {
    if (value != null) {
      setState(() {
        _fromCurrency = value;
      });
    }
  }

  void _updateToCurrency(String? value) {
    if (value != null) {
      setState(() {
        _toCurrency = value;
      });
    }
  }

  void _convertCurrency() {
    final amount = double.tryParse(_amountController.text) ?? 0.0;

    if (amount <= 0) {
      // Show an error message or handle invalid input
      return;
    }

    final conversionRate = conversionRates[_toCurrency]! / conversionRates[_fromCurrency]!;
    setState(() {
      _convertedAmount = amount * conversionRate;
    });
  }
}
