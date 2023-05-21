import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projectmanagement/services/date_service.dart';
import 'package:projectmanagement/utils/color_items.dart';
import 'package:projectmanagement/utils/image_items.dart';
import 'package:projectmanagement/widgets.dart/favorite_button_widget.dart';
import 'package:projectmanagement/widgets.dart/order_button_widget.dart';

class OrderCardWidget extends StatelessWidget {
  const OrderCardWidget({
    Key? key,
    required this.orderDate,
    required this.orderPrice,
    required this.orderStatus,
    required this.orders,
    required this.userAdress,
  }) : super(key: key);
  final Timestamp orderDate;
  final String orderPrice;
  final String orderStatus;
  final List orders;
  final String userAdress;

  void showAlertDialog(BuildContext context, String message) {
    var size = MediaQuery.of(context).size;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: ColorItems.softGreyColor,
          title: Text(
            "Order Details",
            style: TextStyle(color: ColorItems.generalTurquaseColor),
          ),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                height: 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (int x = 1; x <= orders.length; x++) ...[
                      Text(
                        orders[x - 1],
                        style: const TextStyle(color: Colors.white),
                      )
                    ],
                  ],
                ),
              ),
              SizedBox(
                width: size.width * 0.3,
                child: Image(
                  image: ImageItems.orderIcon,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 0),
      child: InkWell(
        onTap: () {
          showAlertDialog(context, "");
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(11.0),
            color: ColorItems.softGreyColor,
          ),
          height: 170,
          width: 160,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Container(
                  padding: EdgeInsets.only(bottom: 15),
                  height: 140,
                  child: Row(
                    children: [
                      Image(image: ImageItems.orderIcon),
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("Status: $orderStatus",
                                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
                            Text(
                              "Order Price: $orderPrice \$",
                              style: const TextStyle(
                                  color: ColorItems.generalTurquaseColor, fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            Text("Date: ${DateService().convertTimeStampToString(orderDate)}",
                                style:
                                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.orange)),
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
                            SizedBox(
                              height: 8,
                            ),
                          ],
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
    );
  }
}
