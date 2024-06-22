import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:its_reminder_app/configs/app_cubit.dart';
import 'package:its_reminder_app/utils/app_colors.dart';
import 'package:its_reminder_app/widgets/alarm/alarm_item.dart';
import 'package:its_reminder_app/widgets/alarm/alarm_list_appbar.dart';
import 'package:its_reminder_app/widgets/alarm/no_alarm_widget.dart';
import 'package:its_reminder_app/widgets/clock/clock_widget.dart';
import 'package:lottie/lottie.dart';

class ClockView extends StatefulWidget {
  const ClockView({super.key, required this.callback});
  final void Function() callback;
  @override
  State<ClockView> createState() => _ClockViewState();
}

class _ClockViewState extends State<ClockView> {
  @override
  void initState() {
    context.read<AppCubit>().getIP();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            AlarmListAppBar(context, null),
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: ClockWidget(),
            ),
            Container(
              child: state.countryTimeZone == ""
                  ? Lottie.asset('assets/lottie/it_is_loading.json', height: 55)
                  : Container(
                      height: 40,
                      margin: const EdgeInsets.only(top: 18),
                      child: Text(
                        state.countryTimeZone,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 20, left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (state.alarmList.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(left: 0, top: 55, bottom: 10, right: 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "REMINDER",
                              style: TextStyle(color: AppColors.blueColor, fontSize: 12, fontWeight: FontWeight.w700, letterSpacing: 1.3),
                            ),
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: InkWell(
                                onTap: widget.callback,
                                child: const Text(
                                  "ALL",
                                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, letterSpacing: 1.3),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    const SizedBox(
                      height: 12,
                    ),
                    if (state.alarmList.isEmpty)
                      NoAlarmWidget(context)
                    else
                      Expanded(
                        child: SizedBox(
                          height: 90,
                          width: double.infinity,
                          child: ListView.separated(
                            padding: const EdgeInsets.only(top: 0),
                            shrinkWrap: true,
                            itemCount: state.alarmList.length,
                            itemBuilder: (context, index) {
                              final alarmItem = state.alarmList[index];
                              final toggleValue = state.activeAlarmList.contains(alarmItem);
                              return AlarmItem(context, alarmItem, index, toggleValue);
                            },
                            separatorBuilder: (BuildContext context, int index) {
                              return const SizedBox(
                                height: 10,
                              );
                            },
                          ),
                        ),
                      )
                  ],
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
