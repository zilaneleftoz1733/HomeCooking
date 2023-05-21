import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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

class OrderPageView extends StatefulWidget {
  const OrderPageView({Key? key}) : super(key: key);

  @override
  State<OrderPageView> createState() => _OrderPageViewState();
}

bool isFavorite = true;

class _OrderPageViewState extends State<OrderPageView> {
  final OrderService _orderService = OrderService();

  TextEditingController lookingController = TextEditingController();

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String pageDetailText = "Your Orders";
  String pageTitle = "Your Orders";

  @override
  void initState() {
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
                                  stream: _orderService.getUserCompletedOrders(),
                                  builder: (context, snapshot) {
                                    //var x = _favoriteController.countDocuments("Sushi");
                                    return !snapshot.hasData
                                        ? const Center(child: CircularProgressIndicator())
                                        : ListView.builder(
                                            scrollDirection: Axis.vertical,
                                            itemCount: snapshot.data!.docs.length, //snapshot.data!.docs.length,
                                            itemBuilder: (context, index) {
                                              DocumentSnapshot myUruns = snapshot.data!.docs[index //index
                                                  ];

                                              return Padding(
                                                  padding: const EdgeInsets.only(right: 8, left: 8, bottom: 15),
                                                  child: OrderCardWidget(
                                                      orderDate: myUruns['orderDate'],
                                                      orderPrice: myUruns['orderPrice'],
                                                      orderStatus: myUruns['orderStatus'],
                                                      orders: myUruns['ordersNames'],
                                                      userAdress: myUruns['userAdress']));
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
