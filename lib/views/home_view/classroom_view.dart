import 'package:examapp/model/current_user.dart';
import 'package:examapp/utils/extension.dart';
import 'package:examapp/widget/fade_route.dart';
import 'package:examapp/widget/responsive_widget.dart';
import 'package:flutter/material.dart';

class ClassroomView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(
            horizontal: context.dynamicWidth(0.05), vertical: 10),
        width: ResponsiveWidget.isLargeScreen(context)
            ? context.dynamicWidth(0.4)
            : ResponsiveWidget.isMediumScreen(context)
                ? context.dynamicWidth(0.5)
                : context.dynamicWidth(0.7),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                maxLines: 1,
                text: TextSpan(
                    style: context.themeData.textTheme.display1
                        .copyWith(color: Colors.black),
                    children: [
                      TextSpan(text: "< Back Classroom"),
                    ]),
              ),
              OutlineButton(
                borderSide: BorderSide(width: 2),
                onPressed: () {},
                child: card(context, "+ Create A Exam"),
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
        ]));
  }

  Container card(BuildContext context, String title) {
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
