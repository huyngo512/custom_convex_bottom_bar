import 'package:flutter/material.dart';

import 'blend_image_icon.dart';
import 'inner_builder.dart';
import 'transition_container.dart';

/// Convex shape is moved after selection.
class ReactCircleTabStyle extends InnerBuilder {
  final Color backgroundColor;

  /// Curve for tab transition.
  final Curve curve;

  /// Create style builder.
  ReactCircleTabStyle({
    required super.items,
    required super.activeColor,
    required super.color,
    required this.backgroundColor,
    required this.curve,
  });

  @override
  Widget build(BuildContext context, int index, bool active) {
    var item = items[index];
    var style = ofStyle(context);
    var margin = style.activeIconMargin;
    if (active) {
      final item = items[index];
      return TransitionContainer.scale(
        data: index,
        curve: curve,
        child: Container(
          // necessary otherwise the badge will not large enough
          width: style.layoutSize,
          height: style.layoutSize,
          margin: EdgeInsets.all(margin),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: active ? activeColor : color,
          ),
          child: BlendImageIcon(
            active ? item.activeIcon ?? item.icon : item.icon,
            size: style.activeIconSize,
            color: item.blend ? backgroundColor : null,
          ),
        ),
      );
    }
    var textStyle = style.textStyle(color, item.fontFamily);
    var noLabel = style.hideEmptyLabel && hasNoText(item);
    var children = <Widget>[
      BlendImageIcon(
        active ? item.activeIcon ?? item.icon : item.icon,
        size: style.iconSize,
        color: item.blend ? color : null,
      ),
    ];
    if (!noLabel) {
      children.add(Text(item.title ?? '', style: textStyle));
    }
    return Container(
      padding: const EdgeInsets.only(bottom: 2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: children,
      ),
    );
  }
}
