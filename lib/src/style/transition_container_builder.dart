import 'dart:math';

import 'package:flutter/cupertino.dart';

import 'transition_container.dart';

/// Interface to provide a transition, work with [TransitionContainer].
abstract class TransitionContainerBuilder<T> {
  /// Curve for animation.
  final Curve curve;

  /// Create style builder.
  TransitionContainerBuilder(this.curve);

  /// Animation used for widget.
  Animation animation(AnimationController controller);

  /// Return animated widget with provided animation.
  Widget build(Animation<T> animation);
}

/// Scale transition builder.
class ScaleBuilder extends TransitionContainerBuilder<double> {
  /// The target widget to scale with.
  Widget child;

  @override
  Animation animation(AnimationController controller) {
    return CurvedAnimation(parent: controller, curve: curve);
  }

  @override
  Widget build(Animation<double> animation) {
    return ScaleTransition(scale: animation, child: child);
  }

  /// Create scale builder
  ScaleBuilder({required Curve curve, required this.child}) : super(curve);
}

/// Slide transition builder.
class SlideBuilder extends TransitionContainerBuilder<Offset> {
  /// The target widget to slide with.
  Widget child;

  /// slide direction.
  final bool reverse;

  /// Create slide builder.
  SlideBuilder(
      {required Curve curve, required this.child, required this.reverse})
      : super(curve);

  @override
  Widget build(Animation<Offset> animation) {
    return SlideTransition(position: animation, child: child);
  }

  @override
  Animation animation(AnimationController controller) {
    return Tween<Offset>(
      begin: reverse ? Offset.zero : const Offset(0.0, 2.0),
      end: reverse ? const Offset(0.0, 2.0) : Offset.zero,
    ).animate(CurvedAnimation(parent: controller, curve: curve));
  }
}

class FlipBuilder extends TransitionContainerBuilder {
  /// Top widget.
  final Widget topChild;

  /// Bottom widget.
  final Widget bottomChild;

  /// Size of builder.
  final double height;

  /// Create flip builder
  FlipBuilder(
    this.height, {
    required Curve curve,
    required this.topChild,
    required this.bottomChild,
  }) : super(curve);

  @override
  Animation animation(AnimationController controller) {
    return Tween(begin: 0.0, end: pi / 2).animate(
      CurvedAnimation(parent: controller, curve: curve),
    );
  }

  @override
  Widget build(Animation animation) {
    return Stack(
      children: <Widget>[
        Transform(
          alignment: Alignment.bottomCenter,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..translate(0.0, (cos(animation.value) * (height / 2)),
                ((height / 2) * sin(animation.value)))
            ..rotateX(-(pi / 2) + animation.value),
          child: Center(child: bottomChild),
        ),
        animation.value < (85 * pi / 180)
            ? Transform(
                alignment: Alignment.bottomCenter,
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..translate(
                    0.0,
                    -(height / 2) * sin(animation.value),
                    ((height / 2) * cos(animation.value)),
                  )
                  ..rotateX(animation.value),
                child: Container(
                  alignment: Alignment.bottomCenter,
                  child: Center(child: topChild),
                ),
              )
            : Container(),
      ],
    );
  }
}
