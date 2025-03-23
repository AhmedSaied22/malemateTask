import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mealmate/core/extensions/font_styles_extensions.dart';
import 'package:mealmate/core/extensions/media_query_extensions.dart';
import 'package:mealmate/core/images/app_images.dart';
import 'package:mealmate/core/ui/app_colors.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            const Positioned(
              top: -15,
              right: -90,
              child: SplashImage(
                imagePath: Assets.vegetablesA,
                angle: -0.7,
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        style: context.headingLarge,
                        children: [
                          const TextSpan(
                            text: 'Meal',
                          ),
                          TextSpan(
                            text: 'Mate',
                            style: context.headingLarge
                                .copyWith(color: AppColors.secondaryTextColor),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Lose weight, tone up, get healthy, change your habits, or start a new diet.',
                      style: context.bodyMedium,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: SplashImage(
                imagePath: Assets.vegetablesB,
                imageHeight: context.screenHeight * 0.3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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
