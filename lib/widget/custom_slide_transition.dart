import 'package:flutter/material.dart';

class CustomSlideTransition extends StatefulWidget {
  final Widget child;

  const CustomSlideTransition({Key key, this.child}) : super(key: key);
  @override
  _CustomSlideTransitionState createState() => _CustomSlideTransitionState();
}

class _CustomSlideTransitionState extends State<CustomSlideTransition>
    with SingleTickerProviderStateMixin {
  Animation animation;
  AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = new AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2000));
    animation = new Tween(
      begin: new Offset(0.0, -1.0),
      end: new Offset(0.0, 0.0),
    ).animate(new CurvedAnimation(
      parent: animationController,
      curve: new Interval(0.0, 0.5, curve: Curves.easeOut),
    ));
    animationController.forward();
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: animation,
      child: widget.child,
    );
  }
}
