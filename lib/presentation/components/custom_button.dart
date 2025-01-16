import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final TextStyle? titleStyle;
  final TextAlign? textAlign;
  final Color backgroundColor;
  final bool isEnabled;
  final Widget? prefix;
  final Widget? suffix;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final double? width, height;
  final bool isFullWidth, isFullHeight;
  final MainAxisAlignment? mainAxisAlignment;
  final CrossAxisAlignment? crossAxisAlignment;
  final bool isExpanded;

  const CustomButton({
    super.key,
    this.title = '',
    this.titleStyle,
    this.backgroundColor = Colors.grey,
    this.isEnabled = true,
    this.prefix,
    this.suffix,
    this.onTap,
    this.onLongPress,
    this.borderRadius = 8,
    this.padding = const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
    this.width,
    this.height,
    this.isFullWidth = false,
    this.isFullHeight = false,
    this.mainAxisAlignment,
    this.crossAxisAlignment,
    this.isExpanded = false,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return InkWell(
      hoverColor: Colors.grey,
      onTap: isEnabled ? onTap : null,
      onLongPress: isEnabled ? onLongPress : null,
      borderRadius: BorderRadius.circular(borderRadius),
      child: Container(
        padding: padding,
        width: isFullWidth ? screenWidth : width,
        height: isFullHeight ? screenHeight : height,
        decoration: BoxDecoration(
          color: isEnabled ? backgroundColor : Colors.grey,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.center,
          crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.center,
          children: [
            if (prefix != null) prefix!,
            isExpanded
                ? Expanded(
                    child: Text(
                      title,
                      style: titleStyle ?? const TextStyle(color: Colors.white),
                      textAlign: textAlign ?? TextAlign.center,
                    ),
                  )
                : Text(
                    title,
                    style: titleStyle ?? const TextStyle(color: Colors.white),
                    textAlign: textAlign ?? TextAlign.center,
                  ),
            if (suffix != null) suffix!,
          ],
        ),
      ),
    );
  }
}
