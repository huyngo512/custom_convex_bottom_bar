import 'package:flutter/cupertino.dart';

/// Tab item used for [ConvexAppBar].
class TabItem<T> {
  final String? fontFamily;

  /// Tab text.
  final String? title;

  /// IconData or Image.
  final T icon;

  /// Optional if not provided ,[icon] is used.
  final T? activeIcon;

  /// Whether icon should blend with color.
  /// If [icon] is instance of [IconData] then blend is default to true, otherwise false
  final bool blend;

  /// Create item
  const TabItem({
    this.fontFamily,
    this.title = '',
    required this.icon,
    this.activeIcon,
    bool? isIconBlend,
  })  : assert(icon is IconData || icon is Widget,
            'TabItem only support IconData and Widget'),
        blend = isIconBlend ?? (icon is IconData);
}
