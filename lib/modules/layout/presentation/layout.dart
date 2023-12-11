import 'package:easy_localization/easy_localization.dart';
import 'package:efatorh/modules/layout/cubit/cubit.dart';
import 'package:efatorh/modules/layout/cubit/states.dart';
import 'package:efatorh/modules/layout/presentation/widgets/drawer.dart';
import 'package:efatorh/shared/widgets/intro_dialog.dart';
import 'package:efatorh/shared/widgets/maintenance_dialog.dart';
import 'package:efatorh/shared/widgets/update_dialog.dart';
import 'package:flutter/material.dart';

import 'package:efatorh/core/utils/Utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../shared/widgets/are_u_sure_dialog.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({Key? key, required this.child}) : super(key: key);
  final Widget child;
  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen>
    with WidgetsBindingObserver {
  @override
  void initState() {
    print("Hi from layout");
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
    return WillPopScope(
      onWillPop: () async {
        final check = await showDialog(
            context: context,
            builder: (context) => AreYouSureDialog(
                title: 'areYouSureCloseTheApp'.tr(),
                onConfirm: () {
                  Navigator.of(context).pop(true);
                }));
        return check ?? false;
      },
      child:
          BlocConsumer<LayoutCubit, LayoutStates>(listener: (context, state) {
        if (state is NeedUpdateStatus) {
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) => const UpdateDialog());
        }
        if (state is MaintenanceModeStatus) {
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) => const MaintenanceDialog());
        }
        if (state is NeedUserGuidStatus) {
          bool isPdf = Utils.generalSettings.introPdf?.isNotEmpty == true;

          showDialog(
              context: context,
              builder: (context) => IntroDialog(
                    url: isPdf
                        ? Utils.generalSettings.introPdf!
                        : Utils.generalSettings.introVideo!,
                    isPdf: isPdf,
                  ));
        }
      }, builder: (context, state) {
        return Scaffold(
          drawerEnableOpenDragGesture: false,
          drawer: const HiddenMenu(),
          key: Utils.drawer(),
          body: widget.child,
        );
      }),
    );
  }
}

// class CustomBottomNavBar extends StatefulWidget {
//   const CustomBottomNavBar({super.key});

//   @override
//   State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
// }

// class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
//   @override
//   Widget build(BuildContext context) {
//     return BottomAppBar(
//       elevation: 0,
//       shape: const CircularNotchedRectangle(),
//       child: Container(
//         decoration: BoxDecoration(border: Border(top: BorderSide(color: Colors.grey.withOpacity(0.3)))),
//         child: const Row(
//           children: <Widget>[],
//         ),
//       ),
//     );
//   }
// }
