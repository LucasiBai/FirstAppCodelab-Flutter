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

class HistoryList extends StatefulWidget {
  const HistoryList({
    Key? key,
  }) : super(key: key);


  @override
  State<HistoryList> createState() => _HistoryListState();
}

class _HistoryListState extends State<HistoryList> {
  final _key = GlobalKey();

  static const Gradient _maskingGradient = LinearGradient(
    colors: [Colors.transparent, Colors.black],

    stops: [0.0, 0.5],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  @override
  Widget build(BuildContext context) {
    MyAppState appState = context.watch<MyAppState>();
    appState.historyListKey = _key;

    final historyList = appState.historyList;

    final Function(WordPair wordPair) handleLike = appState.handleLike;

    return ShaderMask(shaderCallback: (bounds)=> _maskingGradient.createShader(bounds),
    blendMode: BlendMode.dstIn,
    child: AnimatedList(
        initialItemCount: historyList.length,
        padding: EdgeInsets.only(top:  100),
        reverse: true,
        itemBuilder: (context, index, animation){

          final wordPair = historyList[index];

          return SizeTransition(sizeFactor: animation,
            child: Center(
              child: WordButton(
                  key: UniqueKey(),
                  wordPair: wordPair,
                  onTap: (){
                    handleLike(wordPair);
                  },
                  inFav: appState.isLiked(wordPair)),
            ),);
        }),);

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
