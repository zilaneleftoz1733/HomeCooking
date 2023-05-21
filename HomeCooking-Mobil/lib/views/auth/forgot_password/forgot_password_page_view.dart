import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:projectmanagement/services/auth_service.dart';
import 'package:projectmanagement/utils/color_items.dart';
import 'package:projectmanagement/utils/font_items.dart';
import 'package:projectmanagement/utils/image_items.dart';
import 'package:projectmanagement/widgets.dart/elevated_button_widget.dart';
import 'package:projectmanagement/widgets.dart/text_form_widget.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => ForgotPasswordPageState();
}

TextStyle boldTextStyle = const TextStyle(fontWeight: FontWeight.bold, fontSize: 28, color: Colors.white);

class ForgotPasswordPageState extends State<ForgotPasswordPage> with TickerProviderStateMixin {
  TextEditingController mailController = TextEditingController();
  AnimationController? lottieController;
  bool mailFormatStatus = true;
  bool isMailSended = false;

  @override
  void initState() {
    super.initState();

    lottieController = AnimationController(duration: const Duration(seconds: 2), vsync: this);

    lottieController!.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        isMailSended = true;
        lottieController!.reset();
        mailController.clear();
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    lottieController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double widthSize = MediaQuery.of(context).size.width;
    // ignore: unused_local_variable
    bool progressAnimateIsActive = false;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: Text(
          "Forgot Password",
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
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 80),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 9),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "Forgot Password",
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
                                    text: "Please enter your email. In this way, we can help you for",
                                    style: TextStyle(fontSize: 16),
                                    children: [
                                      TextSpan(
                                          text: " Recover your Password",
                                          style: TextStyle(fontSize: 17, color: ColorItems.generalTurquaseColor))
                                    ]),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                    child: lottieController!.isAnimating
                        ? SizedBox(
                            width: widthSize,
                            height: 40,
                            child: Lottie.asset(
                              'assets/turquiseprogressbar.json',
                              fit: BoxFit.fill,
                              repeat: false,
                              animate: false,
                              controller: lottieController,
                              onLoaded: (p0) {},
                            ))
                        : SizedBox(
                            height: 40,
                            child: Align(
                                alignment: Alignment.bottomLeft,
                                child: isMailSended
                                    ? Text(
                                        "We've sent a link to your mailbox!",
                                        style: FontItems.boldTextInter16Yellow,
                                      )
                                    : Text(
                                        "We will send an email to your email adress.",
                                        style: FontItems.boldTextInter16,
                                      )),
                          ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 9),
                    child: Column(
                      children: [
                        TextFormWidget(
                            textFormController: mailController,
                            hintText: "Email Address",
                            formIcon: Icons.mail_outline,
                            textClicked: () {}),
                        SizedBox(
                          height: 25,
                          child: mailFormatStatus
                              ? null
                              : const Center(
                                  child: Text(
                                    "Check your email adress",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                        ),
                        ElevatedButtonWidget(
                          buttonColor: ColorItems.generalTurquaseColor,
                          buttonTextStyle: FontItems.boldTextInter20,
                          buttonTitle: "Reset Password",
                          buttonMetod: () {
                            progressAnimateIsActive = true;
                            setState(() {
                              mailFormatStatus = AuthService().emailFormatControl(mailController.text);
                              if (mailFormatStatus) {
                                AuthService().passwordReset(mailController.text);

                                lottieController!.forward();
                              }
                            });

                            //forgotPassword();
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void forgotPassword() {
    mailController.clear();
    isMailSended = true;
  }
}
