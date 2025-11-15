import 'package:flutter/material.dart';

class RawButton extends StatelessWidget {
  final Widget child;
  final Function() onTap;
  final Function()? onLongPress;
  final double radius;
  final Color color;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final double elevation;

  const RawButton({
    super.key,
    required this.child,
    required this.onTap,
    this.onLongPress,
    this.radius = 10,
    this.color = Colors.transparent,
    this.padding = EdgeInsets.zero,
    this.margin = EdgeInsets.zero,
    this.elevation = 2,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: Material(
          elevation: elevation,
          color: color,
          child: InkWell(
            onTap: onTap,
            onLongPress: onLongPress != null ? onLongPress! : onTap,
            child: Container(
              padding: padding,
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}