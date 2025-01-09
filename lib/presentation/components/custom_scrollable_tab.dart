import 'package:flutter/material.dart';
import 'package:movie_marks/config/theme/app_colors.dart';
import 'package:movie_marks/config/theme/app_text_styles.dart';
import 'package:scrollable_list_tab_scroller/scrollable_list_tab_scroller.dart';

class CustomScrollableTab extends StatelessWidget {
  final Map<String, Widget> data;
  final double? headerHeight;
  final HeaderContainerProps? headerContainerProps;
  final double? earlyChangePositionOffset;
  final EdgeInsets? tabPadding;
  final TextStyle? tabTextStyle;
  final TextStyle? itemTextStyle;
  final Color? indicatorColor;
  final Color? dividerColor;
  final BorderSide? indicatorBorderSide;
  final EdgeInsetsGeometry? indicatorInsets;
  final MainAxisSize? mainAxisSize;
  final MainAxisAlignment? mainAxisAlignment;
  final CrossAxisAlignment? crossAxisAlignment;

  const CustomScrollableTab(
      {super.key,
      required this.data,
      this.headerHeight,
      this.headerContainerProps,
      this.earlyChangePositionOffset,
      this.tabPadding,
      this.tabTextStyle,
      this.itemTextStyle,
      this.indicatorColor,
      this.dividerColor,
      this.indicatorBorderSide,
      this.indicatorInsets,
      this.mainAxisSize,
      this.mainAxisAlignment,
      this.crossAxisAlignment});

  @override
  Widget build(BuildContext context) {
    return ScrollableListTabScroller.defaultComponents(
      headerContainerProps: headerContainerProps ??
          HeaderContainerProps(height: headerHeight ?? 50),
      tabBarProps: TabBarProps(
        indicatorColor: indicatorColor ?? AppColors.brightGray,
        dividerColor: dividerColor ?? AppColors.brightGray,
        indicator: UnderlineTabIndicator(
          borderSide: indicatorBorderSide ??
              const BorderSide(
                width: 4.0,
                color: AppColors.brightGray,
              ),
          insets: indicatorInsets ?? EdgeInsets.zero,
        ),
      ),
      itemCount: data.length,
      earlyChangePositionOffset: earlyChangePositionOffset ?? 30,
      tabBuilder: (BuildContext context, int index, bool active) => Padding(
        padding: tabPadding ?? const EdgeInsets.all(10),
        child: Text(
          data.keys.elementAt(index),
          style: !active
              ? AppTextStyles.beVietNamProStyles.semiBold14BrightGray
              : tabTextStyle ??
                  AppTextStyles.beVietNamProStyles.semiBold14White,
        ),
      ),
      itemBuilder: (BuildContext context, int index) => Column(
        mainAxisSize: mainAxisSize ?? MainAxisSize.min,
        mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.center,
        crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.center,
        children: [
          Text(
            data.keys.elementAt(index),
            style: itemTextStyle ??
                AppTextStyles.beVietNamProStyles.semiBold14White,
          ),
          data.values.elementAt(index),
        ],
      ),
    );
  }
}
