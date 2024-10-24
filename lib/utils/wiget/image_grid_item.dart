import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ImageGridItem extends StatelessWidget{
  final String imageUrl;

  const ImageGridItem({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: BoxFit.cover,
      placeholder: (context, url) => Center(child: CircularProgressIndicator()),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
  }
}