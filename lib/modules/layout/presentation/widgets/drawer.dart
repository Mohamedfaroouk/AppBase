import 'package:easy_localization/easy_localization.dart';
import 'package:efatorh/core/Router/Router.dart';
import 'package:efatorh/core/services/navigation_service.dart';
import 'package:efatorh/core/theme/dynamic_theme/colors.dart';
import 'package:efatorh/core/utils/alerts.dart';
import 'package:efatorh/modules/auth/domain/model/app_featuers.dart';
import 'package:efatorh/shared/general_cubit/cubit.dart';
import 'package:efatorh/shared/widgets/applogo.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/utils/Utils.dart';
import '../../../../shared/widgets/customtext.dart';
import '../../../../shared/widgets/delete_acount_dialog.dart';
import '../../../../shared/widgets/intro_dialog.dart';
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
    GeneralCubit.get(context).refreshUserData();
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: CustomText(
                      "sales".tr(),
                      color: Colors.black,
                      fontSize: 22,
                      weight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),

                  SizedBox(
                    child: ItemHiddenMenu(
                      onTap: () {
                        Navigator.pop(context);
                        NavigationService.mobileNavigateTo(Routes.sales);
                      },
                      icon: Image.asset(
                        "assets/icons/sales.png",
                        color: iconColor,
                        height: 25,
                      ),
                      name: "saleInvoice".tr(),
                    ),
                  ),
                  SizedBox(
                    child: ItemHiddenMenu(
                      onTap: () {
                        Navigator.pop(context);
                        NavigationService.pushNamed(Routes.refundSales);
                      },
                      icon: Image.asset(
                        "assets/icons/refundSales.png",
                        height: 25,
                        color: iconColor,
                      ),
                      name: "refundInvoice".tr(),
                    ),
                  ),
                  SizedBox(
                    child: ItemHiddenMenu(
                      onTap: () {
                        Navigator.pop(context);
                        NavigationService.mobileNavigateTo(Routes.client);
                      },
                      icon: Image.asset(
                        "assets/icons/group.png",
                        color: iconColor,
                        height: 25,
                      ),
                      name: "clients".tr(),
                    ),
                  ),
                  SizedBox(
                    child: ItemHiddenMenu(
                      appFeatures: AppFeatures.price_quotation,
                      onTap: () {
                        Navigator.pop(context);
                        NavigationService.pushNamed(Routes.quatation);
                      },
                      icon: Image.asset(
                        "assets/icons/quatation.png",
                        color: iconColor,
                        height: 25,
                      ),
                      name: "quotations".tr(),
                    ),
                  ),
                  if (Utils.showIfAppleEndReview)
                    if (Utils.user?.userType == 0)
                      SizedBox(
                        child: ItemHiddenMenu(
                          appFeatures: AppFeatures.reports_on,
                          onTap: () {
                            Navigator.pop(context);
                            NavigationService.pushNamed(Routes.reports);

                            // if (Utils.user.hasAccess(AppFeatures.reports_on)) {
                            //   Navigator.pop(context);
                            //   Navigator.pushNamed(context, Routes.reports);
                            // } else {
                            //   Utils.showShouldUpgrade(context);
                            // }
                          },
                          icon: Image.asset(
                            "assets/icons/scanner.png",
                            color: iconColor,
                            height: 25,
                          ),
                          name: "reports".tr(),
                        ),
                      ),
                  if (Utils.user?.userType == 0)
                    SizedBox(
                      child: ItemHiddenMenu(
                        onTap: () {
                          if (!Utils.user?.isFree()) {
                            Navigator.pop(context);
                            NavigationService.pushNamed(Routes.taxReturn);
                          } else {
                            Alerts.shouldUpgradeDialog();
                          }
                        },
                        icon: Image.asset(
                          "assets/icons/taxreturn.png",
                          color: iconColor,
                          height: 25,
                        ),
                        name: "taxReturn".tr(),
                      ),
                    ),

                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: CustomText(
                      "products".tr(),
                      color: Colors.black,
                      fontSize: 22,
                      weight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),

                  SizedBox(
                    child: ItemHiddenMenu(
                      onTap: () {
                        Navigator.pop(context);
                        NavigationService.pushNamed(Routes.category);
                      },
                      icon: Image.asset(
                        "assets/icons/category.png",
                        color: iconColor,
                        height: 25,
                      ),
                      name: "categories".tr(),
                    ),
                  ),
                  ItemHiddenMenu(
                    onTap: () {
                      Navigator.pop(context);
                      NavigationService.mobileNavigateTo(Routes.product);
                    },
                    icon: Image.asset(
                      "assets/icons/box.png",
                      color: iconColor,
                      height: 25,
                    ),
                    name: "products".tr(),
                  ),
                  if (Utils.user?.userType == 0)
                    SizedBox(
                      child: ItemHiddenMenu(
                        onTap: () {
                          Navigator.pop(context);
                          NavigationService.pushNamed(Routes.tiler);
                        },
                        icon: Image.asset(
                          "assets/icons/purchase.png",
                          color: iconColor,
                          height: 25,
                        ),
                        name: "tilers".tr(),
                      ),
                    ),
                  // SizedBox(
                  //   child: ItemHiddenMenu(
                  //     onTap: () {
                  //       // if (Utils.user.hasAccess(AppFeatures.purchase_invoices)) {
                  //       // Navigator.pop(context);
                  //       Navigator.pushNamed(context, Routes.warehouses);
                  //       // } else {
                  //       // Utils.willBeAvailableSoon(context);
                  //       // }
                  //     },
                  //     icon: Image.asset(
                  //       "assets/icons/purchase.png",
                  //       color: iconColor,
                  //       height: 25,
                  //     ),
                  //     name: "warehouses".tr(),
                  //   ),
                  // ),
                  // SizedBox(
                  //   child: ItemHiddenMenu(
                  //     onTap: () {
                  //       // if (Utils.user.hasAccess(AppFeatures.purchase_invoices)) {
                  //       // Navigator.pop(context);
                  //       Navigator.pushNamed(context, Routes.paymentMethod);
                  //       // } else {
                  //       // Utils.willBeAvailableSoon(context);
                  //       // }
                  //     },
                  //     icon: Image.asset(
                  //       "assets/icons/purchase.png",
                  //       color: iconColor,
                  //       height: 25,
                  //     ),
                  //     name: "paymentMethod".tr(),
                  //   ),
                  // ),
                  SizedBox(
                    child: ItemHiddenMenu(
                      appFeatures: AppFeatures.purchase_invoices,
                      onTap: () {
                        Navigator.pop(context);
                        NavigationService.pushNamed(Routes.purchaseInvoice);
                      },
                      icon: Image.asset(
                        "assets/icons/purchase.png",
                        color: iconColor,
                        height: 25,
                      ),
                      name: "purchaseInvoice".tr(),
                    ),
                  ),
                  SizedBox(
                    child: ItemHiddenMenu(
                      appFeatures: AppFeatures.refund_purchase,
                      onTap: () {
                        Navigator.pop(context);
                        NavigationService.pushNamed(Routes.refundPurchase);
                      },
                      icon: Image.asset(
                        "assets/icons/refundPurchase.png",
                        height: 25,
                        color: iconColor,
                      ),
                      name: "refundPurchase".tr(),
                    ),
                  ),

                  SizedBox(
                    child: ItemHiddenMenu(
                      appFeatures: AppFeatures.suppliers,
                      onTap: () {
                        Navigator.pop(context);
                        NavigationService.pushNamed(Routes.supplier);
                      },
                      icon: Image.asset(
                        "assets/icons/supplier.png",
                        color: iconColor,
                        height: 25,
                      ),
                      name: "suppliers".tr(),
                    ),
                  ),
                  if (Utils.user?.userType == 0)
                    SizedBox(
                      child: ItemHiddenMenu(
                        appFeatures: AppFeatures.stocks,
                        onTap: () {
                          Navigator.pop(context);
                          NavigationService.pushNamed(Routes.stock);
                        },
                        icon: Image.asset(
                          "assets/icons/stocks.png",
                          color: iconColor,
                          height: 30,
                        ),
                        name: "stock".tr(),
                      ),
                    ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: CustomText(
                      "settings".tr(),
                      color: Colors.black,
                      fontSize: 22,
                      weight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),

                  SizedBox(
                    child: ItemHiddenMenu(
                      onTap: () {
                        Navigator.pop(context);
                        NavigationService.pushNamed(Routes.profile);
                      },
                      icon: Image.asset(
                        "assets/icons/account.png",
                        color: iconColor,
                        height: 25,
                      ),
                      name: "profile".tr(),
                    ),
                  ),
                  if (Utils.user?.userType == 0)
                    SizedBox(
                      child: ItemHiddenMenu(
                        onTap: () {
                          Navigator.pop(context);
                          NavigationService.mobileNavigateTo(
                              Routes.storeDetailsRoute);
                        },
                        icon: Image.asset(
                          "assets/icons/control.png",
                          height: 25,
                          color: iconColor,
                        ),
                        name: "invoiceSettings".tr(),
                      ),
                    ),
                  if (Utils.user?.userType == 0)
                    if (Utils.showIfAppleEndReview)
                      SizedBox(
                        child: ItemHiddenMenu(
                          onTap: () {
                            Navigator.pop(context);
                            NavigationService.pushNamed(Routes.employee);
                          },
                          icon: Image.asset(
                            "assets/icons/teamwork.png",
                            color: iconColor,
                            height: 25,
                          ),
                          name: "users".tr(),
                        ),
                      ),
                  if (Utils.user?.userType == 0)
                    SizedBox(
                      child: ItemHiddenMenu(
                        onTap: () {
                          Navigator.pop(context);
                          NavigationService.pushNamed(Routes.paymentMethod);
                        },
                        icon: Image.asset(
                          "assets/icons/purchase.png",
                          color: iconColor,
                          height: 25,
                        ),
                        name: "paymentMethod".tr(),
                      ),
                    ),
                  // if (Utils.user.isGuest == false)
                  if (Utils.user?.userType == 0)
                    if (Utils.showIfAppleEndReview)
                      SizedBox(
                        child: ItemHiddenMenu(
                          onTap: () {
                            Navigator.pop(context);
                            NavigationService.pushNamed(Routes.packages);
                          },
                          icon: Image.asset(
                            "assets/icons/packages.png",
                            height: 25,
                            color: iconColor,
                          ),
                          name: "packedges".tr(),
                        ),
                      ),
                  if (Utils.showIfAppleEndReview)
                    SizedBox(
                      child: ItemHiddenMenu(
                        onTap: () {
                          Navigator.pop(context);
                          NavigationService.pushNamed(Routes.contactUs);
                        },
                        icon: Image.asset(
                          "assets/icons/call.png",
                          color: iconColor,
                          height: 20,
                        ),
                        name: "contuctUs".tr(),
                      ),
                    ),
                  if (Utils.showIfAppleEndReview)
                    SizedBox(
                      child: ItemHiddenMenu(
                        onTap: () {
                          Utils.requestHelp();
                        },
                        icon: Image.asset(
                          "assets/icons/whatsapp.png",
                          height: 20,
                          color: iconColor,
                        ),
                        name: "contactViaWhatsApp".tr(),
                      ),
                    ),
                  if (Utils.showIfAppleEndReview)
                    SizedBox(
                      child: ItemHiddenMenu(
                        onTap: () {
                          Navigator.pop(context);
                          NavigationService.pushNamed(Routes.aboutUs);
                        },
                        icon: Image.asset(
                          "assets/icons/information.png",
                          color: iconColor,
                          height: 20,
                        ),
                        name: "aboutUs".tr(),
                      ),
                    ),
                  SizedBox(
                    child: ItemHiddenMenu(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              // appPreferences.setAppTourViewed(true);
                              bool isPdf =
                                  Utils.generalSettings.introPdf?.isNotEmpty ==
                                      true;
                              return IntroDialog(
                                  isPdf: isPdf,
                                  url: isPdf
                                      ? Utils.generalSettings.introPdf ?? ""
                                      : Utils.generalSettings.introVideo ?? "");
                            });
                      },
                      icon: Image.asset(
                        "assets/icons/information.png",
                        color: iconColor,
                        height: 20,
                      ),
                      name: "userGuid".tr(),
                    ),
                  ),
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
