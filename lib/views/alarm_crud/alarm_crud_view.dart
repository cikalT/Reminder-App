import 'package:alarm/model/alarm_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:its_reminder_app/configs/app_cubit.dart';
import 'package:its_reminder_app/utils/app_colors.dart';

class AlarmListView extends StatefulWidget {
  final AlarmSettings? alarmSettings;

  const AlarmListView({super.key, this.alarmSettings});

  @override
  State<AlarmListView> createState() => _ExampleAlarmEditScreenState();
}

class _ExampleAlarmEditScreenState extends State<AlarmListView> {
  @override
  void initState() {
    super.initState();
    context.read<AppCubit>().initState(widget.alarmSettings);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: const Text(
                      "Cancel",
                      style: TextStyle(color: AppColors.redColor, fontSize: 18),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      context.read<AppCubit>().saveAlarm(context, widget.alarmSettings?.id);
                    },
                    child: state.loading
                        ? const CircularProgressIndicator()
                        : const Text(
                            "Save",
                            style: TextStyle(color: AppColors.blueColor, fontSize: 18),
                          ),
                  ),
                ],
              ),
              Text(
                context.read<AppCubit>().getDay(),
                style: Theme.of(context).textTheme.titleMedium!.copyWith(color: AppColors.blackColor),
              ),
              RawMaterialButton(
                onPressed: () => context.read<AppCubit>().pickTime(context),
                child: Container(
                  margin: const EdgeInsets.all(20),
                  child: Text(
                    TimeOfDay.fromDateTime(state.selectedDateTime).format(context),
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(),
                  ),
                ),
              ),
              TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'About',
                ),
                onChanged: (value) => context.read<AppCubit>().setAbout(value),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Loop reminder audio',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(),
                  ),
                  Switch(
                    value: state.loopAudio,
                    focusColor: AppColors.redColor,
                    activeColor: AppColors.redColor,
                    inactiveThumbColor: AppColors.greyColor,
                    onChanged: (value) => context.read<AppCubit>().loopSwitch(value),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Vibrate',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(),
                  ),
                  Switch(
                    value: state.vibrate,
                    focusColor: AppColors.redColor,
                    activeColor: AppColors.redColor,
                    inactiveThumbColor: AppColors.greyColor,
                    onChanged: (value) => context.read<AppCubit>().setVibrate(value),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Sound',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(),
                  ),
                  DropdownButton(
                    value: state.assetAudio,
                    underline: const SizedBox(),
                    isDense: true,
                    icon: const SizedBox(),
                    alignment: Alignment.centerRight,
                    borderRadius: BorderRadius.circular(12),
                    dropdownColor: AppColors.whiteColor,
                    items: context.read<AppCubit>().dropDownItemList,
                    onChanged: (value) => context.read<AppCubit>().setAssetAudio(value!),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Set Individual volume', style: Theme.of(context).textTheme.titleMedium),
                  Switch(
                    value: state.volume != null,
                    focusColor: AppColors.redColor,
                    activeColor: AppColors.redColor,
                    inactiveThumbColor: AppColors.greyColor,
                    onChanged: (value) => setState(() => state.volume = value ? 0.5 : null),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
                child: state.volume != null
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            state.volume! > 0.7
                                ? Icons.volume_up_rounded
                                : state.volume! > 0.1
                                    ? Icons.volume_down_rounded
                                    : Icons.volume_mute_rounded,
                            color: AppColors.whiteColor,
                          ),
                          Expanded(
                            child: Slider(
                              activeColor: AppColors.blueColor,
                              inactiveColor: AppColors.greyColor,
                              value: state.volume!,
                              onChanged: (value) {
                                setState(() => state.volume = value);
                              },
                            ),
                          ),
                        ],
                      )
                    : const SizedBox(),
              ),
              if (!state.creating)
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: AppColors.redColor,
                  ),
                  child: TextButton(
                    onPressed: () {
                      context.read<AppCubit>().deleteAlarm(widget.alarmSettings!.id, context);
                      Navigator.pop(context);
                    },
                    child: const Text('Delete Alarm',
                        style: TextStyle(color: AppColors.whiteColor, fontSize: 16, fontWeight: FontWeight.w700)),
                  ),
                ),
              const SizedBox(),
            ],
          ),
        );
      },
    );
  }
}
