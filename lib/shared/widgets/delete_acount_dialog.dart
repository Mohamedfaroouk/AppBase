import 'package:easy_localization/easy_localization.dart';
import 'package:appbase/core/theme/dynamic_theme/colors.dart';
import 'package:appbase/modules/auth/cubit/cubit.dart';
import 'package:appbase/shared/widgets/applogo.dart';
import 'package:flutter/material.dart';

import 'customtext.dart';

class DeleteAcountDialog extends StatelessWidget {
  const DeleteAcountDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        width: 700,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.all(16),
              child: AppLogo(
                whiteFont: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomText(
                    "areYouSureDeleteAccount".tr(),
                    color: Colors.black,
                    fontSize: 16,
                    weight: FontWeight.w500,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomText(
                        "deleteAccountSubtitle".tr()
                        // "سيتم حذف حسابك بشكل كامل وحذف جميع البيانات الخاصه بك",
                        ,
                        align: TextAlign.center,
                        color: AppColors.error,
                        fontSize: 13),
                  ),
                  const Divider(
                    height: 0,
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: MaterialButton(
                    child: CustomText(
                      "yes".tr(),
                      color: Colors.black,
                      fontSize: 16,
                      weight: FontWeight.bold,
                    ),
                    onPressed: () {
                      final cubit = AuthCubit.get(context);
                      cubit.deleteAccount();
                      Navigator.pop(context);
                    },
                  ),
                ),
                const SizedBox(height: 40, child: VerticalDivider()),
                Expanded(
                  child: MaterialButton(
                    child: CustomText(
                      "no".tr(),
                      color: Colors.black,
                      fontSize: 16,
                      weight: FontWeight.bold,
                    ),
                    onPressed: () async {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
