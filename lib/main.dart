import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const RandomPasswordGenerator());
}

class RandomPasswordGenerator extends StatelessWidget {
  const RandomPasswordGenerator({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Random Password Generator By Kuthgitris',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: PassGen(),
    );
  }
}

class PassGen extends StatefulWidget {
  @override
  _PassGenState createState() => _PassGenState();
}

class _PassGenState extends State<PassGen> {
  String _password = '';
  String _link = '';
  bool _isUpperCaseSelected = true;
  bool _isTrUpperCaseAddonSelected = false;
  bool _isTrLowerCaseAddonSelected = false;
  bool _isLowerCaseSelected = true;
  bool _isNumbersSelected = true;
  bool _isPunctuationSelected = true;
  bool _isQuotationMarksSelected = true;
  bool _isDashesAndSlashesSelected = true;
  bool _isLogogramsSelected = false;
  bool _isMathSymbolsSelected = true;
  bool _isBracketsSelected = false;
  final Map<String, String> _passwords = {};

// katar listesi
  final _random = Random.secure();
  final String _upperCaseCharacters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  final String _trUpperCaseAddon = 'ÇĞÜÖİ';
  final String _lowerCaseCharacters = 'abcdefghijklmnopqrstuvwxyz';
  final String _trLowerCaseAddon = 'çğüöı';
  final String _numbers = '0123456789';
  final String _punctuation = '.,:;';
  final String _quotationMarks = '"\'';
  final String _dashesAndSlashes = '\\/|_-';
  final String _logograms = '#\$%&@^`~';
  final String _mathSymbols = '<>*+!?=';
  final String _brackets = '{[()]}';
  String _customCharacterList = '';
  String _blacklist = '';


  void _generatePassword(int length,) {
    String chars = '';
    if (_isUpperCaseSelected) chars += _upperCaseCharacters;
    if (_isTrUpperCaseAddonSelected) chars += _trUpperCaseAddon;
    if (_isLowerCaseSelected) chars += _lowerCaseCharacters;
    if (_isTrLowerCaseAddonSelected) chars += _trLowerCaseAddon;
    if (_isNumbersSelected) chars += _numbers;
    if (_isPunctuationSelected) chars += _punctuation;
    if (_isQuotationMarksSelected) chars += _quotationMarks;
    if (_isDashesAndSlashesSelected) chars += _dashesAndSlashes;
    if (_isLogogramsSelected) chars += _logograms;
    if (_isMathSymbolsSelected) chars += _mathSymbols;
    if (_isBracketsSelected) chars += _brackets;

    // Özel karakter listesiyse sadece ondan seç
    if (_customCharacterList != '') chars = _customCharacterList;
    // kara liste, burası için araştırma yapmam gerekti
    chars = chars.replaceAll(RegExp('[$_blacklist]'), '');

    String password = '';
    for (int i = 0; i < length; i++) {
      password += chars[_random.nextInt(chars.length)];
    }
    setState(() {
      _password = password;
    });
  }

