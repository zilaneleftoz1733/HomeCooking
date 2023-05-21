import 'package:flutter/material.dart';

class CustomSearchForm extends StatelessWidget {
  const CustomSearchForm({
    Key? key,
    required this.textFormController,
    required this.hintText,
    required this.formIcon,
    required this.textClicked,
    this.focusNode,
  }) : super(key: key);

  final TextEditingController textFormController;
  final String hintText;
  final IconData formIcon;
  final IconData? formSuffixIcon = null;
  final VoidCallback textClicked;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: () {},
      style: const TextStyle(color: Colors.white),
      controller: textFormController,
      focusNode: focusNode,
      autofocus: false,
      decoration: InputDecoration(
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.white,
        )),
        hoverColor: Colors.white,
        hintText: hintText,
        suffixIcon: GestureDetector(
          onTap: () {
            textClicked();
          },
          child: const Icon(
            Icons.search,
            color: Colors.white,
          ),
        ),
        hintStyle: const TextStyle(color: Colors.white),
        contentPadding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
      ),
    );
  }
}
