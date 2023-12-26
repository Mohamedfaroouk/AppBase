import 'package:appbase/modules/layout/presentation/widgets/custom_bottonbar.dart';
import 'package:flutter/material.dart';

class MobileLayoutScreen extends StatefulWidget {
  const MobileLayoutScreen({Key? key, required this.child}) : super(key: key);
  final Widget child;
  @override
  State<MobileLayoutScreen> createState() => _MobileLayoutScreenState();
}

class _MobileLayoutScreenState extends State<MobileLayoutScreen>
    with WidgetsBindingObserver {
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
      bottomNavigationBar: const CustomBottomNavBar(),
    );
  }
}
