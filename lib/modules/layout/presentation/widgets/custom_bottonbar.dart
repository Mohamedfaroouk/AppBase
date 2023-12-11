import 'package:efatorh/core/services/navigation_service.dart';
import 'package:efatorh/core/theme/dynamic_theme/colors.dart';
import 'package:efatorh/modules/layout/cubit/cubit.dart';
import 'package:efatorh/modules/layout/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/Router/Router.dart';
import '../../../../shared/widgets/animation_build_widget.dart';

class CustomBottomNavBar extends StatefulWidget {
  const CustomBottomNavBar({super.key});

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return !NavigationService.isMobileRouteContain()
        ? Container()
        : BlocBuilder<LayoutCubit, LayoutStates>(builder: (context, state) {
            return BottomAppBar(
              elevation: 0,
              child: Container(
                decoration: BoxDecoration(border: Border(top: BorderSide(color: Colors.grey.withOpacity(0.3)))),
                child: Row(
                  children: <Widget>[
                    NavBarItem(
                        icon: "invoice1",
                        isSelected: NavigationService.isRouteContain("sales"),
                        ontap: () {
                          NavigationService.mobileNavigateTo(Routes.sales);
                          setState(() {});
                        }),
                    NavBarItem(
                        icon: "customer",
                        isSelected: NavigationService.isRouteContain("client"),
                        ontap: () {
                          NavigationService.mobileNavigateTo(Routes.client);
                          setState(() {});
                        }),
                    const SizedBox(
                      width: 70,
                    ),
                    NavBarItem(
                        icon: "products",
                        isSelected: NavigationService.isRouteContain("product"),
                        ontap: () {
                          NavigationService.mobileNavigateTo(Routes.product);
                          setState(() {});
                        }),
                    NavBarItem(
                        icon: "setting",
                        isSelected: NavigationService.isRouteContain("store-details"),
                        ontap: () {
                          NavigationService.mobileNavigateTo(Routes.storeDetailsRoute);
                          setState(() {});
                        }),
                  ],
                ),
              ),
            );
          });
  }
}

class NavBarItem extends StatelessWidget {
  const NavBarItem({super.key, required this.icon, required this.isSelected, this.ontap});

  final String icon;
  final bool isSelected;
  final VoidCallback? ontap;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () {
          ontap?.call();
          FocusScope.of(context).unfocus();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 700),
                key: UniqueKey(),
                child: ImageIcon(AssetImage("assets/icons/$icon${isSelected ? "_active.png" : ".png"}"),
                    color: isSelected ? AppColors.primary : Colors.black, size: 30),
              ),
              const SizedBox(height: 5),
              if (isSelected)
                AnimationAppearance(
                  duration: const Duration(milliseconds: 800),
                  curve: Curves.easeInOut,
                  alignment: Alignment.bottomCenter,
                  child: CircleAvatar(
                    radius: 3,
                    backgroundColor: AppColors.primary,
                  ),
                )
              else
                const SizedBox(
                  height: 6,
                )
            ],
          ),
        ),
      ),
    );
  }
}
