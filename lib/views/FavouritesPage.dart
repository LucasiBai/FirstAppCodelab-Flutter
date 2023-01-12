import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../global_state.dart';

class FavouritesPage extends StatelessWidget {
  const FavouritesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MyAppState appState = context.watch<MyAppState>();

    Set<WordPair> likedList = appState.likedList;
    int totalLikes = likedList.length;

    if (likedList.isEmpty) {
      return Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.all(20),
        child: Text("No liked words yet"),
      );
    }

    return ListView(
      children: [
        Container(
            padding: EdgeInsets.all(20),
            child: Text("You have $totalLikes favourites:")),
        ..._getLikedWords(likedList)
      ],
    );
  }

  List<ListTile> _getLikedWords(Set<WordPair> list) {
    List<ListTile> likedListWidgets = [];

    for (var item in list) {
      likedListWidgets.add(ListTile(
        leading: Icon(Icons.favorite),
        title: Text(item.asLowerCase),
      ));
    }

    return likedListWidgets;
  }
}
