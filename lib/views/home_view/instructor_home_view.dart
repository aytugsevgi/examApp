import 'package:examapp/controllers/home_controller.dart';
import 'package:examapp/model/current_user.dart';
import 'package:examapp/service/auth_service.dart';
import 'package:examapp/utils/extension.dart';
import 'package:examapp/widget/custom_fade_transition.dart';
import 'package:examapp/widget/fade_route.dart';
import 'package:examapp/widget/loading_view.dart';
import 'package:examapp/widget/responsive_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InstructorHomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double itemWidth = context.dynamicWidth(0.20);
    final int itemCount = (context.dynamicWidth(1) / 400.0).floor();
    return CustomFadeTransition(
      child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: context.dynamicWidth(0.05), vertical: 10),
          width: ResponsiveWidget.isLargeScreen(context)
              ? context.dynamicWidth(0.4)
              : ResponsiveWidget.isMediumScreen(context)
                  ? context.dynamicWidth(0.5)
                  : context.dynamicWidth(0.7),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    maxLines: 1,
                    text: TextSpan(
                        style: context.themeData.textTheme.display1
                            .copyWith(color: Colors.black),
                        children: [
                          TextSpan(text: "Welcome, "),
                          TextSpan(
                            text:
                                "${CurrentUser.currentUser.firstName ?? "Guest"}",
                            style: context.themeData.textTheme.display1
                                .copyWith(color: Colors.black),
                          ),
                        ]),
                  ),
                  OutlineButton(
                    borderSide: BorderSide(width: 2),
                    onPressed: () {},
                    child: classCard(context, "+ Create A Classroom"),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Here, I Found Your Classrooms",
                style: context.themeData.textTheme.display3
                    .copyWith(fontWeight: FontWeight.normal),
              ),
              SizedBox(
                height: 20,
              ),
              GridView.count(
                crossAxisCount: itemCount,
                childAspectRatio: 1.50,
                crossAxisSpacing: 20,
                controller: new ScrollController(keepScrollOffset: false),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                children: [
                  "Cloud Computing",
                  "Software Engineering",
                  "Data Mining"
                ].map((value) {
                  return Padding(
                      padding: const EdgeInsets.only(
                          left: 2, top: 20.0, bottom: 20, right: 2),
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.transparent),
                            padding:
                                MaterialStateProperty.all<EdgeInsetsGeometry>(
                                    EdgeInsets.zero)),
                        onPressed: () {},
                        child: classCard(context, value),
                      ));
                }).toList(),
              ),
            ],
          )),
    );
  }

  Container classCard(BuildContext context, String title) {
    return new Container(
      padding: EdgeInsets.symmetric(
          vertical: context.dynamicHeight(0.01),
          horizontal: context.dynamicWidth(0.01)),
      child: new Text(
        title,
        style: context.themeData.textTheme.display3,
      ),
    );
  }
}
