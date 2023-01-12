import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../global_state.dart';

class FavouritesPage extends StatelessWidget {
  const FavouritesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MyAppState appState = context.watch<MyAppState>();

    final buttonColor = Theme.of(context).colorScheme.primary;

    removeItem(item) {
      appState.removeLikeOf(item);
    }

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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            padding: EdgeInsets.all(20),
            child: Text("You have $totalLikes favourites:")),
        Expanded(
          child: GridView(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 350,
              childAspectRatio: 4 / 1,
            ),
            children: _getLikedWords(likedList, buttonColor, removeItem),
          ),
        )
      ],
    );
  }

  List<ListTile> _getLikedWords(
      Set<WordPair> list, Color color, Function(WordPair item) onTap) {
    List<ListTile> likedListWidgets = [];

    for (var item in list) {
      likedListWidgets.add(ListTile(
        key: UniqueKey(),
          leading: IconButton(
              icon: Icon(
                Icons.delete,
                semanticLabel: "Delete",
              ),
              onPressed: () {
                onTap(item);
              },
              color: color),
          title: Text(
            item.asLowerCase,
            semanticsLabel: item.asPascalCase,
          )));
    }

    return likedListWidgets;
  }
}
