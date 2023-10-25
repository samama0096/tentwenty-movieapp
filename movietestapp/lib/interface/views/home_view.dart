import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'package:movietestapp/interface/utils/themes/app_theme.dart';
import 'package:movietestapp/interface/views/home_view_tabs/watch_view.dart';

import 'home_view_tabs/placeholder_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<Widget> tabs = [
    //Placeholder for dummy screens
    const PlaceHolder(),
    WatchView(),
    const PlaceHolder(),
    const PlaceHolder(),
  ];
  int _current = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[_current],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            color: darkPurple,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        child: GNav(
            selectedIndex: 1,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            onTabChange: (i) {
              setState(() {
                _current = i;
              });
            },
            activeColor: Colors.white,
            color: Colors.white54,
            tabs: const [
              GButton(icon: Icons.dashboard),
              GButton(icon: Icons.ondemand_video_rounded),
              GButton(icon: Icons.library_books_rounded),
              GButton(icon: Icons.list_rounded),
            ]),
      ),
    );
  }
}
