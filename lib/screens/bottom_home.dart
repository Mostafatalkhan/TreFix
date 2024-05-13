import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:treflix/screens/movie_home.dart';
import 'package:treflix/screens/person.dart';
import 'package:treflix/screens/series_home.dart';

class NavigatorHome extends StatefulWidget {
  const NavigatorHome({super.key});

  @override
  State<NavigatorHome> createState() => _NavigatorHomeState();
}

class _NavigatorHomeState extends State<NavigatorHome> {
  int _selectedIndex = 1;
  List<Widget> bodyList = [Home(), Series_home(), PersonView()];
  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: bodyList[_selectedIndex],
        bottomNavigationBar: CurvedNavigationBar(
            index: 1,
            animationDuration: Duration(milliseconds: 300),
            height: 55,
            onTap: _onItemTapped,
            // height: 60,
            backgroundColor: Colors.transparent,
            color: const Color.fromARGB(255, 166, 59, 59),
            // color: Colors.black45,
            items: const [
              CurvedNavigationBarItem(
                child: Icon(
                  Icons.movie_creation_outlined,
                ),
                // label: 'Movies',
              ),
              CurvedNavigationBarItem(
                child: Icon(Icons.live_tv_rounded),
                // label: 'Series',
              ),
              CurvedNavigationBarItem(
                child: Icon(
                  Icons.person_outline_outlined,
                ),
                // label: 'Actor',
              ),
            ]

            // currentIndex: _selectedIndex,
            // onTap: _onItemTapped,
            ));
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
