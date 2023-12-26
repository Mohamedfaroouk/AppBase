import 'package:easy_localization/easy_localization.dart';
import 'package:appbase/core/Router/Router.dart';
import 'package:appbase/core/services/navigation_service.dart';
import 'package:appbase/core/theme/dynamic_theme/colors.dart';
import 'package:appbase/shared/general_cubit/cubit.dart';
import 'package:appbase/shared/widgets/applogo.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/utils/Utils.dart';
import '../../../../shared/widgets/customtext.dart';
import '../../../../shared/widgets/delete_acount_dialog.dart';
import 'item_hidden_menu.dart';

class HiddenMenu extends StatefulWidget {
  const HiddenMenu({super.key});

  @override
  _HiddenMenuState createState() => _HiddenMenuState();
}

class _HiddenMenuState extends State<HiddenMenu> {
  String version = "";
  @override
  void initState() {
    PackageInfo.fromPlatform().then((value) {
      version = value.version;
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const Color iconColor = Colors.black;
    return Drawer(
      child: Container(
        color: Colors.white,
        child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 50),
                  const Center(child: AppLogo()),
                  const SizedBox(height: 5),
                  Center(
                    child: CustomText(
                      Utils.user?.name ?? "",
                      style: const TextStyle(
                          fontSize: 16,
                          color: iconColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    child: ItemHiddenMenu(
                      onTap: () async {
                        GeneralCubit.get(context).changeLang(
                            context,
                            context.locale.languageCode == "en"
                                ? const Locale("ar", "SA")
                                : const Locale("en", "US"));
                      },
                      icon: const Icon(Icons.label),
                      name: context.locale.languageCode == "ar"
                          ? "English"
                          : "العربية",
                    ),
                  ),
                  SizedBox(
                    child: ItemHiddenMenu(
                      onTap: () async {
                        // final authData = Provider.of<AuthData>(context, listen: false);

                        // authData.logout(context);
                        Utils.removeToken();
                        NavigationService.goNamed(Routes.loginRoute);
                      },
                      icon: Image.asset(
                        "assets/icons/logout.png",
                        height: 20,
                        color: iconColor,
                      ),
                      name: "logout".tr(),
                    ),
                  ),
                  if (Utils.user?.userType == 0)
                    SizedBox(
                      child: ItemHiddenMenu(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) =>
                                    const DeleteAcountDialog());
                          },
                          icon: Image.asset(
                            "assets/icons/delete-account.png",
                            width: 20,
                          ),
                          arrowColor: AppColors.error,
                          name: "deleteAccount".tr(),
                          baseStyle: TextStyle(
                              color: AppColors.error,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w300),
                          colorLineSelected: AppColors.error),
                    ),
                  Container(
                      height: 28,
                      margin: const EdgeInsets.only(left: 24, right: 48),
                      child: Divider(
                        color: iconColor.withOpacity(0.5),
                      )),
                  SizedBox(
                    child: Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomText(
                          'Version $version',
                          style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black12,
                              fontWeight: FontWeight.w300),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }

  void _launchURL(String url) async {
    if (!await launch(url)) throw 'Could not launch $url';
  }
}
