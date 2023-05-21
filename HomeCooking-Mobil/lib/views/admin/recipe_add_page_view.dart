import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projectmanagement/services/recipe_service.dart';
import 'package:projectmanagement/utils/color_items.dart';
import 'package:projectmanagement/utils/font_items.dart';
import 'package:projectmanagement/utils/image_items.dart';
import 'package:projectmanagement/widgets.dart/elevated_button_widget.dart';
import 'package:projectmanagement/widgets.dart/navigation_drawer.dart';
import 'package:projectmanagement/widgets.dart/text_form_expanded.dart';
import 'package:projectmanagement/widgets.dart/text_form_widget.dart';

class RecipeAddPage extends StatefulWidget {
  const RecipeAddPage({Key? key}) : super(key: key);

  @override
  State<RecipeAddPage> createState() => RecipeAddPageState();
}

TextStyle boldTextStyle = const TextStyle(fontWeight: FontWeight.bold, fontSize: 28, color: Colors.white);

class RecipeAddPageState extends State<RecipeAddPage> {
  bool isLoading = true; //BUNU ASAGIYA CEKTIM, HATA OLURSA GERİ YUKARI
  List<String> selectedCategory = [];
  List<String> selectedIngredient = [];
  List<CheckBoxState> categories = [];
  List<CheckBoxState> ingredients = [];
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController foodNameController = TextEditingController();
  TextEditingController foodCookTimeController = TextEditingController();
  TextEditingController foodImageLinkController = TextEditingController();
  TextEditingController foodPointController = TextEditingController();
  TextEditingController foodRecipeController = TextEditingController();
  TextEditingController foodIngredientsController = TextEditingController();

  File? cacheFile;
  final RecipeService _RecipeService = RecipeService();
  var firebaseCategories = [];
  var firebaseIngredients = [];

  getCategories() async {
    categories.add(CheckBoxState(title: "Meat"));
    categories.add(CheckBoxState(title: "Vegan"));
    categories.add(CheckBoxState(title: "Fastfood"));
    categories.add(CheckBoxState(title: "Fish"));
  }

