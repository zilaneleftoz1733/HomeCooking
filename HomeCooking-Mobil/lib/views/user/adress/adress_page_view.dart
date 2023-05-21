import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:projectmanagement/services/adress_service.dart';
import 'package:projectmanagement/services/recipe_service.dart';
import 'package:projectmanagement/utils/color_items.dart';
import 'package:projectmanagement/utils/font_items.dart';
import 'package:projectmanagement/utils/image_items.dart';
import 'package:projectmanagement/widgets.dart/elevated_button_widget.dart';
import 'package:projectmanagement/widgets.dart/navigation_drawer.dart';
import 'package:projectmanagement/widgets.dart/text_form_expanded.dart';
import 'package:projectmanagement/widgets.dart/text_form_widget.dart';

class AdressPageView extends StatefulWidget {
  const AdressPageView({Key? key}) : super(key: key);

  @override
  State<AdressPageView> createState() => AdressPageViewState();
}

TextStyle boldTextStyle = const TextStyle(fontWeight: FontWeight.bold, fontSize: 28, color: Colors.white);

class AdressPageViewState extends State<AdressPageView> {
  bool isLoading = true;

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController adressController = TextEditingController();

  final RecipeService _RecipeService = RecipeService();
  var firebaseCategories = [];
  var firebaseIngredients = [];

  getAdress() async {
    adressController.text = await AdressService().getUserAdress() ?? '';
    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getAdress();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        key: _scaffoldKey,
        endDrawer: NavigationDrawerWidget(),
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.black,
        body: Container(
          constraints: const BoxConstraints.expand(),
          decoration: BoxDecoration(
            image: DecorationImage(image: ImageItems.backgroundImage, fit: BoxFit.cover),
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              reverse: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                        Row(
                          children: [
                            Text(
                              "Check your Adress",
                              style: FontItems.boldTextInter24,
                              textAlign: TextAlign.start,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "Your order is waiting for you!",
                              style: FontItems.boldTextInter20Turquase,
                              textAlign: TextAlign.start,
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 190,
                              child: OverflowBox(
                                child: Lottie.asset(
                                  'assets/city.json',
                                  fit: BoxFit.fill,

                                  //controller: lottieController,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            SizedBox(
                              child: TextFormExpanded(
                                  textFormController: adressController,
                                  formIcon: Icons.location_city,
                                  hintText: "Adress",
                                  textClicked: () => textClicked()),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            ElevatedButtonWidget(
                              buttonColor: ColorItems.generalTurquaseColor,
                              buttonTextStyle: FontItems.boldTextInter20,
                              buttonTitle: "Update Address",
                              buttonMetod: () => saveAdress(),
                            ),
                          ],
                        ),
                      ]),
              ),
            ),
          ),
        ));
  }

  void saveAdress() async {
    AdressService().saveUserAdress(adressController.text);

    clearAllController();

    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
    Navigator.of(context).pop();

    //m
  }
}

void textClicked() {
  //print("Texte tıklandı");
}

void clearAllController() {}
