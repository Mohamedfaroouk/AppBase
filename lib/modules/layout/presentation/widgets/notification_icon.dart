import 'package:efatorh/core/Router/Router.dart';
import 'package:efatorh/core/services/navigation_service.dart';
import 'package:efatorh/core/utils/Utils.dart';
import 'package:flutter/material.dart';

class NotificationIcon extends StatelessWidget {
  const NotificationIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Utils.user?.userType == 0
        ? IconButton(
            onPressed: () {
              NavigationService.pushNamed(Routes.notification);
            },
            icon: const Stack(
              children: [
                ImageIcon(
                  AssetImage("assets/icons/notification.png"),
                ),
                if (false)
                  CircleAvatar(
                    radius: 5,
                    backgroundColor: Colors.red,
                  )
              ],
            ),
          )
        : Container();
  }
}
