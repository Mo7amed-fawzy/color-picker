// import 'dart:ui';
// import 'package:image/image.dart' as img;
// import 'package:flutter/material.dart';

// /// Helpers to convert image-local coordinates into pixel coordinates
// /// and extract a Color from an `image` (package:image).

// /// Calculate displayed size of the image inside a box when using BoxFit.contain logic.
// Size _calculateDisplayedSize(double imageW, double imageH, Size boxSize) {
//   final imageAspect = imageW / imageH;
//   final boxAspect = boxSize.width / boxSize.height;

//   double displayedWidth, displayedHeight;
//   if (imageAspect > boxAspect) {
//     displayedWidth = boxSize.width;
//     displayedHeight = displayedWidth / imageAspect;
//   } else {
//     displayedHeight = boxSize.height;
//     displayedWidth = displayedHeight * imageAspect;
//   }

//   return Size(displayedWidth, displayedHeight);
// }

// /// Given a local position inside the box (top-left = (0,0) of the rendered image container),
// /// and the image object, compute the pixel color if the position is on the rendered image area.
// /// Returns null when position is outside the displayed image.
// Color? getColorFromImageAtLocalPosition({
//   required img.Image image,
//   required Size boxSize,
//   required Offset localPosition,
// }) {
//   final displayed = _calculateDisplayedSize(
//     image.width.toDouble(),
//     image.height.toDouble(),
//     boxSize,
//   );

//   final offsetX = (boxSize.width - displayed.width) / 2;
//   final offsetY = (boxSize.height - displayed.height) / 2;

//   final relativeX = localPosition.dx - offsetX;
//   final relativeY = localPosition.dy - offsetY;

//   if (relativeX < 0 ||
//       relativeY < 0 ||
//       relativeX >= displayed.width ||
//       relativeY >= displayed.height) {
//     return null;
//   }

//   final pixelX = (relativeX * (image.width / displayed.width)).toInt();
//   final pixelY = (relativeY * (image.height / displayed.height)).toInt();

//   if (pixelX < 0 ||
//       pixelX >= image.width ||
//       pixelY < 0 ||
//       pixelY >= image.height)
//     return null;

//   final pixel = image.getPixel(pixelX, pixelY);
//   return Color.fromARGB(
//     pixel.a.toInt(),
//     pixel.r.toInt(),
//     pixel.g.toInt(),
//     pixel.b.toInt(),
//   );
// }
