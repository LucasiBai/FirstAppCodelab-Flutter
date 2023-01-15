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

    Widget mainArea = ColoredBox(
      color: Theme.of(context).colorScheme.surfaceVariant,
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 200),
        child: currentPage,
      ),
    );

    return Scaffold(body: LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > 450) {
        return _getHorizontalHome(context, mainArea);
      }
      return _getVerticalHome(context, mainArea);
    }));
  }

  Widget _getVerticalHome(BuildContext context, currentPage) {
    return Column(
      children: [
        Expanded(
            child: Container(
          color: Theme.of(context).colorScheme.primaryContainer,
          child: currentPage,
        )),
        SafeArea(
            child: NavigationBar(
          destinations: [
            NavigationDestination(
              icon: Icon(Icons.home),
              label: "Home",
            ),
            NavigationDestination(
              icon: Icon(Icons.favorite),
              label: "Favourites",
            ),
          ],
          selectedIndex: _currentPageIdx,
          onDestinationSelected: (selectedId) {
            setState(() {
              _currentPageIdx = selectedId;
            });
          },
        )),
      ],
    );
  }

  Widget _getHorizontalHome(BuildContext context, currentPage) {
    return Row(
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
        )),
      ],
    );
  }
}
