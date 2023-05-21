import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projectmanagement/navigation/navigation_view_model.dart';
import 'package:projectmanagement/services/categories_repository.dart';
import 'package:projectmanagement/services/recipe_service.dart';
import 'package:projectmanagement/utils/color_items.dart';
import 'package:projectmanagement/utils/font_items.dart';
import 'package:projectmanagement/utils/image_items.dart';
import 'package:projectmanagement/views/user/recipes/recipes_page_view.dart';
import 'package:projectmanagement/widgets.dart/categories_widget.dart';
import 'package:projectmanagement/widgets.dart/custom_search_form.dart';
import 'package:projectmanagement/widgets.dart/food_card_widget.dart';
import 'package:projectmanagement/widgets.dart/text_form_widget.dart';
import 'package:provider/provider.dart';

class MenuPage extends StatefulWidget {
  MenuPage({Key? key}) : super(key: key);

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  TextEditingController _searchEditingController = TextEditingController();
  final focusNode = FocusNode();
  TextEditingController lookingController = TextEditingController();
  CategoriesRepository category = CategoriesRepository();

  RecipeService _recipeService = RecipeService();

  @override
  Widget build(BuildContext context) {
    final myViewModel = Provider.of<NavigationViewModel>(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: BoxDecoration(image: DecorationImage(image: ImageItems.backgroundImage, fit: BoxFit.cover)),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(right: 15, left: 15, top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Healty and', style: FontItems.boldTextInter24),
                  Text(
                    'Delicious Food',
                    style: FontItems.boldTextInter24,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: CustomSearchForm(
                      textFormController: _searchEditingController,
                      hintText: 'what are u looking for?',
                      formIcon: Icons.search,
                      textClicked: () => searchMetod(),
                      focusNode: focusNode,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Categories',
                        style: FontItems.boldTextInter16,
                      ),
                      const SizedBox(
                        height: 10,
                        width: 10,
                      ),
                      Container(
                        height: min(33, 100),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: category.categories.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: CategoriesWidget(widgetText: category.categories[index]),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text('Popular Near You', style: FontItems.boldTextInter16),
                            const Expanded(
                              child: SizedBox(
                                width: 100,
                              ),
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const RecipesPage(recipesCategory: 'Popular'),
                                      ));
                                },
                                child: const Text(
                                  'View All',
                                  style: TextStyle(color: ColorItems.generalTurquaseColor, fontSize: 16),
                                )),
                            const Icon(
                              Icons.arrow_forward_ios,
                              color: ColorItems.generalTurquaseColor,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 170,
                          child: MediaQuery.removePadding(
                            context: context,
                            removeTop: true,
                            child: StreamBuilder<QuerySnapshot>(
                              stream: _recipeService.getPopularUruns(),
                              builder: (context, snapshot) {
                                return !snapshot.hasData
                                    ? const Center(child: CircularProgressIndicator())
                                    : ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: snapshot.data!.docs.length,
                                        itemBuilder: (context, index) {
                                          DocumentSnapshot myUruns = snapshot.data!.docs[index //index
                                              ];
                                          return Padding(
                                            padding: const EdgeInsets.only(right: 15),
                                            child: FoodCardWidget(
                                              hazirlanmaSuresi: myUruns['hazirlamaSuresi'],
                                              urunGorsel: myUruns['urunGorseli'],
                                              urunIsmi: myUruns['urunAdi'],
                                              docId: myUruns.id,
                                              urunTutari: myUruns['urunPrice'],
                                            ),
                                          );
                                        },
                                      );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Text('Recommended Foods', style: FontItems.boldTextInter16),
                      const Expanded(
                        child: SizedBox(
                          width: 100,
                        ),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const RecipesPage(recipesCategory: 'Recommended'),
                                ));
                          },
                          child: const Text(
                            'View All',
                            style: TextStyle(color: ColorItems.generalTurquaseColor, fontSize: 16),
                          )),
                      const Icon(
                        Icons.arrow_forward_ios,
                        color: ColorItems.generalTurquaseColor,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 170,
                    child: MediaQuery.removePadding(
                      context: context,
                      removeTop: true,
                      child: StreamBuilder<QuerySnapshot>(
                        stream: _recipeService.getRecommendedUruns(),
                        builder: (context, snapshot) {
                          return !snapshot.hasData
                              ? const Center(child: CircularProgressIndicator())
                              : ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder: (context, index) {
                                    DocumentSnapshot myUruns = snapshot.data!.docs[index //index
                                        ];
                                    return Padding(
                                      padding: const EdgeInsets.only(right: 15),
                                      child: FoodCardWidget(
                                        hazirlanmaSuresi: myUruns['hazirlamaSuresi'],
                                        urunGorsel: myUruns['urunGorseli'],
                                        urunIsmi: myUruns['urunAdi'],
                                        docId: myUruns.id,
                                        urunTutari: myUruns['urunPrice'],
                                      ),
                                    );
                                  },
                                );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  searchMetod() {
    focusNode.unfocus();
    List<String> searchArray = _searchEditingController.text.toLowerCase().split(" ");
    _searchEditingController.clear();
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RecipesPage(recipesCategory: 'search', searchArray: searchArray),
        ));
  }

  lookingClick() {}
}
