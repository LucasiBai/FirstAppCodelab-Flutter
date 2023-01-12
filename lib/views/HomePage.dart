
import 'package:flutter/material.dart';

import 'FavouritesPage.dart';
import 'GeneratorPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentPageIdx = 0;

  @override
  Widget build(BuildContext context) {
    List pages = [
      GeneratorPage(),
      FavouritesPage(),
    ];

    Widget currentPage;

    try {
      currentPage = pages[_currentPageIdx];
    } catch (error) {
      throw UnimplementedError(
          "No Widget in $_currentPageIdx index in 'pages'");
    }

    return Scaffold(
        body: Row(
          children: [
            SafeArea(
                child: NavigationRail(
                  minWidth: 70,
                  extended: MediaQuery.of(context).size.width > 600,
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