  getIngredients() async {
    ingredients.add(CheckBoxState(title: "Tomato"));
    ingredients.add(CheckBoxState(title: "Patato"));
    ingredients.add(CheckBoxState(title: "Onion"));
    ingredients.add(CheckBoxState(title: "Olive Oil"));
    ingredients.add(CheckBoxState(title: "Cheese"));

    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getCategories();
    getIngredients();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: NavigationDrawerWidget(),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: const Text("Recipe Add"),
        actions: [
          IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                _scaffoldKey.currentState?.openEndDrawer();
              })
        ],
      ),
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
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Add new Recipe",
                              style: FontItems.boldTextInter24,
                              textAlign: TextAlign.start,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        TextFormWidget(
                            textFormController: foodNameController,
                            hintText: "Food Name",
                            formIcon: Icons.person_outline,
                            textClicked: () => textClicked()),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 180,
                          width: 400,
                          decoration: BoxDecoration(border: Border.all(color: Colors.white)),
                          child: GridView(
                            padding: const EdgeInsets.only(bottom: 27),
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 0,
                              mainAxisExtent: 32,
                              crossAxisCount: 2,
                            ),
                            children: [
                              ...categories.map(buildSingleCheckBox).toList(),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormWidget(
                            textFormController: foodCookTimeController,
                            formIcon: Icons.timelapse_sharp,
                            hintText: "Cook Minute",
                            textClicked: () => textClicked()),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 300,
                              child: TextFormExpanded(
                                  textFormController: foodImageLinkController,
                                  formIcon: Icons.image,
                                  hintText: "Image Link",
                                  textClicked: () => textClicked()),
                            ),
                            Expanded(
                                child: Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: IconButton(
                                  onPressed: () {
                                    imageUploadClicked();
                                  },
                                  icon: const Icon(
                                    Icons.file_open_outlined,
                                    size: 40,
                                  )),
                            ))
                          ],
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        TextFormWidget(
                            textFormController: foodPointController,
                            formIcon: Icons.score,
                            hintText: "Food Point",
                            textClicked: () => textClicked()),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormWidget(
                            textFormController: foodRecipeController,
                            formIcon: Icons.book,
                            hintText: "Recipe",
                            textClicked: () => textClicked()),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 180,
                          width: 400,
                          decoration: BoxDecoration(border: Border.all(color: Colors.white)),
                          child: GridView(
                            padding: const EdgeInsets.only(bottom: 27),
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 0,
                              mainAxisExtent: 32,
                              crossAxisCount: 2,
                            ),
                            children: [
                              ...ingredients.map(buildSingleIngredientCheckBox).toList(),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButtonWidget(
                          buttonColor: ColorItems.generalTurquaseColor,
                          buttonTextStyle: FontItems.boldTextInter20,
                          buttonTitle: "Add Recipe",
                          buttonMetod: () => addRecipe(),
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSingleCheckBox(CheckBoxState checkbox) => CheckboxListTile(
        controlAffinity: ListTileControlAffinity.leading,
        activeColor: Colors.blue,
        checkColor: Colors.white,
        value: checkbox.value,
        title: Text(
          checkbox.title,
          style: TextStyle(color: Colors.white),
        ),
        onChanged: (value) => setState(() {
          checkbox.value = value!;
          if (checkbox.value) {
            selectedCategory.add(checkbox.title);
          } else {
            selectedCategory.remove(checkbox.title);
          }
        }),
      );

  Widget buildSingleIngredientCheckBox(CheckBoxState checkbox) => CheckboxListTile(
        checkColor: Colors.white,
        controlAffinity: ListTileControlAffinity.leading,
        activeColor: Colors.blue,
        value: checkbox.value,
        title: Text(
          checkbox.title,
          style: TextStyle(color: Colors.white),
        ),
        onChanged: (value) => setState(() {
          checkbox.value = value!;
          if (checkbox.value) {
            selectedIngredient.add(checkbox.title);
            print(selectedIngredient);
          } else {
            selectedIngredient.remove(checkbox.title);
            print(selectedIngredient);
          }
        }),
      );

  void addRecipe() async {
    if (foodNameController.text.isNotEmpty &&
        selectedIngredient.isNotEmpty &&
        foodImageLinkController.text.isNotEmpty) {
      isLoading = true;

      if (cacheFile == null) {
      } else {
        foodImageLinkController.text = await imageUpload(cacheFile!);
      }
      List<String> urunAdiArray = textSplit(foodNameController.text);
      Map malzemelerMap = {};
      selectedIngredient.forEach((ingredient) => malzemelerMap[ingredient] = true);

      _RecipeService.addUrun(
          foodNameController.text,
          selectedCategory,
          foodCookTimeController.text,
          foodImageLinkController.text,
          foodPointController.text,
          foodRecipeController.text,
          selectedIngredient,
          urunAdiArray,
          malzemelerMap);

      foodNameController.clear();
      foodCookTimeController.clear();
      foodImageLinkController.clear();
      foodPointController.clear();
      foodRecipeController.clear();
      foodIngredientsController.clear();
      selectedCategory.clear();
      selectedCategory.clear();

      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }

      //m
    }
  }

  void textClicked() {
    //print("Texte tıklandı");
  }

  void imageUploadClicked() async {
    try {
      ImagePicker imagePicker = ImagePicker();
      XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);
      cacheFile = File(file!.path);
      foodImageLinkController.text = file.name.split("image_picker").last;
    } catch (error) {
      error.toString();
    }
  }

  void clearAllController() {
    foodNameController.clear();
    foodCookTimeController.clear();
    foodImageLinkController.clear();
    foodPointController.clear();
    foodRecipeController.clear();
    foodIngredientsController.clear();
  }
}

List<String> textSplit(String str) {
  str = str.toLowerCase();
  //Her sey cok güzel olacak
  //[H, He, Her, s, se, sey, c, co, cok, g, gu, guz, guze, guzel, o, ol, ola, olac, olaca, olacak]

  List<String> kombinasyonlar = [];
  List<String> kelimeler = str.split(" ");
  for (String kelime in kelimeler) {
    for (int i = 0; i < kelime.length; i++) {
      if (kelime[i] == kelime[0]) {
        for (int j = i + 1; j <= kelime.length; j++) {
          kombinasyonlar.add(kelime.substring(i, j));
        }
      }
    }
  }
  return kombinasyonlar;
}

Future<String> imageUpload(File cacheFile) async {
  Reference referenceRoot = FirebaseStorage.instance.ref();
  Reference referenceDirImages = referenceRoot.child('images');
  String uniqueFileName = DateTime.now().microsecondsSinceEpoch.toString();
  Reference referenceImageToUpload = referenceDirImages.child(uniqueFileName);
  await referenceImageToUpload.putFile(cacheFile);
  String uploadedImageLink = await referenceImageToUpload.getDownloadURL();

  return uploadedImageLink;
}

class CheckBoxState {
  final String title;
  bool value;

  CheckBoxState({
    required this.title,
    this.value = false,
  });
}
