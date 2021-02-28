import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rss_news/controllers/rss_controller.dart';

class Navigation extends StatelessWidget {
  const Navigation({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RssController>( // init only first time
      builder: (s) => BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Flux RSS',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Actualités',
          ),
        ],
        currentIndex: s.selectedIndex,
        onTap: (index) => s.onItemTapped(index),
      ),
    );
  }
}