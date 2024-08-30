import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

enum PageRouteType { defaultMaterial, useButtomAndSlidingMenu, useSlidingMenuOnly }

extension BuildContextExtension on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  ModalRoute<dynamic>? get modalRoute => ModalRoute.of(this);

  ThemeData get theme => Theme.of(this);

  T get<T>() => Provider.of<T>(this)!;

  T getPassive<T>() => Provider.of<T>(this, listen: false)!;

  void dismissFocus() {
    final currentFocus = FocusScope.of(this);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  void pop<T extends Object?>([T? result]) {
    final canPop = Navigator.canPop(this);
    if (!canPop) return;

    return Navigator.pop<T>(this, result);
  }

  bool get canPop => modalRoute?.canPop ?? false;

  Future<bool> maybePop<T extends Object?>([T? result]) async {
    return await Navigator.of(this).maybePop<T>(result);
  }

  void popUntil(bool Function(Route route) predicate) {
    Navigator.popUntil(this, predicate);
  }

  bool isVisible() {
    // Find the object which has the focus
    final object = findRenderObject();

    final viewport = RenderAbstractViewport.maybeOf(object);

    // If we are not working in a Scrollable, skip this routine
    if (viewport == null) {
      return false;
    }

    // Get the Scrollable state (in order to retrieve its offset)
    final scrollableState = Scrollable.maybeOf(this);

    // If Scrollable is null, skip this routine
    if (scrollableState == null) {
      return false;
    }

    // Get its offset
    final position = scrollableState.position;

    if (position.pixels > viewport.getOffsetToReveal(object!, 0.0).offset) {
      return false;
    } else if (position.pixels < viewport.getOffsetToReveal(object, 1.0).offset) {
      return false;
    } else {
      return true;
    }
  }

  Future<T?> pushWithoutAnimation<T extends Object>(BuildContext context, Widget page) {
    final Route<T> route = NoAnimationPageRoute<T>(builder: (BuildContext context) => page);
    return Navigator.push(context, route);
  }
}

class NoAnimationPageRoute<T> extends MaterialPageRoute<T> {
  NoAnimationPageRoute({required WidgetBuilder builder}) : super(builder: builder);

  @override
  Widget buildTransitions(
      BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    return child;
  }
}
