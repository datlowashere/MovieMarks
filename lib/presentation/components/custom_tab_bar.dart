import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:movie_marks/config/theme/app_colors.dart';
import 'package:movie_marks/config/theme/app_text_styles.dart';

class CustomTabBar extends StatefulWidget {
  final Map<String, Widget> tabsWithViews;
  final EdgeInsetsGeometry? tabBarPadding;
  final TabAlignment? tabAlignment;
  final TextStyle? labelStyle;
  final TextStyle? unselectedLabelStyle;
  final EdgeInsetsGeometry? labelPadding;
  final Color? indicatorColor;
  final double? dividerHeight;
  final Color? dividerColor;

  const CustomTabBar({
    super.key,
    required this.tabsWithViews,
    this.tabAlignment,
    this.labelStyle,
    this.labelPadding,
    this.tabBarPadding,
    this.unselectedLabelStyle,
    this.indicatorColor,
    this.dividerHeight,
    this.dividerColor,
  });

  @override
  State<CustomTabBar> createState() =>
      _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: widget.tabsWithViews.length,
      vsync: this,
    );
    _pageController = PageController(initialPage: 0);

    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        _pageController.jumpToPage(_tabController.index);
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          widget.tabBarPadding ?? const EdgeInsets.symmetric(horizontal: 0),
      child: Column(
        children: [
          TabBar(
            padding: EdgeInsets.zero,
            tabAlignment: widget.tabAlignment ?? TabAlignment.start,
            controller: _tabController,
            isScrollable: true,
            labelPadding:
                widget.labelPadding ?? const EdgeInsets.only(right: 32),
            labelStyle: widget.labelStyle ??
                AppTextStyles.beVietNamProStyles.semiBold14White,
            unselectedLabelStyle: widget.unselectedLabelStyle ??
                AppTextStyles.beVietNamProStyles.semiBold14White,
            indicatorWeight: widget.dividerHeight ?? 4,
            overlayColor: const WidgetStatePropertyAll(Colors.transparent),
            indicatorColor: widget.indicatorColor ?? AppColors.brightGray,
            dividerColor: widget.dividerColor ?? Colors.white,
            indicator: UnderlineTabIndicator(
              borderSide: const BorderSide(
                width: 4.0,
                color: AppColors.brightGray,
              ),
              borderRadius: BorderRadius.circular(16),
              insets: const EdgeInsets.symmetric(horizontal: 0),
            ),
            tabs: widget.tabsWithViews.keys
                .map((tabTitle) => Tab(text: tabTitle))
                .toList(),
            onTap: (index) {
              _pageController.animateToPage(
                index,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
          ),
          ExpandablePageView(
            controller: _pageController,
            onPageChanged: (index) {
              _tabController.animateTo(index);
            },
            children: widget.tabsWithViews.values.toList(),
          ),
        ],
      ),
    );
  }
}
