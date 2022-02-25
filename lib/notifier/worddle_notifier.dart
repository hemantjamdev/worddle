import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

class WorddleNotifier extends ChangeNotifier {
  WorddleNotifier() {
    generateRandomWord();
  }

  TextEditingController wordController = TextEditingController();
  String word = "";
  List list = [];
  bool hint = false;
  List wordList = [];

  void changeHint(bool hintt) {
    hint = hintt;
    notifyListeners();
  }

  void wordToList(String text) {
    list = text.split("");
    int length = list.length;
    for (var i = 1; i <= (16 - length); i++) {
      list.add(" ");
    }
    listShuffle();
    notifyListeners();
  }

  void generateRandomWord() {
    word = WordPair.random(maxSyllables: 2).first.toUpperCase();
    wordToList(word);
    notifyListeners();
  }

  void listShuffle() {
    list.shuffle();
    notifyListeners();
  }

  void remove() {
    if (wordList.isNotEmpty) {
      wordList.removeLast();
    }
    notifyListeners();
  }

  void add(String text) {
    if (wordList.length < word.length) {
      wordList.add(text);
      notifyListeners();
    }
    notifyListeners();
  }

  void clearList() {
    wordList.clear();
    notifyListeners();
  }
}
