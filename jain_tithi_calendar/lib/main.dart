import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'pages/calendar_page.dart';
import 'themes/app_theme.dart';

void main() {
  runApp(const JainTithiApp());
}

class JainTithiApp extends StatelessWidget {
  const JainTithiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690), // Base design size
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Jain Tithi Calendar',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          home: const CalendarPage(),
        );
      },
    );
  }
}
