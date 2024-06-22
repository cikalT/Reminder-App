import 'dart:async';
import 'package:alarm/alarm.dart';
import 'package:alarm/model/alarm_settings.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:its_reminder_app/views/alarm_list/alarm_list_view.dart';
import 'package:its_reminder_app/views/clock/clock_view.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with SingleTickerProviderStateMixin {
  final List<Tab> myTabs = <Tab>[
    const Tab(
      text: "Clock",
      icon: Icon(Icons.access_alarm, size: 35),
    ),
    const Tab(
      text: "Reminders",
      icon: Icon(Icons.checklist_outlined, size: 35),
    ),
  ];

  late TabController _tabController;
  static StreamSubscription<AlarmSettings>? subscription;

  @override
  void initState() {
    _tabController = TabController(vsync: this, length: myTabs.length);
    if (Alarm.android) {
      checkAndroidNotificationPermission();
      checkAndroidScheduleExactAlarmPermission();
    }
    subscription ??= Alarm.ringStream.stream.listen((alarmSettings) => navigateToRingScreen(
          alarmSettings,
        ));
    super.initState();
  }

  Future<void> navigateToRingScreen(AlarmSettings alarmSettings) async {
    {
      if (context.mounted) {
        context.push("/alarmRing", extra: alarmSettings);
      }
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        initialIndex: 0,
        length: myTabs.length,
        child: Column(
          children: [
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  Center(
                    child: ClockView(
                      callback: () {
                        _tabController.animateTo(1);
                      },
                    ),
                  ),
                  Center(
                    child: AlarmListView(
                      onClockPress: () {
                        _tabController.animateTo(0);
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 95,
              child: Container(
                margin: const EdgeInsets.only(bottom: 18),
                child: TabBar(
                  indicatorWeight: 15,
                  enableFeedback: true,
                  tabs: myTabs,
                  controller: _tabController,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> checkAndroidNotificationPermission() async {
    final status = await Permission.notification.status;
    if (status.isDenied) {
      alarmPrint('Requesting notification permission...');
      final res = await Permission.notification.request();
      alarmPrint(
        'Notification permission ${res.isGranted ? '' : 'not '}granted.',
      );
    }
  }
}

Future<void> checkAndroidNotificationPermission() async {
  final status = await Permission.notification.status;
  if (status.isDenied) {
    alarmPrint('Requesting notification permission...');
    final res = await Permission.notification.request();
    alarmPrint(
      'Notification permission ${res.isGranted ? '' : 'not '}granted.',
    );
  }
}

Future<void> checkAndroidExternalStoragePermission() async {
  final status = await Permission.storage.status;
  if (status.isDenied) {
    alarmPrint('Requesting external storage permission...');
    final res = await Permission.storage.request();
    alarmPrint(
      'External storage permission ${res.isGranted ? '' : 'not'} granted.',
    );
  }
}

Future<void> checkAndroidScheduleExactAlarmPermission() async {
  final status = await Permission.scheduleExactAlarm.status;
  alarmPrint('Schedule exact alarm permission: $status.');
  if (status.isDenied) {
    alarmPrint('Requesting schedule exact alarm permission...');
    final res = await Permission.scheduleExactAlarm.request();
    alarmPrint(
      'Schedule exact alarm permission ${res.isGranted ? '' : 'not'} granted.',
    );
  }
}
