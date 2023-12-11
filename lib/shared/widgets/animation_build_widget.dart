import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AnimationAppearance extends StatefulWidget {
  const AnimationAppearance({Key? key, required this.child, this.alignment, this.duration, this.curve}) : super(key: key);
  final Widget child;
  final Duration? duration;
  final AlignmentGeometry? alignment;
  final Curve? curve;
  @override
  State<AnimationAppearance> createState() => _AnimationAppearanceState();
}

class _AnimationAppearanceState extends State<AnimationAppearance> with AutomaticKeepAliveClientMixin {
  final tween = Tween<double>(begin: 0, end: 1);
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return TweenAnimationBuilder<double>(
        curve: widget.curve ?? Curves.bounceOut,
        duration: widget.duration ?? const Duration(milliseconds: 1000),
        tween: tween,
        builder: (context, tween, child) {
          return Transform.translate(
            offset: Offset(0, 10 * (tween - 1)),
            child: Opacity(
              opacity: tween,
              child: widget.child,
            ),
          );
        });
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class AnimationAppearanceOpacity extends StatefulWidget {
  const AnimationAppearanceOpacity({Key? key, required this.child, this.duration, this.delayed}) : super(key: key);
  final Widget child;

  final Duration? duration;
  final Duration? delayed;
  @override
  State<AnimationAppearanceOpacity> createState() => _AnimationAppearanceOpacityState();
}

class _AnimationAppearanceOpacityState extends State<AnimationAppearanceOpacity> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(widget.delayed ?? const Duration(milliseconds: 0)),
      builder: (context, s) => s.connectionState == ConnectionState.waiting
          ? Container(
              height: 30,
            )
          : TweenAnimationBuilder<double>(
              duration: widget.duration ?? const Duration(milliseconds: 500),
              tween: Tween<double>(begin: 0, end: 1),
              builder: (context, tween, child) {
                return Opacity(opacity: tween, child: widget.child);
              }),
    );
  }
}
