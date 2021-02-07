import 'package:examapp/controllers/home_controller.dart';
import 'package:examapp/model/instructor.dart';
import 'package:examapp/model/student.dart';

import 'package:examapp/views/home_view/instructor_home_view.dart';
import 'package:examapp/views/home_view/login_view.dart';
import 'package:examapp/views/home_view/register_view.dart';
import 'package:examapp/views/home_view/student_home_view.dart';
import 'package:examapp/views/home_view/welcome_view.dart';
import 'package:examapp/widget/custom_fade_transition.dart';
import 'package:examapp/widget/loading_view.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomFadeTransition(
      child: _getBody(context),
    );
  }

  Widget _getBody(BuildContext context) {
    HomeSelectedView selectedView =
        Provider.of<HomeController>(context, listen: true).homeSelectedView;

    switch (selectedView) {
      case HomeSelectedView.Welcome:
        return WelcomeView();
        break;
      case HomeSelectedView.Login:
        return LoginView();
        break;
      case HomeSelectedView.Register:
        return RegisterView();
        break;
      case HomeSelectedView.Instructor:
        return InstructorHomeView();
        break;
      case HomeSelectedView.Student:
        return StudentHomeView();
        break;
      default:
        return WelcomeView();
    }
  }
}