  void _savePassword() {
    if (_password.isNotEmpty && _link.isNotEmpty) {
      setState(() {
        _passwords[_link] = _password;
        _password = '';
        _link = '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Random Password Generator By Kuthgitris'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Generated Password:',
              style: TextStyle(fontSize: 20.0),
            ),
            const SizedBox(height: 3.0),
            Text(
              _password,
              style: const TextStyle(
                  fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20.0),
            const Text('Password Length:'),

            Slider(
              label: _password.length.toString(),

              value: _password.length.toDouble(),
              min: 0,
              max: 50,
              divisions: 50,
              onChanged: (newValue) {
                _generatePassword(newValue.toInt());
              },
            ),
            TextField(
              decoration: const InputDecoration(
                  labelText: 'Custom Character List',
                  hintText: 'If you want tocreate a password from just these characters'
              ),
              onChanged: (value) {
                setState(() {
                  _customCharacterList = value;
                });
              },
            ),
            TextField(
              decoration: const InputDecoration(
                  labelText: 'Blacklist',
                  hintText: 'If you dont want certain characters to be used in the password'
              ),
              onChanged: (value) {
                setState(() {
                  _blacklist = value;
                });
              },
            ),
            const SizedBox(height: 5.0),
            Align(alignment: Alignment.centerLeft,
                child: Container(
                    alignment: Alignment.center,
                    width: 1600,
                    height: 150,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            verticalDirection: VerticalDirection.down,
                            textDirection: TextDirection.ltr,
                            children: <Widget>[
                              Expanded(flex: 4, child: CheckboxListTile(

                                title: const Text('Include Uppercase Letters'),

                                activeColor: Colors.deepPurple,
                                value: _isUpperCaseSelected,
                                onChanged: (newValue) {
                                  setState(() {
                                    _isUpperCaseSelected = newValue!;
                                  });
                                  _generatePassword(_password.length);
                                },
                              ),
                              ),
                              Expanded(flex: 5, child: CheckboxListTile(
                                title: const Text('Include Lowercase Letters'),
                                activeColor: Colors.deepPurple,
                                value: _isLowerCaseSelected,
                                onChanged: (newValue) {
                                  setState(() {
                                    _isLowerCaseSelected = newValue!;
                                  });
                                  _generatePassword(_password.length);
                                },
                              ),
                              ),
                              Expanded(flex: 5, child: CheckboxListTile(
                                title: const Text(
                                    'Include Turkish Uppercase Letters'),
                                activeColor: Colors.deepPurple,
                                value: _isTrUpperCaseAddonSelected,
                                onChanged: (newValue) {
                                  setState(() {
                                    _isTrUpperCaseAddonSelected = newValue!;
                                  });
                                  _generatePassword(_password.length);
                                },
                              ),
                              ),
                              Expanded(flex: 3, child: CheckboxListTile(
                                title: const Text(
                                    'Include Turkish Lowercase Letters'),
                                activeColor: Colors.deepPurple,
                                value: _isTrLowerCaseAddonSelected,
                                onChanged: (newValue) {
                                  setState(() {
                                    _isTrLowerCaseAddonSelected = newValue!;
                                  });
                                  _generatePassword(_password.length);
                                },
                              ),
                              ),
                              Expanded(flex: 3, child: CheckboxListTile(
                                title: const Text('Include Numbers'),
                                activeColor: Colors.deepPurple,
                                value: _isNumbersSelected,
                                onChanged: (newValue) {
                                  setState(() {
                                    _isNumbersSelected = newValue!;
                                  });
                                  _generatePassword(_password.length);
                                },
                              ),
                              )
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            verticalDirection: VerticalDirection.down,
                            textDirection: TextDirection.ltr,
                            children: <Widget>[
                              Expanded(flex: 3, child: CheckboxListTile(
                                title: const Text('Include Punctuation'),
                                activeColor: Colors.deepPurple,
                                value: _isPunctuationSelected,
                                onChanged: (newValue) {
                                  setState(() {
                                    _isPunctuationSelected = newValue!;
                                  });
                                  _generatePassword(_password.length);
                                },
                              ),
                              ),
                              Expanded(flex: 3, child: CheckboxListTile(
                                title: const Text('Include Dashes and Slashes'),
                                activeColor: Colors.deepPurple,
                                value: _isDashesAndSlashesSelected,
                                onChanged: (newValue) {
                                  setState(() {
                                    _isDashesAndSlashesSelected = newValue!;
                                  });
                                  _generatePassword(_password.length);
                                },
                              ),
                              ),
                              Expanded(flex: 3, child: CheckboxListTile(
                                title: const Text('Include Quotation Marks'),
                                activeColor: Colors.deepPurple,
                                value: _isQuotationMarksSelected,
                                onChanged: (newValue) {
                                  setState(() {
                                    _isQuotationMarksSelected = newValue!;
                                  });
                                  _generatePassword(_password.length);
                                },
                              ),
                              ),
                              Expanded(flex: 3, child: CheckboxListTile(
                                title: const Text('Include Math Symbols'),
                                activeColor: Colors.deepPurple,
                                value: _isMathSymbolsSelected,
                                onChanged: (newValue) {
                                  setState(() {
                                    _isMathSymbolsSelected = newValue!;
                                  });
                                  _generatePassword(_password.length);
                                },
                              ),
                              ),
                              Expanded(flex: 3, child: CheckboxListTile(
                                title: const Text('Include Logograms'),
                                activeColor: Colors.deepPurple,
                                value: _isLogogramsSelected,
                                onChanged: (newValue) {
                                  setState(() {
                                    _isLogogramsSelected = newValue!;
                                  });
                                  _generatePassword(_password.length);
                                },
                              ),
                              ), Expanded(flex: 2, child: CheckboxListTile(
                                title: const Text('Include Brackets'),
                                activeColor: Colors.deepPurple,
                                value: _isBracketsSelected,
                                onChanged: (newValue) {
                                  setState(() {
                                    _isBracketsSelected = newValue!;
                                  });
                                  _generatePassword(_password.length);
                                },
                              ),
                              ),
                            ],
                          ),

                        ])
                )
            ), SizedBox(height: 60, width: 400, child: TextField(
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                  labelText: 'Link',
                  hintText: 'Input the link you want to save this password to'
              ),
              onChanged: (value) {
                setState(() {
                  _link = value;
                });
              },
            ),),
            const SizedBox(height: 20,),
            ElevatedButton(
              onPressed: _savePassword,
              child: const Text('Save Password'),
            ),
            const SizedBox(height: 20.0),
            Expanded(child:Align(
                alignment: Alignment.center,
                child: Container(
                    width: 500, // Adjust the width as needed
                    padding: EdgeInsets.all(10.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: _passwords.entries
                            .map((entry) => ListTile(
                          title: Text(entry.key),
                          subtitle: Text(entry.value),
                          trailing: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              setState(() {
                                _passwords.remove(entry.key);
                              });
                            },
                          ),
                        ))
                            .toList(),
                      ),

                    )))
            )],


        ),

      ),
    );
  }
}