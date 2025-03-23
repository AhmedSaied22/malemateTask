import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mealmate/core/extensions/media_query_extensions.dart';

class SplashImage extends StatelessWidget {
  const SplashImage({
    super.key,
    required this.imagePath,
    this.imageHeight,
    this.angle,
  });
  final String imagePath;
  final double? imageHeight;
  final double? angle;
  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: angle ?? 0,
      child: SvgPicture.asset(
        imagePath,
        height: imageHeight ?? context.screenHeight * 0.25,
      ),
    );
  }
}
