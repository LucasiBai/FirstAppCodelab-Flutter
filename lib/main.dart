import 'package:flutter/material.dart';

import 'package:english_words/english_words.dart';
import 'package:provider/provider.dart';

import '_widgets/PairCard.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: "Namer App",
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Color(0x93A8C2E1)),
        ),
        home: HomePage(),
      ),
    );
  }
}

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

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentPageIdx = 0;

  @override
  Widget build(BuildContext context) {
    List pages = [GeneratorPage(), Placeholder()];

    Widget currentPage = pages[_currentPageIdx];

    return Scaffold(
        body: Row(
      children: [
        SafeArea(
            child: NavigationRail(
          extended: false,
          destinations: [
            NavigationRailDestination(
                icon: Icon(Icons.home), label: Text("Home")),
            NavigationRailDestination(
                icon: Icon(Icons.favorite), label: Text("Favourites")),
          ],
          selectedIndex: _currentPageIdx,
          onDestinationSelected: (selectedId) {
            setState(() {
              _currentPageIdx = selectedId;
            });
          },
        )),
        Expanded(
            child: Container(
          color: Theme.of(context).colorScheme.primaryContainer,
          child: currentPage,
        ))
      ],
    ));
  }
}

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
