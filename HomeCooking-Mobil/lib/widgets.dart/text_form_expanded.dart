import 'package:flutter/material.dart';

class TextFormExpanded extends StatelessWidget {
  const TextFormExpanded({
    Key? key,
    required this.textFormController,
    required this.hintText,
    required this.formIcon,
    required this.textClicked,
    this.textFieldIsPassword = false,
  }) : super(key: key);

  final TextEditingController textFormController;
  final String hintText;
  final IconData formIcon;
  final IconData? formSuffixIcon = null;
  final VoidCallback textClicked;
  final textFieldIsPassword;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      minLines: 10,
      maxLines: 15,
      onTap: () {
        textClicked();
      },
      style: const TextStyle(color: Colors.white),
      controller: textFormController,
      autofocus: false,
      obscureText: textFieldIsPassword ? true : false,
      decoration: InputDecoration(
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.white,
        )),
        hoverColor: Colors.white,
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.white),
        contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, -50, 10.0),
        border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
        suffixIcon: Icon(formSuffixIcon, color: Colors.white),
      ),
    );
  }
}
