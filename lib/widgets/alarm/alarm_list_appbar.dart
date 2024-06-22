import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:its_reminder_app/configs/app_cubit.dart';
import 'package:its_reminder_app/utils/app_colors.dart';

Container AlarmListAppBar(BuildContext contex, void Function()? onClockPress) {
  return Container(
    height: 35,
    margin: const EdgeInsets.only(top: 55, left: 20, right: 20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: onClockPress,
          child: Container(
            width: 35,
            height: 35,
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: AppColors.whiteColor.withOpacity(0.5),
                spreadRadius: 4,
                blurRadius: 6,
                offset: const Offset(0, 0),
              ),
            ], borderRadius: BorderRadius.circular(100), color: AppColors.whiteColor),
            child: const Icon(
              Icons.access_time,
              size: 22,
            ),
          ),
        ),
        GestureDetector(
          onTap: () => contex.read<AppCubit>().navigateToAlarmScreen(null, contex),
          child: Container(
            width: 35,
            height: 35,
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: AppColors.whiteColor.withOpacity(0.5),
                spreadRadius: 4,
                blurRadius: 6,
                offset: const Offset(0, 0),
              ),
            ], borderRadius: BorderRadius.circular(100), color: AppColors.whiteColor),
            child: const Icon(
              Icons.alarm_add_outlined,
            ),
          ),
        ),
      ],
    ),
  );
}
