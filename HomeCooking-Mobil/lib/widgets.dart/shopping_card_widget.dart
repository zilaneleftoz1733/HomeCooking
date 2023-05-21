import 'package:flutter/material.dart';
import 'package:projectmanagement/utils/color_items.dart';
import 'package:projectmanagement/widgets.dart/favorite_button_widget.dart';
import 'package:projectmanagement/widgets.dart/order_button_widget.dart';

class ShoppingCardWidget extends StatelessWidget {
  ShoppingCardWidget({
    Key? key,
    required this.hazirlanmaSuresi,
    required this.urunTutari,
    required this.urunGorsel,
    required this.urunIsmi,
    required this.docId,
  }) : super(key: key);
  final String docId;
  final String hazirlanmaSuresi;
  final String urunGorsel;
  final String urunIsmi;
  final String urunTutari;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 0),
      child: InkWell(
        onTap: () {},
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(11.0),
            color: ColorItems.softGreyColor,
          ),
          height: 170,
          width: 160,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(image: DecorationImage(fit: BoxFit.cover, image: NetworkImage(urunGorsel))),
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(urunIsmi,
                            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Text(
                            "$urunTutari \$",
                            style: const TextStyle(
                                color: ColorItems.generalTurquaseColor, fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Expanded(
                    child: SizedBox(
                      width: 50,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Column(
                      children: [
                        FavoriteButtonWidget(
                          docId: docId,
                          urunIsmi: urunIsmi,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        OrderButtonWidget(urunIsmi: urunIsmi, docId: docId)
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
