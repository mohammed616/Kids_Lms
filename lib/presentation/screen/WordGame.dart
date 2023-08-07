import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/colors.dart';


class Pair<A, B> {
  final A first;
  final B second;
  const Pair(this.first, this.second,);
}

class WordGame extends StatefulWidget {

  final List<Pair<String, String>> imagesAndWords;

  WordGame({required this.imagesAndWords});

  @override
  _WordGameState createState() => _WordGameState();
}

class _WordGameState extends State<WordGame> {
  int _currentLevel = 0;
  int _score = 0;
  List<String?> _tempWord = [];
  List<String> _availableLetters = [];
  bool _isCorrectAnswer = false;

  void didChangeDependencies() {
    super.didChangeDependencies();
    _initializeGame();
  }

  void _initializeGame() {
    final currentImageAndWord = widget.imagesAndWords[_currentLevel];
    _tempWord = List.filled(currentImageAndWord.second.length, null);
    _availableLetters = currentImageAndWord.second.split('');
    _availableLetters.shuffle();
  }


  // void _checkAnswer() {
  //   final currentWord = widget.imagesAndWords[_currentLevel].second;
  //   final tempWord = _tempWord.join();
  //   if (currentWord == tempWord) {
  //     setState(() {
  //       _currentLevel++;
  //       _tempWord = List.filled(
  //         widget.imagesAndWords[_currentLevel].second.length,
  //         null,
  //       );
  //       _availableLetters = widget.imagesAndWords[_currentLevel].second.split('');
  //       _availableLetters.shuffle();
  //     });
  //     if (_currentLevel == widget.imagesAndWords.length) {
  //       _showWinDialog();
  //     }
  //   } else {
  //     _showErrorDialog();
  //   }
  // }
  void _checkAnswerAutomatically() {
    final currentWord = widget.imagesAndWords[_currentLevel].second;
    final tempWord = _tempWord.join();
    if (currentWord == tempWord) {
      setState(() {
        _isCorrectAnswer = true;
        _tempWord = List.filled(
          widget.imagesAndWords[_currentLevel + 1].second.length,
          null,
        );
        _availableLetters = widget.imagesAndWords[_currentLevel + 1].second.split('');
        _availableLetters.shuffle();
        _score++;
        if (_currentLevel == widget.imagesAndWords.length - 2) {
          _showWinDialog();
        } else {
          _currentLevel++;
        }
      });
    } else {
      setState(() {
        if (_tempWord.every((letter) => letter != null)) {
          _currentLevel++;
          if (_currentLevel >= widget.imagesAndWords.length - 1) {
            _currentLevel = widget.imagesAndWords.length - 1;
            _showWinDialog();
          } else {
            _tempWord = List.filled(
              widget.imagesAndWords[_currentLevel].second.length,
              null,
            );
            _availableLetters = widget.imagesAndWords[_currentLevel].second.split('');
            _availableLetters.shuffle();
          }
        }
      });
    }
  }

  void _showWinDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Congratulations!  ',style: GoogleFonts.quicksand(fontWeight: FontWeight.bold,color: MyAppColors.darkGreen),),
          content: Text(' You have completed all stages and your total points are :{ $_score } ' ,style: GoogleFonts.quicksand(fontWeight: FontWeight.bold,color: MyAppColors.green)),
          actions: <Widget>[
            ButtonBar(
                alignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                child: Text('Replay',style: GoogleFonts.quicksand(fontWeight: FontWeight.bold,color: MyAppColors.magenta)),
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {
                    _currentLevel = 0;
                    _score=0;
                    _tempWord = List.filled(
                      widget.imagesAndWords[_currentLevel].second.length,
                      null,
                    );
                    _availableLetters = widget.imagesAndWords[_currentLevel].second.split('');
                    _availableLetters.shuffle();
                  });
                },
              ),
                TextButton(
                  child: Text('Main ',style: GoogleFonts.quicksand(fontWeight: FontWeight.bold,color: MyAppColors.magenta)),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                ),
           ] ),

          ],
        );
      },
    );
  }


  @override
  void initState() {
    super.initState();
    final currentWord = widget.imagesAndWords[_currentLevel].second;
    final letters = currentWord.split('');
    letters.shuffle();
    _tempWord = List.filled(letters.length, null);
    _tempWord = List.filled(
      widget.imagesAndWords[_currentLevel].second.length,
      null,
    );
    _availableLetters = letters;
  }

  Widget _buildLetterContainer(String letter, int index) {
    return InkWell(
      onTap: () {
        setState(() {
          if (_tempWord.contains(letter)) {
            _tempWord[_tempWord.indexOf(letter)] = null;
            _availableLetters.add(letter);
          } else if (_tempWord.contains(null)) {
            _tempWord[_tempWord.indexOf(null)] = letter;
            _availableLetters.remove(letter);
          }
          _checkAnswerAutomatically();
        });
      },

      child: Container(
        width: 50,
        height: 50,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: MyAppColors.veryLightOrange,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Text(
          letter,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          textDirection: TextDirection.rtl,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyAppColors.purple,
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _tempWord = List.filled(
                      widget.imagesAndWords[_currentLevel].second.length,
                      null,
                    ).reversed.toList();
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: MyAppColors.purple.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: AspectRatio(
                      aspectRatio: 16/9,
                      child: Image.asset(
                        widget.imagesAndWords[_currentLevel].first,
                        fit: BoxFit.scaleDown,
                        colorBlendMode: BlendMode.srcOver,

                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        color: MyAppColors.magenta,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.8),
                            spreadRadius: 3,
                            blurRadius: 5,
                            offset: Offset(6,8),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: widget.imagesAndWords[_currentLevel]
                        .second
                        .split('')
                        .asMap()
                        .entries
                        .map((entry) =>
                        _buildLetterContainer(entry.value, entry.key))
                        .toList(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: _tempWord.reversed.toList().asMap().entries.map((entry) {
                      final letter = entry.value;
                      final index = entry.key;
                      return _buildLetterContainer(letter ?? '', index);
                    }).toList(),
                  ),
                  Positioned(
                    bottom: 8,
                    left: 40,
                    right: 10,
                    child: Container(
                      decoration: BoxDecoration(
                        color: MyAppColors.magenta,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                        // boxShadow: [
                        //   BoxShadow(
                        //     color: Colors.grey.withOpacity(0.5),
                        //     spreadRadius: 1,
                        //     blurRadius: 5,
                        //     offset: Offset(0, -3),
                        //   ),
                        // ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: GridView.count(
                          shrinkWrap: true,
                          crossAxisCount: 5,
                          crossAxisSpacing: 7,
                          children: _availableLetters
                              .map((letter) => _buildLetterContainer(letter, -1))
                              .toList(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            // ElevatedButton(
            //   onPressed: _isCorrectAnswer,
            //   child: Text('Check Answer'),
            // ),
          ],
        ),
      ),
    );
  }
}