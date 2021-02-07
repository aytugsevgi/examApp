import 'package:examapp/controllers/home_controller.dart';
import 'package:examapp/controllers/login_controller.dart';
import 'package:examapp/controllers/register_controller.dart';
import 'package:examapp/model/current_user.dart';
import 'package:examapp/model/instructor.dart';
import 'package:examapp/model/student.dart';
import 'package:examapp/utils/extension.dart';
import 'package:examapp/widget/custom_fade_transition.dart';
import 'package:examapp/widget/fade_route.dart';
import 'package:examapp/widget/loading_view.dart';
import 'package:examapp/widget/responsive_widget.dart';
import 'package:examapp/widget/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:provider/provider.dart';

class RegisterView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomFadeTransition(
        child: Row(
      children: [
        AnimatedContainer(
          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
          height: 650,
          duration: Duration(milliseconds: 200),
          width: ResponsiveWidget.isLargeScreen(context)
              ? context.dynamicWidth(0.4)
              : ResponsiveWidget.isMediumScreen(context)
                  ? context.dynamicWidth(0.5)
                  : context.dynamicWidth(0.7),
          child: Form(
            key: context.read<RegisterController>().formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Spacer(
                  flex: 6,
                ),
                Expanded(
                  flex: 8,
                  child: FittedBox(
                    child: Text(
                      "Register",
                      style: context.themeData.textTheme.title
                          .copyWith(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Divider(
                    thickness: 4,
                    color: context.themeData.buttonColor,
                    endIndent: 280,
                  ),
                ),
                Expanded(
                  flex: 11,
                  child: RichText(
                    textAlign: TextAlign.left,
                    text: TextSpan(
                        style: context.themeData.textTheme.subtitle1.copyWith(
                            fontSize: 14, color: Colors.black.withOpacity(0.7)),
                        text:
                            "Please register to you account to contunie with Online Team Management Tool."),
                  ),
                ),
                Expanded(
                  flex: 12,
                  child: TextFormField(
                      decoration: new InputDecoration(
                          hintText: "First Name",
                          errorStyle: context
                              .themeData.inputDecorationTheme.errorStyle
                              .copyWith(color: Colors.red.withOpacity(0.8))),
                      validator: (value) =>
                          context.read<RegisterController>().nameValidator(),
                      onChanged: (String value) {
                        context.read<RegisterController>().name = value;
                      }),
                ),
                Expanded(
                  flex: 12,
                  child: TextFormField(
                      decoration: new InputDecoration(
                          hintText: "Last Name",
                          errorStyle: context
                              .themeData.inputDecorationTheme.errorStyle
                              .copyWith(color: Colors.red.withOpacity(0.8))),
                      validator: (value) => context
                          .read<RegisterController>()
                          .lastnameValidator(),
                      onChanged: (String value) {
                        context.read<RegisterController>().lastname = value;
                      }),
                ),
                Expanded(
                  flex: 12,
                  child: TextFormField(
                      decoration: new InputDecoration(
                          hintText: "Email Address",
                          errorStyle: context
                              .themeData.inputDecorationTheme.errorStyle
                              .copyWith(color: Colors.red.withOpacity(0.8))),
                      validator: (value) =>
                          context.read<RegisterController>().emailValidator(),
                      onChanged: (String value) {
                        context.read<RegisterController>().email = value;
                      }),
                ),
                Expanded(
                  flex: 12,
                  child: TextFormField(
                      obscureText: true,
                      decoration: new InputDecoration(
                          hintText: "Password",
                          errorStyle: context
                              .themeData.inputDecorationTheme.errorStyle
                              .copyWith(color: Colors.red.withOpacity(0.8))),
                      validator: (value) => context
                          .read<RegisterController>()
                          .passwordValidator(),
                      onChanged: (String value) {
                        context.read<RegisterController>().password = value;
                      }),
                ),
                Expanded(
                    flex: 12,
                    child: TextFormField(
                        obscureText: true,
                        decoration: new InputDecoration(
                            hintText: "Confirm Password",
                            errorStyle: context
                                .themeData.inputDecorationTheme.errorStyle
                                .copyWith(color: Colors.red.withOpacity(0.8))),
                        validator: (value) => context
                            .read<RegisterController>()
                            .confirmPasswordValidator(),
                        onChanged: (String value) {
                          context.read<RegisterController>().confirmPassword =
                              value;
                        })),
                Expanded(
                  flex: 10,
                  child: Align(
                    alignment: Alignment.center,
                    child: LiteRollingSwitch(
                      //initial value

                      animationDuration: Duration(milliseconds: 500),
                      value: true,
                      textOn: 'Student',
                      textOff: 'Teacher',
                      colorOn: context.themeData.accentColor,
                      colorOff: context.themeData.primaryColor,
                      iconOn: null,
                      iconOff: null,
                      textSize: 16.0,
                      onChanged: (bool state) {
                        context.read<RegisterController>().isStudent = state;
                      },
                    ),
                  ),
                ),
                Spacer(flex: 2),
                Expanded(
                  flex: 14,
                  child: Center(
                    child: SubmitButton(
                      colors: [
                        context.themeData.primaryColor,
                        context.themeData.primaryColor
                      ],
                      child: Text(
                        "Sign Up",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 26),
                      ),
                      onTap: () async {
                        await onTapSignUp(context);
                      },
                    ),
                  ),
                ),
                Expanded(
                  flex: 10,
                  child: Center(
                    child: InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () =>
                          Provider.of<HomeController>(context, listen: false)
                              .homeSelectedView = HomeSelectedView.Login,
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Already have an account\n",
                              style: context.themeData.textTheme.bodyText1
                                  .copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: "LOGIN",
                              style: context.themeData.textTheme.bodyText1
                                  .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: context.themeData.buttonColor),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Spacer(flex: 2),
              ],
            ),
          ),
        ),
      ],
    ));
  }

  onTapSignUp(BuildContext context) async {
    Navigator.push(
        context, TransparentRoute(builder: (context) => LoadingView()));
    bool isRegister = await context.read<RegisterController>().register();

    if (isRegister) {
      var user = await context.read<LoginController>().currentUser();

      Navigator.pop(context);
      CurrentUser.currentUser = user;
      if (user is Instructor) {
        context.read<HomeController>().homeSelectedView =
            HomeSelectedView.Instructor;
      } else if (user is Student) {
        context.read<HomeController>().homeSelectedView =
            HomeSelectedView.Student;
      } else {
        context.read<HomeController>().homeSelectedView =
            HomeSelectedView.Welcome;
      }
    } else {
      Navigator.pop(context);
    }
  }
}
