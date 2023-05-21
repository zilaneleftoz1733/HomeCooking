import 'package:flutter/material.dart';
import 'package:projectmanagement/services/favorite_service.dart';

class FavoriteButtonWidget extends StatefulWidget {
  FavoriteButtonWidget({
    Key? key,
    required this.urunIsmi,
    required this.docId,
    this.iconSize = 24,
  }) : super(key: key);

  final String urunIsmi;
  final String docId;
  final FavoriteService _favoriteService = FavoriteService();
  final double iconSize;
  @override
  State<FavoriteButtonWidget> createState() => _FavoriteButtonWidgetState();
}

class _FavoriteButtonWidgetState extends State<FavoriteButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget._favoriteService.countDocuments(widget.urunIsmi),
      builder: (context, snapshot) {
        return GestureDetector(
          onTap: () {
            setState(() {
              if (snapshot.data == true) {
                widget._favoriteService.removeFavorite(widget.docId);
              } else {
                widget._favoriteService.addToFavorite(widget.docId);
              }
            });
          },
          child: snapshot.data == true
              ? Icon(
                  Icons.favorite,
                  color: Colors.red,
                  size: widget.iconSize,
                )
              : Icon(
                  Icons.favorite_border,
                  color: Colors.red,
                  size: widget.iconSize,
                ),
        );
      },
    );
  }
}
