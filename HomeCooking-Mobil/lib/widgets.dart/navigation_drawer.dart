import 'package:flutter/material.dart';
import 'package:projectmanagement/services/auth_service.dart';
import 'package:projectmanagement/utils/image_items.dart';
import 'package:projectmanagement/views/user/adress/adress_page_view.dart';
import 'package:projectmanagement/views/user/recipes/recipes_page_view.dart';

class NavigationDrawerWidget extends StatelessWidget {
  final padding = const EdgeInsets.symmetric(horizontal: 20);

  NavigationDrawerWidget({Key? key}) : super(key: key);
  AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width * 0.1;

    return Drawer(
      child: Container(
          decoration: BoxDecoration(image: DecorationImage(image: ImageItems.drawerBackgroundImage, fit: BoxFit.cover)),
          child: Column(
            children: <Widget>[
              SizedBox(height: size * 1.5),
              buildMenuItem(
                  text: "All Recipes", icon: Icons.book, size: size, onClicked: () => selectedItem(context, 3)),
              buildMenuItem(
                  text: "Favorites", icon: Icons.favorite, size: size, onClicked: () => selectedItem(context, 1)),
              buildMenuItem(
                  text: "Recomended For You",
                  icon: Icons.food_bank,
                  size: size,
                  onClicked: () => selectedItem(context, 2)),
              buildMenuItem(
                  text: "My Address Information",
                  icon: Icons.location_on,
                  size: size,
                  onClicked: () => selectedItem(context, 4)),
              Expanded(
                child: SizedBox(
                  height: size * 10,
                ),
              ),
              const Divider(
                color: Colors.white70,
              ),
              buildMenuItem(
                  text: "Sign Out", icon: Icons.exit_to_app, size: size, onClicked: () => selectedItem(context, 0))
            ],
          )),
    );
  }

  void selectedItem(BuildContext context, int i) {
    switch (i) {
      case 0:
        //çıkış yapılacak
        Navigator.of(context).pop();
        _authService.signOut(context);

        break;
      case 1:
        Navigator.pop(context);
        Navigator.of(context).popUntil((route) => route.isFirst);
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const RecipesPage(recipesCategory: 'userFavorites'),
            ));

        break;
      case 2:
        Navigator.pop(context);
        Navigator.of(context).popUntil((route) => route.isFirst);
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const RecipesPage(recipesCategory: 'Recommended'),
            ));

        break;
      case 3:
        Navigator.pop(context);
        Navigator.of(context).popUntil((route) => route.isFirst);
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const RecipesPage(recipesCategory: 'All Recipes'),
            ));

        break;
      case 4:
        Navigator.pop(context);
        Navigator.of(context).popUntil((route) => route.isFirst);
        Navigator.push(context, MaterialPageRoute(builder: (context) => const AdressPageView()));

        break;

      default:
    }
  }
}

Widget buildMenuItem({required String text, required IconData icon, required double size, VoidCallback? onClicked}) {
  const color = Colors.white;
  const hoverColor = Colors.white70;

  return ListTile(
    leading: Icon(icon, color: Colors.red, size: size),
    title: Text(
      text,
      style: const TextStyle(color: color),
    ),
    hoverColor: hoverColor,
    onTap: onClicked,
  );
}
