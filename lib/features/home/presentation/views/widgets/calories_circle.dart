import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mealmate/core/extensions/font_styles_extensions.dart';
import 'package:mealmate/core/extensions/media_query_extensions.dart';
import 'package:mealmate/core/ui/app_styles_fonts.dart';

class CalorieCircle extends StatelessWidget {
  final int calories;
  final int goal;

  const CalorieCircle({
    super.key,
    required this.calories,
    required this.goal,
  });

  @override
  Widget build(BuildContext context) {
    // Calculate progress (0.0 to 1.0)
    final double progress = (calories / goal).clamp(0.0, 1.0);

    return Container(
      padding: EdgeInsets.all(2.w),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ),
      child: Center(
        child: SizedBox(
          width: context.screenWidth * 0.42,
          height: context.screenHeight * 0.24,
          child: Stack(
            alignment: Alignment.center,
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: CircularProgressIndicator(
                  value: progress,
                  strokeWidth: 24,
                  backgroundColor: Colors.grey.shade300,
                  strokeCap: StrokeCap.round,
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Calories', style: context.textStyle(size: 14)),
                  Text(
                    '$calories',
                    style: context.textStyle(
                        size: 36, fontFamily: AppFonts.secondaryFont),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Goal $goal',
                    style: context.bodyMedium.copyWith(color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
