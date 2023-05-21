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
import 'package:projectmanagement/widgets.dart/order_card_widget.dart';
import 'package:projectmanagement/widgets.dart/shopping_card_widget.dart';

class ShoppingBagPageView extends StatefulWidget {
  const ShoppingBagPageView({Key? key}) : super(key: key);

  @override
  State<ShoppingBagPageView> createState() => _ShoppingBagPageViewState();
}

bool isFavorite = true;

class _ShoppingBagPageViewState extends State<ShoppingBagPageView> {
  final OrderService _orderService = OrderService();

  TextEditingController lookingController = TextEditingController();

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String pageDetailText = "Your Shopping Bag";

  List<String> ordersNames = [];
  List<String> orders = [];
  double orderPrice = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double heightSize = MediaQuery.of(context).size.height;
    double widthSize = MediaQuery.of(context).size.width;
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
                                  stream: _orderService.getShoppingBag(),
                                  builder: (context, snapshot) {
                                    //var x = _favoriteController.countDocuments("Sushi");
                                    return !snapshot.hasData
                                        ? const Center(child: CircularProgressIndicator())
                                        : snapshot.data!.docs.isEmpty
                                            ? Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  const Text(
                                                    "You haven't anything here yet...",
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

                                                  if (index == snapshot.data!.docs.length - 1) {
                                                    ordersNames.add(
                                                      myUruns['urunAdi'],
                                                    );
                                                    orders.add(myUruns.id);
                                                    orderPrice = orderPrice + double.parse(myUruns['urunPrice']);

                                                    return Padding(
                                                      padding: const EdgeInsets.only(right: 8, left: 8, bottom: 15),
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.end,
                                                        children: [
                                                          SizedBox(
                                                            width: widthSize,
                                                            child: ShoppingCardWidget(
                                                              docId: myUruns.id,
                                                              hazirlanmaSuresi: myUruns['hazirlamaSuresi'],
                                                              urunTutari: myUruns['urunPrice']!,
                                                              urunGorsel: myUruns['urunGorseli'],
                                                              urunIsmi: myUruns['urunAdi'],
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            height: 20,
                                                          ),
                                                          SizedBox(
                                                            height: heightSize * 0.07,
                                                            width: widthSize * 0.4,
                                                            child: ElevatedButton(
                                                                style: ButtonStyle(
                                                                    backgroundColor: MaterialStateColor.resolveWith(
                                                                        (states) => Colors.red)),
                                                                onPressed: () {
                                                                  OrderService().addConfirmOrder(Timestamp.now(),
                                                                      orderPrice.toString(), orders, ordersNames);
                                                                  OrderService().deleteUserIdFromOrders();
                                                                },
                                                                child: Row(
                                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                                  children: [
                                                                    const Text("Confirm order"),
                                                                    Image(
                                                                        height: heightSize * 0.05,
                                                                        image: ImageItems.orderIcon2),
                                                                  ],
                                                                )),
                                                          )
                                                        ],
                                                      ),
                                                    );
                                                  }
                                                  ordersNames.add(
                                                    myUruns['urunAdi'],
                                                  );
                                                  orders.add(myUruns.id);
                                                  orderPrice = orderPrice + double.parse(myUruns['urunPrice']);
                                                  return Padding(
                                                    padding: const EdgeInsets.only(right: 8, left: 8, bottom: 15),
                                                    child: SizedBox(
                                                      width: widthSize,
                                                      child: ShoppingCardWidget(
                                                        docId: myUruns.id,
                                                        hazirlanmaSuresi: myUruns['hazirlamaSuresi'],
                                                        urunTutari: myUruns['urunPrice']!,
                                                        urunGorsel: myUruns['urunGorseli'],
                                                        urunIsmi: myUruns['urunAdi'],
                                                      ),
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
