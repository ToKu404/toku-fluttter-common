import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

abstract class NavController extends NavigatorObserver {
  static NavController of(BuildContext context) => context.read<NavController>();

  List<String> routeNames = [];

  bool containsRoute(String routeName) => routeNames.contains(routeName);

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    final routeName = route.settings.name ?? '';
    routeNames.add(routeName);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    routeNames.removeLast();
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    routeNames.removeLast();
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    routeNames.removeLast();
    final routeName = newRoute?.settings.name ?? '';
    routeNames.add(routeName);
  }
}
