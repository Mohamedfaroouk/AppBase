import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'customtext.dart';

class MaintenanceDialog extends StatelessWidget {
  const MaintenanceDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Dialog(
          clipBehavior: Clip.hardEdge,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    "assets/images/logo_new_black.png",
                    fit: BoxFit.contain,
                    width: double.infinity,
                    height: 100,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          CustomText("Maintenance".tr(),
                              align: TextAlign.center,
                              color: Colors.black,
                              fontSize: 18),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
