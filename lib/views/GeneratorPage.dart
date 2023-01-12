
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

    bool isLiked = appState.isLiked();

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          PairCard(wordPair: wordPair),
          SizedBox(
            height: 20,
          ),
          _interactiveButtons(appState, isLiked)
        ],
      ),
    );
  }

  Row _interactiveButtons(MyAppState appState, bool isLiked) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ElevatedButton.icon(
            onPressed: appState.handleLike,
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