import 'package:flutter/material.dart';

class ThisIsFadeRoute extends PageRouteBuilder {
  final Widget? page;
  final Widget? route;

  ThisIsFadeRoute({this.page, this.route})
      : super(
    pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        ) =>
    page!,
    transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
        ) =>
        FadeTransition(
          opacity: animation,
          child: route,
        ),
  );
}
