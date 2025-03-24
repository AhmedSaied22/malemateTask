import 'package:flutter/material.dart';
import 'package:mealmate/core/extensions/font_styles_extensions.dart';
import 'package:mealmate/core/extensions/media_query_extensions.dart';
import 'package:mealmate/core/images/app_images.dart';
import 'package:mealmate/core/routes/routes_name.dart';
import 'package:mealmate/core/ui/app_colors.dart';
import 'package:mealmate/core/utils/app_strings.dart';
import 'package:mealmate/features/splash/presentation/views/widgets/splash_image.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody> {
  @override
  void initState() {
    super.initState();
    navigateToHome();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          const Positioned(
            top: -15,
            right: -90,
            child: SplashImage(
              imagePath: Assets.fruits,
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
                    AppStrings.splashSubTitle,
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
    );
  }

  void navigateToHome() {
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.of(context).pushReplacementNamed(RoutesName.home);
      }
    });
  }
}
