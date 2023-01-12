import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

class MyAppState extends ChangeNotifier {
  WordPair current = WordPair.random();

  final Set<WordPair> likedList = <WordPair>{};

  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }

  bool isLiked() {
    return likedList.contains(current);
  }

  void handleLike() {
    if (isLiked()) {
      likedList.remove(current);
    } else {
      likedList.add(current);
    }
    notifyListeners();
  }
}