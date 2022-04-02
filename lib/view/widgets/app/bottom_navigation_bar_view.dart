import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobile_nutrimiski/util/colors.dart';

class CustomBottomNavigationBar extends StatefulWidget {

  final int index;
  final ValueChanged<int> onChangedTab;

  const CustomBottomNavigationBar({
    required this.index,
    required this.onChangedTab,
    Key? key
  }) : super(key: key);

  @override
  _CustomBottomNavigationBarState createState() => _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.white,
      shape: const CircularNotchedRectangle(),
      notchMargin: 1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buildAppBarItem(
            index: 0,
            icon: const FaIcon(FontAwesomeIcons.home),
          ),
          buildAppBarItem(
            index: 1,
            icon: const FaIcon(FontAwesomeIcons.facebookMessenger),
          ),
          buildAppBarItem(
            index: 3,
            icon: const FaIcon(FontAwesomeIcons.child),
          ),
        ],
      ),
    );
  }

  Widget buildAppBarItem({required int index, required FaIcon icon}){
    final isSelected = index == widget.index;
    return IconTheme(
      data: IconThemeData(
        color: isSelected? primaryColor : Colors.black12,
      ),
      child: IconButton(
        icon: icon,
        highlightColor: Colors.white.withOpacity(0.2),
        splashColor: Colors.white.withOpacity(0.2),
        onPressed: () { widget.onChangedTab(index);},
      ),
    );
  }
}