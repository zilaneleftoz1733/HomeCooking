import 'package:flutter/material.dart';
import 'package:projectmanagement/services/auth_service.dart';
import 'package:projectmanagement/utils/color_items.dart';
import 'package:projectmanagement/utils/font_items.dart';
import 'package:projectmanagement/utils/image_items.dart';
import 'package:projectmanagement/widgets.dart/elevated_button_widget.dart';
import 'package:projectmanagement/widgets.dart/text_form_widget.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => SignUpPageState();
}

AuthService _authController = AuthService();
TextStyle boldTextStyle = const TextStyle(fontWeight: FontWeight.bold, fontSize: 28, color: Colors.white);

class SignUpPageState extends State<SignUpPage> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  TextEditingController passwordAgainController = TextEditingController();
  TextEditingController mailController = TextEditingController();
  String inputWrongResult = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: Text(
          "Sign up",
          style: FontItems.boldTextWorkSans20,
        ),
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
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Text(
                        "Create Account",
                        style: FontItems.boldTextInter24,
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 249,
                        child: RichText(
                          text: const TextSpan(
                              text: "Enter your email and password for sign in",
                              style: TextStyle(fontSize: 16),
                              children: [
                                TextSpan(
                                    text: " and Enjoy your food",
                                    style: TextStyle(fontSize: 17, color: ColorItems.generalTurquaseColor))
                              ]),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  TextFormWidget(
                      textFormController: nameController,
                      hintText: "Name",
                      formIcon: Icons.mail_outline,
                      textClicked: () => textClicked()),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormWidget(
                      textFormController: mailController,
                      hintText: "Email Address",
                      formIcon: Icons.mail_outline,
                      textClicked: () => textClicked()),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormWidget(
                    textFormController: passwordController,
                    formIcon: Icons.lock_outline,
                    hintText: "Password",
                    textClicked: () => textClicked(),
                    textFieldIsPassword: true,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormWidget(
                    textFormController: passwordAgainController,
                    formIcon: Icons.lock_outline,
                    hintText: "Password Again",
                    textClicked: () => textClicked(),
                    textFieldIsPassword: true,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Text(
                      inputWrongResult,
                      style: const TextStyle(fontSize: 18, color: Colors.red),
                    ),
                  ),
                  ElevatedButtonWidget(
                    buttonColor: ColorItems.generalTurquaseColor,
                    buttonTextStyle: FontItems.boldTextInter20,
                    buttonTitle: "Create Account",
                    buttonMetod: () => createAccount(),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: RichText(
                      text: const TextSpan(
                          text: "- - - - - - - - - - - - - -    ",
                          style: TextStyle(fontSize: 16, color: Colors.white24),
                          children: [
                            TextSpan(
                              text: "OR",
                              style: TextStyle(fontSize: 17, color: Colors.white70),
                            ),
                            TextSpan(text: "    - - - - - - - - - - - - - -")
                          ]),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButtonWidget(
                    buttonTitle: "Connect with Google",
                    buttonColor: ColorItems.googleButtonColor,
                    buttonTextStyle: FontItems.normalTextWorkSans16,
                    buttonMetod: () => _authController.connectWithGoogle(context),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ElevatedButtonWidget(
                    buttonTitle: "Connect Anonymously",
                    buttonColor: ColorItems.facebookButtonColor,
                    buttonTextStyle: FontItems.normalTextWorkSans16,
                    buttonMetod: () => _authController.connectAnonymously(context),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void createAccount() {
    AuthService _authController = AuthService();

    if (_authController.passwordFormatControl(passwordController.text, passwordAgainController.text)) {
      if (_authController.emailFormatControl(mailController.text)) {
        _authController.createPerson(mailController.text, passwordController.text, nameController.text);
        Navigator.pop(context);
      } else {
        inputWrongResult = 'Please check your e-mail format';
      }
    } else {
      inputWrongResult = 'Passwords must be at least 6 characters and equals';
    }

    setState(() {});
  }

  void textClicked() {
    //print("Texte tıklandı");
  }
}
