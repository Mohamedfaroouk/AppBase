import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import '../../core/utils/alerts.dart';
import 'customtext.dart';

class SnackDesgin extends StatelessWidget {
  const SnackDesgin({
    Key? key,
    required this.state,
    required this.text,
  }) : super(key: key);
  final SnackState state;
  final String text;
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: 600,
      ),
      child: Align(
        alignment: AlignmentDirectional.topEnd,
        child: Padding(
          padding: const EdgeInsetsDirectional.only(
            top: 60,
            end: 20,
          ),
          child: SizedBox(
            child: Card(
              clipBehavior: Clip.hardEdge,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(
                  color:
                      state == SnackState.success ? Colors.green : Colors.red,
                  width: 1,
                ),
              ),
              color: state == SnackState.success
                  ? Colors.green.shade50
                  : Colors.red.shade50,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const SizedBox(
                          width: 5,
                        ),
                        // Container(
                        //   height: 90,
                        //   width: 5,
                        //   decoration: BoxDecoration(
                        //       color: state == SnackState.success
                        //           ? const Color(0xff52de79)
                        //           : Colors.red,
                        //       borderRadius: BorderRadius.circular(50)),
                        // ),
                        state == SnackState.success
                            ? Lottie.asset("assets/json/success.json",
                                width: 80, height: 80, repeat: false)
                            : Lottie.asset("assets/json/error.json",
                                width: 80, height: 80, repeat: false),
                        const SizedBox(),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CustomText(
                              text,
                              maxLine: 2,
                              color: state == SnackState.success
                                  ? Colors.green
                                  : Colors.red,
                              weight: FontWeight.w500,
                              align: TextAlign.start,
                              textStyleEnum: TextStyleEnum.title,
                              fontSize: 18,
                            ),
                          ),
                        ),

                        const SizedBox(
                          width: 10,
                        ),
                        //exit
                      ],
                    ),
                  ),
                  //loading
                  LoadingForDuration(
                      sec: 3,
                      color: state == SnackState.success
                          ? Colors.green
                          : Colors.red),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class LoadingForDuration extends StatefulWidget {
  const LoadingForDuration({super.key, required this.sec, this.color});
  final int sec;
  final Color? color;
  @override
  State<LoadingForDuration> createState() => _LoadingForDurationState();
}

class _LoadingForDurationState extends State<LoadingForDuration>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  int get sec => widget.sec;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: sec),
    )..forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) => SizedBox(
        height: 5,
        child: LinearProgressIndicator(
          color: widget.color ?? Colors.green,
          value: _controller.value,
        ),
      ),
    );
  }
}
