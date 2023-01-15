import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

class MyAppState extends ChangeNotifier {
  WordPair current = WordPair.random();

  GlobalKey? historyListKey;

  final List<WordPair> historyList = <WordPair>[];
  final Set<WordPair> likedList = <WordPair>{};

  void getNext() {
    historyList.insert(0, current);

    var animatedList = historyListKey?.currentState as AnimatedListState?;
    animatedList?.insertItem(0);

    current = WordPair.random();
    notifyListeners();
  }

  bool isLiked(WordPair wordPair) {
      return likedList.contains(wordPair);
  }

  void handleLike(WordPair wordPair) {

    if (isLiked(wordPair)) {
      removeLikeOf(wordPair);
    } else {
      addLikeOf(wordPair);
    }
  }

  void addLikeOf(WordPair pair){
    likedList.add(pair);
    notifyListeners();
  }

  void removeLikeOf(WordPair pair){
    likedList.remove(pair);
    notifyListeners();
  }
}