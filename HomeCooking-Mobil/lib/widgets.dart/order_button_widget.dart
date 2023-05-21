import 'package:flutter/material.dart';
import 'package:projectmanagement/services/favorite_service.dart';
import 'package:projectmanagement/services/order_service.dart';

class OrderButtonWidget extends StatefulWidget {
  OrderButtonWidget({
    Key? key,
    required this.urunIsmi,
    required this.docId,
    this.iconSize = 24,
  }) : super(key: key);

  final String urunIsmi;
  final String docId;
  final OrderService _orderService = OrderService();
  final double iconSize;
  @override
  State<OrderButtonWidget> createState() => _OrderButtonWidgetState();
}

class _OrderButtonWidgetState extends State<OrderButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget._orderService.countDocuments(widget.urunIsmi),
      builder: (context, snapshot) {
        return GestureDetector(
            onTap: () {
              setState(() {
                if (snapshot.data == true) {
                  widget._orderService.removeOrders(widget.docId);
                } else {
                  widget._orderService.addToOrders(widget.docId);
                }
              });
            },
            child: snapshot.data == true
                ? Icon(
                    Icons.shopping_basket_sharp,
                    color: Colors.green,
                    size: widget.iconSize,
                  )
                : Icon(
                    Icons.shopping_basket_outlined,
                    color: Colors.white,
                    size: widget.iconSize,
                  ));
      },
    );
  }
}
