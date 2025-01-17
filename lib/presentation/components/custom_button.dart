import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title, subTitle;
  final TextStyle? titleStyle, subTitleStyle;
  final TextAlign? titleAlign, subAlign;
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
  final MainAxisAlignment? btnMainAxisAlignment, textMainAxisAlignment;
  final CrossAxisAlignment? btnCrossAxisAlignment, textCrossAxisAlignment;
  final bool isExpanded;
  final double? textMarginLeft, textMarginRight;

  const CustomButton({
    super.key,
    this.title = '',
    this.subTitle = '',
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
    this.btnMainAxisAlignment,
    this.btnCrossAxisAlignment,
    this.isExpanded = false,
    this.titleAlign,
    this.subTitleStyle,
    this.subAlign,
    this.textMainAxisAlignment,
    this.textCrossAxisAlignment,
    this.textMarginLeft,
    this.textMarginRight,
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
          mainAxisAlignment: btnMainAxisAlignment ?? MainAxisAlignment.center,
          crossAxisAlignment:
              btnCrossAxisAlignment ?? CrossAxisAlignment.center,
          children: [
            if (prefix != null) prefix!,
            SizedBox(
              width: textMarginLeft ?? 0,
            ),
            isExpanded
                ? Expanded(
                    child: Column(
                      mainAxisAlignment:
                          textMainAxisAlignment ?? MainAxisAlignment.start,
                      crossAxisAlignment:
                          textCrossAxisAlignment ?? CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          child: Text(
                            title,
                            style: titleStyle ??
                                const TextStyle(color: Colors.white),
                            textAlign: titleAlign ?? TextAlign.center,
                          ),
                        ),
                        subTitle.isNotEmpty
                            ? Text(
                                subTitle,
                                style: subTitleStyle ??
                                    const TextStyle(color: Colors.white),
                                textAlign: subAlign ?? TextAlign.center,
                              )
                            : const SizedBox.shrink(),
                      ],
                    ),
                  )
                : Text(
                    title,
                    style: titleStyle ?? const TextStyle(color: Colors.white),
                    textAlign: titleAlign ?? TextAlign.center,
                  ),
            SizedBox(
              width: textMarginRight ?? 0,
            ),
            if (suffix != null) suffix!,
          ],
        ),
      ),
    );
  }
}
