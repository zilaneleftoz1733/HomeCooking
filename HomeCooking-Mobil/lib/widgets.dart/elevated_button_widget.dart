import 'package:flutter/material.dart';

class ElevatedButtonWidget extends StatelessWidget {
  const ElevatedButtonWidget({
    required this.buttonTitle,
    required this.buttonColor,
    required this.buttonTextStyle,
    required this.buttonMetod,
    Key? key,
  }) : super(key: key);

  final String buttonTitle;
  final Color buttonColor;
  final TextStyle buttonTextStyle;
  final VoidCallback buttonMetod;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
          child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(buttonColor),
              ),
              onPressed: buttonMetod,
              child: SizedBox(
                  height: 50,
                  child: Center(
                      child: Text(
                    buttonTitle,
                    style: buttonTextStyle,
                  )))))
    ]);
  }
}