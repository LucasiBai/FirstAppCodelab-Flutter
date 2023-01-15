import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../_widgets/PairCard.dart';
import '../global_state.dart';

class GeneratorPage extends StatelessWidget {
  const GeneratorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MyAppState appState = context.watch<MyAppState>();

    final wordPair = appState.current;

    bool isLiked = appState.isLiked(wordPair);
    print(isLiked);

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
              flex: 3,
              child: HistoryList()),
          Expanded(
              flex: 5,
              child:
          Column(children: [
            PairCard(wordPair: wordPair),
            SizedBox(
              height: 20,
            ),
            _interactiveButtons(appState, isLiked)
          ],))
        ],
      ),
    );
  }

  Row _interactiveButtons(MyAppState appState, bool isLiked) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ElevatedButton.icon(
            onPressed: () {
              appState.handleLike(appState.current);
            },
            icon: Icon(isLiked ? Icons.favorite : Icons.favorite_border),
            label: Text("Like")),
        SizedBox(
          width: 15,
        ),
        ElevatedButton(onPressed: appState.getNext, child: Text("Next")),
      ],
    );
  }
}

class HistoryList extends StatelessWidget {
  const HistoryList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MyAppState appState = context.watch<MyAppState>();

    final Function(WordPair wordPair) handleLike = appState.handleLike;

    return OverflowBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          for (final word in appState.historyList)
            WordButton(
                key: UniqueKey(),
                wordPair: word,
                onTap: (){
                  handleLike(word);
                },
                inFav: appState.isLiked(word))
        ],
      ),
    );
  }
}

class WordButton extends StatelessWidget {
  WordButton(
      {Key? key,
      required this.wordPair,
      required this.onTap,
      required this.inFav})
      : super(key: key);

  WordPair wordPair;
  Function() onTap;
  bool inFav;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
        onPressed: onTap,
        icon: inFav ? Icon(Icons.favorite, size: 15,) : SizedBox(),
        label: Text(wordPair.asLowerCase));
  }
}
