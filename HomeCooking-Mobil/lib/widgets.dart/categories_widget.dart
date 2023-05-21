import 'package:flutter/material.dart';
import 'package:projectmanagement/utils/color_items.dart';
import 'package:projectmanagement/views/user/recipes/recipes_page_view.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({Key? key, required this.widgetText, this.backgroundColor = ColorItems.softGreyColor})
      : super(key: key);

  final String widgetText;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    //Color widgetColor = ColorItems.softGreyColor;

    return SizedBox(
      width: 105,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RecipesPage(
                  recipesCategory: widgetText,
                ),
              ));
        },
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(11.0),
          )),
          backgroundColor: MaterialStateProperty.all<Color>(backgroundColor),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 1),
          child: Text(widgetText),
        ),
      ),
    );
  }
}
