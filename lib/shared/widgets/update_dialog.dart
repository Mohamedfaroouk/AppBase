import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:appbase/core/utils/Utils.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'customtext.dart';

class UpdateDialog extends StatelessWidget {
  const UpdateDialog({
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
            child: Stack(
              children: [
                // Image.asset(
                //   "assets/images/update.png",
                //   fit: BoxFit.fill,
                //   width: double.infinity,
                //   height: 200,
                // ),
                SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Image.network(
                          Utils.generalSettings.appImage ?? "",
                          fit: BoxFit.cover,
                          width: 200,
                          height: 50,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomText(Utils.generalSettings.updateTitle ?? "",
                            weight: FontWeight.w500,
                            color: Colors.black,
                            fontSize: 20),
                        const SizedBox(
                          height: 15,
                        ),
                        CustomText(
                          Utils.generalSettings.updateDescription ?? "",
                          align: TextAlign.center,
                          fontSize: 13,
                          color: Colors.black,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: Card(
                            elevation: 0,
                            clipBehavior: Clip.hardEdge,
                            color: const Color(0xff5EDFA3),
                            shape: const StadiumBorder(),
                            child: InkWell(
                              onTap: () {
                                if (Platform.isAndroid) {
                                  launchUrl(Uri.parse(
                                      "market://details?id=com.hlsoft.appbase"));
                                }
                                if (Platform.isIOS) {
                                  launchUrl(Uri.parse(
                                      "https://apps.apple.com/us/app/appbase-%D8%A7%D9%8A-%D9%81%D8%A7%D8%AA%D9%88%D8%B1%D8%A9/id1627067636"));
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 70, vertical: 10),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Expanded(
                                      child: CustomText("updateNow".tr(),
                                          align: TextAlign.center,
                                          fontSize: 15,
                                          color: Colors.white),
                                    ),
                                    const Icon(
                                      Icons.arrow_back_ios_new,
                                      color: Colors.white,
                                      size: 15,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
