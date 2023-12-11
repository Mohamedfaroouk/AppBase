import 'package:flutter/material.dart';

import '../../core/theme/dynamic_theme/colors.dart';

class BackIcon extends StatelessWidget {
  const BackIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Icon(
        Directionality.of(context) == TextDirection.ltr
            ? Icons.arrow_forward_ios
            : Icons.arrow_back_ios_new,
        color: AppColors.primary,
        size: 25);
  }
}
