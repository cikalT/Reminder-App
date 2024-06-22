import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:its_reminder_app/configs/app_cubit.dart';
import 'package:its_reminder_app/utils/app_colors.dart';

Container NoAlarmWidget(BuildContext context) {
  return Container(
    margin: const EdgeInsets.only(bottom: 42),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 30),
          child: Text(
            "There is no Reminder",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
        ),
        GestureDetector(
          onTap: () {
            context.read<AppCubit>().navigateToAlarmScreen(null, context);
          },
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.blueColor,
              border: Border.all(
                color: AppColors.whiteColor,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            margin: const EdgeInsets.only(top: 24),
            child: const Padding(
              padding: EdgeInsets.only(top: 12, right: 40, left: 40, bottom: 12),
              child: Text(
                "Create",
                style: TextStyle(color: AppColors.whiteColor, fontSize: 34, fontWeight: FontWeight.w700),
              ),
            ),
          ),
        )
      ],
    ),
  );
}
