import 'package:flutter/material.dart';

class Images {
  static String loginWallpaper = "images/login_image_2.jpg";
  static String noImage = "images/no-image.jpg";
}

extension StringExtensions on String {
  DecorationImage asDecorationImage({BoxFit? fit, double? opacity}) {
    bool validURL = Uri.parse(this).isAbsolute;

    if (validURL) {
      return DecorationImage(
          image: Image.network(this).image,
          fit: fit ?? BoxFit.cover,
          opacity: opacity ?? 1);
    } else {
      return DecorationImage(
          image: Image.asset(this).image,
          fit: fit ?? BoxFit.cover,
          opacity: opacity ?? 1);
    }
  }
}
