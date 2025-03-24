import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mealmate/core/extensions/font_styles_extensions.dart';
import 'package:mealmate/core/extensions/media_query_extensions.dart';
import 'package:mealmate/core/ui/app_colors.dart';
import 'package:mealmate/features/home/presentation/views/widgets/day_filter.dart';

class HomeViewGreenContainer extends StatefulWidget {
  const HomeViewGreenContainer({
    super.key,
  });

  @override
  State<HomeViewGreenContainer> createState() => _HomeViewGreenContainerState();
}

class _HomeViewGreenContainerState extends State<HomeViewGreenContainer> {
  late List<DateTime> _days;
  late DateTime _selectedDay;

  @override
  void initState() {
    super.initState();
    _days = List.generate(
      5,
      (index) => DateTime.now().add(Duration(days: index)),
    );
    _selectedDay = _days[0];
  }

  void _onDaySelected(DateTime day) {
    setState(() {
      _selectedDay = day;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.screenHeight * 0.37,
      padding: EdgeInsets.only(top: 32.h, left: 8.w, right: 8.w, bottom: 4.h),
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(155.r),
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
