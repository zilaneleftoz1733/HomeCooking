import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:projectmanagement/services/favorite_service.dart';
import 'package:projectmanagement/services/order_service.dart';
import 'package:projectmanagement/services/recipe_service.dart';
import 'package:projectmanagement/utils/color_items.dart';
import 'package:projectmanagement/utils/font_items.dart';
import 'package:projectmanagement/utils/image_items.dart';
import 'package:projectmanagement/utils/string_items.dart';
import 'package:projectmanagement/widgets.dart/favorite_button_widget.dart';
import 'package:projectmanagement/widgets.dart/food_card_widget.dart';
import 'package:projectmanagement/widgets.dart/navigation_drawer.dart';

class RecipesPage extends StatefulWidget {
  final String recipesCategory;
  final List<String>? searchArray;
  const RecipesPage({Key? key, required this.recipesCategory, this.searchArray}) : super(key: key);

  @override
  State<RecipesPage> createState() => _RecipesPageState();
}

bool isFavorite = true;

class _RecipesPageState extends State<RecipesPage> {
  final RecipeService _recipeController = RecipeService();
  final FavoriteService _favoriteService = FavoriteService();
  final OrderService _orderService = OrderService();
  TextEditingController lookingController = TextEditingController();
  late Stream<QuerySnapshot<Object?>> urunStream;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String pageDetailText = "Awesome Recipes For You";
  String pageTitle = "All Recipes";

  @override
  void initState() {
    switch (widget.recipesCategory) {
      case 'popular':
        urunStream = _recipeController.getPopularUruns();
        pageDetailText = "Popular flavors of recent times";
        pageTitle = "Popular Near You";
        break;
      case 'recommended':
        urunStream = _recipeController.getRecommendedUruns();
        pageDetailText = "You must try these flavors!";
        pageTitle = "Remommended For You";

        break;
      case 'All Recipes':
        urunStream = _recipeController.getUruns();
        break;
      case 'userFavorites':
        pageDetailText = "Your Favorite Recipes";
        pageTitle = "User Favorites";
        urunStream = _favoriteService.getUserFavorites();
        break;

      case 'userOrders':
        pageDetailText = "Your Orders";
        pageTitle = "Your Orders";
        urunStream = _orderService.getShoppingBag();
        break;
      case 'search':
        pageDetailText = "Your search: ${widget.searchArray?.first.toUpperCase()}";
        pageTitle = "Search Results";
        urunStream = _recipeController.getTitleUruns(widget.searchArray!);
        break;

      default:
        urunStream = _recipeController.getCategoryUruns(widget.recipesCategory);
        pageTitle = widget.recipesCategory;
        pageDetailText = "${widget.recipesCategory} category!";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double heightSize = MediaQuery.of(context).size.height;
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: NavigationDrawerWidget(),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          height: heightSize,
          decoration: BoxDecoration(image: DecorationImage(image: ImageItems.backgroundImage, fit: BoxFit.cover)),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(right: 15, left: 15, top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(StringItems.projectName, style: FontItems.boldTextInter24),
                  Row(
                    children: [
                      Text(
                        'Offers',
                        style: FontItems.boldTextInter24,
                      ),
                      Text(
                        ' Excellent Flavors',
                        style: FontItems.boldTextInter24Turquase(context),
                      ),
                    ],
                  ),
                  Expanded(
                    child: SizedBox(
                      height: heightSize * 0.74,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: Row(
                              children: [
                                Text(pageDetailText, style: FontItems.boldTextInter20Turquase),
                                const Expanded(
                                  child: SizedBox(
                                    width: 100,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: SizedBox(
                              height: heightSize * 0.69,
                              child: MediaQuery.removePadding(
                                context: context,
                                removeTop: true,
                                child: StreamBuilder<QuerySnapshot>(
                                  stream: urunStream,
                                  builder: (context, snapshot) {
                                    //var x = _favoriteController.countDocuments("Sushi");
                                    return !snapshot.hasData
                                        ? const Center(child: CircularProgressIndicator())
                                        : snapshot.data!.docs.isEmpty
                                            ? Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  const Text(
                                                    "You haven't added anything here yet...",
                                                    style: TextStyle(color: Colors.white70),
                                                  ),
                                                  const SizedBox(
                                                    height: 80,
                                                  ),
                                                  SizedBox(
                                                    height: 140,
                                                    child: OverflowBox(
                                                      minHeight: heightSize * 0.2,
                                                      maxHeight: heightSize * 0.4,
                                                      child: Lottie.asset(
                                                        'assets/no-order.json',
                                                        fit: BoxFit.fill,

                                                        //controller: lottieController,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            : ListView.builder(
                                                scrollDirection: Axis.vertical,
                                                itemCount: snapshot.data!.docs.length, //snapshot.data!.docs.length,
                                                itemBuilder: (context, index) {
                                                  DocumentSnapshot myUruns = snapshot.data!.docs[index //index
                                                      ];

                                                  return Padding(
                                                    padding: const EdgeInsets.only(right: 8, left: 8, bottom: 15),
                                                    child: FoodCardWidget(
                                                      docId: myUruns.id,
                                                      hazirlanmaSuresi: myUruns['hazirlamaSuresi'],
                                                      urunTutari: myUruns['urunPrice'],
                                                      urunGorsel: myUruns['urunGorseli'],
                                                      urunIsmi: myUruns['urunAdi'],
                                                    ),
                                                  );
                                                },
                                              );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
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

  lookingClick() {}
}
