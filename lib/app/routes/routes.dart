import 'package:flutter/widgets.dart';
import 'package:task_manager_app/app/bloc/app_bloc.dart';
import 'package:task_manager_app/home/view/home_page.dart';
import 'package:task_manager_app/login/view/login_page.dart';

List<Page<dynamic>> onGenerateAppViewPages(
  AppStatus state,
  List<Page<dynamic>> pages,
) {
  switch (state) {
    case AppStatus.authenticated:
      return [HomePage.page()];
    case AppStatus.unauthenticated:
      return [LoginPage.page()];
  }
}
