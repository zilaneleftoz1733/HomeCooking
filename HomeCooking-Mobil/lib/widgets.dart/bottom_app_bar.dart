import 'package:flutter/material.dart';
import 'package:projectmanagement/utils/color_items.dart';

class CustomBottomAppBar extends StatelessWidget {
  final ValueChanged<int> onTap;
  final int currentIndex;
  const CustomBottomAppBar(
      {super.key,
      required this.currentIndex,
      required this.onTap,
      Color floatingActionButtonBackground = Colors.white});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    double iconSize = size.height * 0.035;

    return BottomAppBar(
      color: Colors.black,
      shape: const CircularNotchedRectangle(),
      child: SizedBox(
        height: size.height * 0.07,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.food_bank,
                size: iconSize,
              ),
              onPressed: () => onTap(0),
              color: currentIndex == 0 ? ColorItems.selectedButtonColor : Colors.white,
            ),
            IconButton(
              icon: Icon(
                Icons.favorite,
                size: iconSize,
              ),
              onPressed: () => onTap(1),
              color: currentIndex == 1 ? ColorItems.selectedButtonColor : Colors.white,
            ),
            SizedBox(width: size.height * 0.07),
            IconButton(
              icon: Icon(
                Icons.shopping_basket,
                size: iconSize,
              ),
              onPressed: () => onTap(2),
              color: currentIndex == 2 ? ColorItems.selectedButtonColor : Colors.white,
            ),
            IconButton(
              icon: Icon(
                Icons.payment,
                size: iconSize,
              ),
              onPressed: () => onTap(3),
              color: currentIndex == 3 ? ColorItems.selectedButtonColor : Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
