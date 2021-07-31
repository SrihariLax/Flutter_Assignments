import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  BottomBar(
      {Key? key, required this.onHomePress, required this.onSettingsPress})
      : super(key: key);

  final Function() onHomePress;

  final Function() onSettingsPress;

  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff2FC4B2),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.08,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(
                Icons.menu_book,
                color: Colors.white,
                size: 24.0,
                semanticLabel: 'Track Screen',
              ),
              onPressed: null,
            ),
            IconButton(
              icon: const Icon(
                Icons.home_filled,
                color: Colors.white,
                size: 24.0,
                semanticLabel: 'Home Screen',
              ),
              onPressed: onHomePress,
            ),
            IconButton(
              icon: const Icon(
                Icons.settings,
                color: Colors.white,
                size: 24.0,
                semanticLabel: 'Settings Screen',
              ),
              onPressed: onSettingsPress,
            ),
          ],
        ),
      ),
    );
  }
}
