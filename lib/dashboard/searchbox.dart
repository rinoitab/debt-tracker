import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flappy_search_bar/search_bar_style.dart';
import 'package:flutter/material.dart';

Widget searchBox() {
  return Container(
    height: 80.0,
    width: double.maxFinite,
    child: SearchBar(
      onSearch: null,
      onItemFound: null,
      searchBarPadding: EdgeInsets.symmetric(horizontal: 10.0),
      iconActiveColor: Colors.green[400],
      searchBarStyle: SearchBarStyle(
        borderRadius: BorderRadius.circular(30.0),
        padding: EdgeInsets.symmetric(horizontal: 20.0),
      ),
    ),
  );
}
