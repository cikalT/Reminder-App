import 'package:alarm/model/alarm_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:its_reminder_app/configs/app_cubit.dart';
import 'package:its_reminder_app/utils/app_colors.dart';

Widget AlarmItem(BuildContext context, AlarmSettings alarmItem, int index, bool toggleValue) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: AppColors.blackColor),
    ),
    child: Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: GestureDetector(
        onTap: () => context.read<AppCubit>().navigateToAlarmScreen(alarmItem, context),
        child: Dismissible(
          onDismissed: (direction) {
            if (direction == DismissDirection.startToEnd) {
              context.read<AppCubit>().deleteAlarm(alarmItem.id, context);
            }
          },
          direction: DismissDirection.startToEnd,
          key: UniqueKey(),
          background: Container(
            height: 70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(0),
            ),
            alignment: Alignment.centerLeft,
            child: const Padding(
              padding: EdgeInsets.only(
                left: 10,
              ),
              child: Icon(
                Icons.delete,
                color: AppColors.whiteColor,
                size: 35,
              ),
            ),
          ),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  " ${alarmItem.dateTime.hour}:${alarmItem.dateTime.minute}",
                  style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
                ),
                Switch(
                  value: toggleValue,
                  focusColor: AppColors.redColor,
                  activeColor: AppColors.redColor,
                  inactiveThumbColor: AppColors.greyColor,
                  onChanged: (value) {
                    context.read<AppCubit>().onTogglePressed(alarmItem.id, index, toggleValue);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
