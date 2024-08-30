
import 'package:flutter/material.dart';
import 'package:toku_flutter_common/src/core/extensions/build_context.dart';

class AdvBackButton extends StatelessWidget {
  const AdvBackButton({super.key, this.color, this.onPressed});

  final Color? color;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back_ios, color: color, size: 16),
      onPressed: onPressed ?? context.maybePop,
    );
  }
}
