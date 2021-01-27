import 'dart:ui';
import 'package:examapp/utils/extension.dart';
import 'package:examapp/widget/submit_button.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Spacer(
          flex: 2,
        ),
        Expanded(
          flex: 5,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            height: 600,
            child: Form(
              /*key:
                  Provider.of<SignUpController>(context, listen: false).formKey,*/
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Spacer(
                    flex: 8,
                  ),
                  Expanded(
                    flex: 6,
                    child: FittedBox(
                      child: Text(
                        "Register",
                        style: context.themeData.textTheme.title.copyWith(
                            fontWeight: FontWeight.bold, fontSize: 25),
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
                      text: TextSpan(
                          style: context.themeData.textTheme.subtitle1.copyWith(
                              fontSize: 14,
                              color: Colors.black.withOpacity(0.7)),
                          text:
                              "Please register to you account to contunie with Ege Examination System."),
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
                      /*validator: (value) => Provider.of<SignUpController>(
                                context,
                                listen: false)
                            .firstNameValidator(),
                        onChanged: (String value) {
                          Provider.of<SignUpController>(context, listen: false)
                              .firstName = value;
                        }*/
                    ),
                  ),
                  Expanded(
                    flex: 12,
                    child: TextFormField(
                      decoration: new InputDecoration(
                          hintText: "Last Name",
                          errorStyle: context
                              .themeData.inputDecorationTheme.errorStyle
                              .copyWith(color: Colors.red.withOpacity(0.8))),
                      /*validator: (value) => Provider.of<SignUpController>(
                                context,
                                listen: false)
                            .lastNameValidator(),
                        onChanged: (String value) {
                          Provider.of<SignUpController>(context, listen: false)
                              .lastName = value;
                        }*/
                    ),
                  ),
                  Expanded(
                    flex: 12,
                    child: TextFormField(
                      decoration: new InputDecoration(
                          hintText: "Email Address",
                          errorStyle: context
                              .themeData.inputDecorationTheme.errorStyle
                              .copyWith(color: Colors.red.withOpacity(0.8))),
                      /*validator: (value) => Provider.of<SignUpController>(
                                context,
                                listen: false)
                            .emailValidator(),
                        onChanged: (String value) {
                          Provider.of<SignUpController>(context, listen: false)
                              .email = value;
                        }*/
                    ),
                  ),
                  Expanded(
                    flex: 12,
                    child: TextFormField(
                      decoration: new InputDecoration(
                          hintText: "Password",
                          errorStyle: context
                              .themeData.inputDecorationTheme.errorStyle
                              .copyWith(color: Colors.red.withOpacity(0.8))),
                      /*validator: (value) => Provider.of<SignUpController>(
                                context,
                                listen: false)
                            .passwordValidator(),
                        onChanged: (String value) {
                          Provider.of<SignUpController>(context, listen: false)
                              .password = value;
                        }*/
                    ),
                  ),
                  Expanded(
                      flex: 12,
                      child: TextFormField(
                        decoration: new InputDecoration(
                            hintText: "Confirm Password",
                            errorStyle: context
                                .themeData.inputDecorationTheme.errorStyle
                                .copyWith(color: Colors.red.withOpacity(0.8))),
                        /*validator: (value) => Provider.of<SignUpController>(
                                  context,
                                  listen: false)
                              .confirmPasswordValidator(),
                          onChanged: (String value) {
                            Provider.of<SignUpController>(context,
                                    listen: false)
                                .confirmPassword = value;
                          }*/
                      )),
                  Expanded(
                    flex: 14,
                    child: Center(
                        child: SubmitButton(
                            colors: [
                          context.themeData.buttonColor,
                          context.themeData.buttonColor
                        ],
                            child: Text(
                              "Sign Up",
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            onTap:
                                () {} /*async {
                          await onTapSignUp(context);
                        } /*_submitButtonOnTap(context)*/,*/
                            )),
                  ),
                  Expanded(
                    flex: 10,
                    child: Center(
                      child: InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () => Navigator.of(context).pop(),
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
        ),
        /*Expanded(
          flex: 10,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            height: 600,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 20,
                  child: FittedBox(
                    child: Text(
                      "Welcome!\nEge Examination System",
                      style: context.themeData.textTheme.display3
                          .copyWith(fontWeight: FontWeight.w700, fontSize: 45),
                    ),
                  ),
                ),
                Spacer(flex: 2),
                Expanded(
                  flex: 10,
                  child: FittedBox(
                    child: RichText(
                        maxLines: 2,
                        text: TextSpan(
                            style:
                                context.themeData.textTheme.display1.copyWith(
                              fontWeight: FontWeight.w400,
                            ),
                            children: [
                              TextSpan(
                                  text:
                                      "Build or start your online exam today.\n"),
                              TextSpan(text: "Also first month is "),
                              TextSpan(
                                text: "free!",
                                style: context.themeData.textTheme.display1
                                    .copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: context.themeData.primaryColor),
                              ),
                            ])),
                  ),
                ),
                Spacer(flex: 18),
                Expanded(
                  flex: 15,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        flex: 42,
                        child: RaisedButton(
                          color: context.themeData.primaryColor,
                          onPressed: () {},
                          child: Text(
                            "GET STARTED",
                            style:
                                context.themeData.textTheme.display1.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Spacer(flex: 6),
                      Expanded(
                        flex: 42,
                        child: OutlinedButton(
                          style: ButtonStyle(
                              side: MaterialStateProperty.all(BorderSide(
                            color: context.themeData.accentColor,
                            width: 4,
                          ))),
                          onPressed: () {},
                          child: Text(
                            "Learn More",
                            style:
                                context.themeData.textTheme.display1.copyWith(
                              color: context.themeData.accentColor,
                            ),
                          ),
                        ),
                      ),
                      Spacer(flex: 10),
                    ],
                  ),
                ),
                Spacer(
                  flex: 15,
                ),
              ],
            ),
          ),
        ),*/
        Spacer(
          flex: 10,
        ),
      ],
    );
  }
}
