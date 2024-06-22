import 'package:alarm/model/alarm_settings.dart';
import 'package:go_router/go_router.dart';
import 'package:its_reminder_app/views/alarm_crud/alarm_crud_view.dart';
import 'package:its_reminder_app/views/alarm_ring/alarm_ring_view.dart';
import 'package:its_reminder_app/views/clock/clock_view.dart';
import 'package:its_reminder_app/views/home/home_view.dart';

class AppRoutes {
  final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: "/",
        builder: (context, state) => const HomeView(),
      ),
      GoRoute(
        path: "/clock",
        builder: (context, state) => ClockView(
          callback: () {},
        ),
      ),
      GoRoute(
        path: "/alarmList",
        builder: (context, state) => const AlarmListView(
          alarmSettings: null,
        ),
      ),
      GoRoute(
        path: "/alarmRing",
        builder: (context, state) {
          AlarmSettings alarmSettings = state.extra as AlarmSettings;
          return AlarmRingView(
            alarmSettings: alarmSettings,
          );
        },
      ),
    ],
  );
}
