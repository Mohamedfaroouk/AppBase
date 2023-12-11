import 'package:flutter/material.dart';
import 'package:efatorh/shared/widgets/myLoading.dart';
import '../../core/theme/dynamic_theme/colors.dart';
import 'customtext.dart';

class LoadingAndError extends StatelessWidget {
  const LoadingAndError({Key? key, required this.isError, required this.isLoading, required this.child, this.loadingWidget, this.errorWidget})
      : super(key: key);
  final bool isError;
  final bool isLoading;
  final Widget child;
  final Widget? loadingWidget;
  final Widget? errorWidget;
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (
      context,
    ) {
      if (isError) {
        return Center(
          child: errorWidget ??
              CustomText(
                'يوجد مشكله فى البيانات',
                fontSize: 18,
                color: AppColors.primary,
              ),
        );
      } else if (isLoading) {
        return Material(
          color: AppColors.background,
          child: loadingWidget ??
              Center(
                child: MyLoading.loadingWidget(),
              ),
        );
      } else {
        return child;
      }
    });
  }
}
