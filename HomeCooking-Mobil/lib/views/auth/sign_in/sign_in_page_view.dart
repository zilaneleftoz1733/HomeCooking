import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projectmanagement/navigation/navigation_view.dart';
import 'package:projectmanagement/services/auth_service.dart';
import 'package:projectmanagement/utils/color_items.dart';
import 'package:projectmanagement/utils/font_items.dart';
import 'package:projectmanagement/utils/image_items.dart';
import 'package:projectmanagement/utils/string_items.dart';
import 'package:projectmanagement/views/admin/recipe_add_page_view.dart';
import 'package:projectmanagement/views/auth/forgot_password/forgot_password_page_view.dart';
import 'package:projectmanagement/views/auth/sign_up/sign_up_page_view.dart';
import 'package:projectmanagement/widgets.dart/elevated_button_widget.dart';
import 'package:projectmanagement/widgets.dart/text_form_widget.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => SignInPageState();
}

TextStyle boldTextStyle = const TextStyle(fontWeight: FontWeight.bold, fontSize: 28, color: Colors.white);
AuthService _authService = AuthService();

class SignInPageState extends State<SignInPage> {
  TextEditingController mailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  String validationText = ' ';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: Text(
          "Sign in",
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
                        StringItems.projectName,
                        style: FontItems.boldTextInter24Turquase(context),
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
                          text: TextSpan(
                              text: "Enter your username and password for sign in ",
                              style: const TextStyle(fontSize: 16),
                              children: [
                                TextSpan(
                                    text: StringItems.projectHomeMessage,
                                    style: const TextStyle(fontSize: 17, color: ColorItems.generalTurquaseColor))
                              ]),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  TextFormWidget(
                      textFormController: mailController,
                      hintText: "Email Adress",
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Flexible(
                        child: Text(
                          validationText,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            validationText = '';
                          });
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ForgotPasswordPage(),
                              ));
                        },
                        child: const Text(
                          "Forgot Password",
                          style: TextStyle(color: ColorItems.generalTurquaseColor),
                        ),
                      ),
                    ],
                  ),
                  ElevatedButtonWidget(
                    buttonColor: ColorItems.generalTurquaseColor,
                    buttonTextStyle: FontItems.boldTextInter20,
                    buttonTitle: "Sign in",
                    buttonMetod: () => signIn(),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: FontItems.normalTextWorkSans16,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            validationText = '';
                          });

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignUpPage(),
                              ));
                        },
                        child: const Text(
                          "Sign up",
                          style: TextStyle(color: ColorItems.generalTurquaseColor, fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(13.0),
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
                      buttonMetod: () => _authService.connectWithGoogle(context)),
                  const SizedBox(
                    height: 15,
                  ),
                  ElevatedButtonWidget(
                    buttonTitle: "Connect Anonymously",
                    buttonColor: ColorItems.facebookButtonColor,
                    buttonTextStyle: FontItems.normalTextWorkSans16,
                    buttonMetod: () => _authService.connectAnonymously(context),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> signIn() async {
    if (_authService.emailFormatControl(mailController.text)) {
      _authService.connectWithMail(mailController.text, passwordController.text).then((value) {
        if (value != null) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => const NavigationPageView(),
          ));
        } else {
          setState(() {
            validationText = "Please check your e-mail or password";
          });
        }
      });
    } else {
      setState(() {
        validationText = "Please check your e-mail or password format";
      });
    }
  }

  void textClicked() {
    //print("Texte tıklandı");
  }
}
