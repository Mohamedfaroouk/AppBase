import 'package:flutter/material.dart';
import 'package:appbase/core/utils/Utils.dart';
import 'package:appbase/core/utils/extentions.dart';

import '../../core/theme/dynamic_theme/colors.dart';
import 'back_icon.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({Key? key, this.isHome = true}) : super(key: key);
  final bool isHome;
  @override
  Widget build(BuildContext context) {
    return AppBar(
        leadingWidth: 100,
        title: Image.asset(
          "logo_name".png(),
          width: 70,
          height: 70,
        ),
        leading: Row(
          children: [
            IconButton(
              onPressed: () {
                Utils.drawer().currentState!.openDrawer();
              },
              icon: Icon(
                Icons.more_vert,
                color: AppColors.primary,
              ),
            ),
            if (isHome)
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.location_on,
                  color: AppColors.primary,
                ),
              ),
          ],
        ),
        actions: [
          (!isHome)
              ? IconButton(onPressed: () {}, icon: const BackIcon())
              : IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.favorite,
                    color: AppColors.primary,
                  ),
                ),
        ]);
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
