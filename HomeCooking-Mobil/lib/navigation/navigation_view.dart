import 'package:flutter/material.dart';
import 'package:projectmanagement/services/user_service.dart';
import 'package:projectmanagement/utils/font_items.dart';
import 'package:projectmanagement/utils/image_items.dart';

import 'package:projectmanagement/navigation/navigation_view_model.dart';
import 'package:projectmanagement/utils/string_items.dart';
import 'package:projectmanagement/views/user/menu/menu_page_view.dart';
import 'package:projectmanagement/views/user/order/order_page_view.dart';
import 'package:projectmanagement/views/user/recipes/recipes_page_view.dart';
import 'package:projectmanagement/views/user/shopping_bag/shopping_bag_page_view.dart';

import 'package:projectmanagement/widgets.dart/bottom_app_bar.dart';
import 'package:projectmanagement/widgets.dart/navigation_drawer.dart';
import 'package:provider/provider.dart';

class NavigationPageView extends StatefulWidget {
  const NavigationPageView({super.key});

  @override
  State<NavigationPageView> createState() => _NavigationPageViewState();
}

class _NavigationPageViewState extends State<NavigationPageView> {
  final List<Widget> _children = [
    const RecipesPage(
      recipesCategory: 'All Recipes',
    ),
    const RecipesPage(
      recipesCategory: 'userFavorites',
    ),
    ShoppingBagPageView(),
    const OrderPageView(),
    MenuPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final myViewModel = Provider.of<NavigationViewModel>(context);
    void onTabTapped(int index) {
      myViewModel.changeNavigationIndex(index);
    }

    final _scaffoldKey = GlobalKey<ScaffoldState>();
    //double Size = MediaQuery.of(context).h;

    return Scaffold(
        key: _scaffoldKey,
        endDrawer: NavigationDrawerWidget(),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leadingWidth: 55,
          leading: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                width: 13,
              ),
              CircleAvatar(
                backgroundColor: Colors.white60,
                backgroundImage: NetworkImage(UserController.userPhotoUrl),
              ),
            ],
          ),
          title: RichText(
            text: TextSpan(children: [
              TextSpan(
                text: StringItems.profileHiMessage,
                style: FontItems.normalTextStyle16,
              ),
              const TextSpan(text: "\n"),
              TextSpan(
                text: UserController.userName,
                style: FontItems.normalTextStyle16,
              )
            ]),
          ),
          actions: [
            IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  _scaffoldKey.currentState?.openEndDrawer();
                })
          ],
        ),
        extendBodyBehindAppBar: true,
        extendBody: true,
        body: _children[myViewModel.navigationIndex],
        floatingActionButton: SizedBox(
          height: 60,
          width: 60,
          child: FloatingActionButton(
            onPressed: () {
              myViewModel.changeNavigationIndex(4);
            },
            backgroundColor: Colors.transparent,
            child: Image.asset('assets/food.png'),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: CustomBottomAppBar(currentIndex: myViewModel.navigationIndex, onTap: onTabTapped));
  }
}
