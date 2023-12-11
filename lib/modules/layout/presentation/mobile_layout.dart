import 'package:efatorh/core/theme/dynamic_theme/colors.dart';
import 'package:efatorh/modules/layout/cubit/cubit.dart';
import 'package:efatorh/modules/layout/presentation/widgets/custom_bottonbar.dart';
import 'package:flutter/material.dart';

import '../../../core/Router/Router.dart';
import '../../../core/services/navigation_service.dart';

class MobileLayoutScreen extends StatefulWidget {
  const MobileLayoutScreen({Key? key, required this.child}) : super(key: key);
  final Widget child;
  @override
  State<MobileLayoutScreen> createState() => _MobileLayoutScreenState();
}

class _MobileLayoutScreenState extends State<MobileLayoutScreen> with WidgetsBindingObserver {
  // final SharedRepository sharedRepository = SharedRepository(locator<DioService>());
  @override
  void initState() {
    print("Hi from mobile layout");
    WidgetsBinding.instance.addObserver(this);

    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.primary,
          isExtended: false,
          onPressed: () async {
            NavigationService.mobileNavigateTo(Routes.cashier);
            LayoutCubit.get(context).refresh();
          },
          child: Stack(
            children: [
              ImageIcon(Image.asset("assets/icons/chasier.png").image, size: 45, color: Colors.white),
              CircleAvatar(
                backgroundColor: AppColors.primary,
                maxRadius: 7,
                child: const Center(
                  child: Text(
                    "${0}",
                    style: TextStyle(color: Colors.white, fontSize: 10),
                  ),
                ),
              )
            ],
          )),
      bottomNavigationBar: const CustomBottomNavBar(),
    );
  }
}
