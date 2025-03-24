import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mealmate/core/extensions/font_styles_extensions.dart';
import 'package:mealmate/core/extensions/media_query_extensions.dart';
import 'package:mealmate/core/ui/app_colors.dart';
import 'package:mealmate/features/home/presentation/views/widgets/calories_circle.dart';
import 'package:mealmate/features/home/presentation/views/widgets/day_filter.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            const HomeScreenGreenContainer(),
            Positioned(
                bottom: -context.screenHeight * 0.12,
                left: 0,
                right: 0,
                child: const CalorieCircle(calories: 1122, goal: 2000)),
          ],
        ),
      ],
    ));
  }
}

class HomeScreenGreenContainer extends StatefulWidget {
  const HomeScreenGreenContainer({
    super.key,
  });

  @override
  State<HomeScreenGreenContainer> createState() =>
      _HomeScreenGreenContainerState();
}

class _HomeScreenGreenContainerState extends State<HomeScreenGreenContainer> {
  late List<DateTime> _days;
  late DateTime _selectedDay;

  @override
  void initState() {
    super.initState();
    _days = List.generate(
      5,
      (index) => DateTime.now().add(Duration(days: index)),
    );
    _selectedDay = _days[0]; // Default selected day
  }

  void _onDaySelected(DateTime day) {
    setState(() {
      _selectedDay = day;
    });
    // TODO: Filter your meals data based on the selected day
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.screenHeight * 0.4,
      padding: EdgeInsets.only(top: 28.h, left: 8.w, right: 8.w, bottom: 4.h),
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(162.r),
            bottomRight: Radius.circular(50.r)),
      ),
      child: Column(
        spacing: 12.h,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.filter_list,
                    size: 34,
                    color: Colors.white,
                  )),
              const Spacer(),
              Text(
                "MealMate",
                style: context.title.copyWith(color: Colors.white),
              ),
              const Spacer(),
            ],
          ),
          DayFilter(
            days: _days,
            selectedDay: _selectedDay,
            onDaySelected: _onDaySelected,
          ),
        ],
      ),
    );
  }
}
