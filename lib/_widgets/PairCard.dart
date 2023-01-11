import 'package:flutter/material.dart';

import 'package:english_words/english_words.dart';

class PairCard extends StatelessWidget {
  const PairCard({
    Key? key,
    required this.wordPair,
  }) : super(key: key);

  final WordPair wordPair;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final TextStyle textStyle = theme.textTheme.displayMedium!
        .copyWith(color: theme.colorScheme.onSecondary);

    return FittedBox(
      child: Card(
        color: theme.colorScheme.secondary,
        elevation: 30,
        shadowColor: Colors.black26,
        child: Container(
            padding: const EdgeInsets.all(20),
            child: Text(
              wordPair.asLowerCase,
              style: textStyle,
              semanticsLabel: wordPair.asPascalCase,
            )),
      ),
    );
  }
}
