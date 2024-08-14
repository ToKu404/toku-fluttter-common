import 'dart:async';

import 'package:kartjis_mobile_common/core.dart';

const Named debouncer250ms = Named('debouncer250ms');
const Named debouncer500ms = Named('debouncer500ms');

class Debouncer {
  Debouncer(this._milliseconds);

  final int _milliseconds;
  Timer? _timer;

  void run(void Function() cb) {
    _timer?.cancel();
    _timer = Timer(
      Duration(milliseconds: _milliseconds),
      cb,
    );
  }

  void cancel() {
    _timer?.cancel();
    _timer = null;
  }
}
