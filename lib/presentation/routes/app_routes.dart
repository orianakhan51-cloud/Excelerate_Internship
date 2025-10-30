import 'package:flutter/material.dart';
import '../presentation/home_dashboard/home_dashboard.dart';
import '../presentation/login_screen/login_screen.dart';
import '../presentation/profile_settings/profile_settings.dart';
import '../presentation/course_detail/course_detail.dart';
import '../presentation/registration_screen/registration_screen.dart';
import '../presentation/course_catalog/course_catalog.dart';

class AppRoutes {
  // TODO: Add your routes here
  static const String initial = '/';
  static const String homeDashboard = '/home-dashboard';
  static const String login = '/login-screen';
  static const String profileSettings = '/profile-settings';
  static const String courseDetail = '/course-detail';
  static const String registration = '/registration-screen';
  static const String courseCatalog = '/course-catalog';

  static Map<String, WidgetBuilder> routes = {
    initial: (context) => const LoginScreen(),
    homeDashboard: (context) => const HomeDashboard(),
    login: (context) => const LoginScreen(),
    profileSettings: (context) => const ProfileSettings(),
    courseDetail: (context) => const CourseDetail(),
    registration: (context) => const RegistrationScreen(),
    courseCatalog: (context) => const CourseCatalog(),
    // TODO: Add your other routes here
  };
}
