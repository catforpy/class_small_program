library;

import 'package:flutter/material.dart';

/// 标签项数据模型
class TabItem {
  /// 标签文字
  final String label;

  /// 角标文字（如 "99+"、"试看"）
  final String? badge;

  /// 标签图标（可选）
  final IconData? icon;

  const TabItem({
    required this.label,
    this.badge,
    this.icon,
  });
}

/// 统一标签栏组件
///
/// 用途：
/// - 课程详情页标签（章节、评论、问答、笔记）
/// - 学习页面标签
/// - 个人中心标签
/// - 其他需要标签切换的页面
class CommonTabBar extends StatelessWidget {
  /// 标签列表
  final List<TabItem> tabs;

  /// 当前选中索引
  final int currentIndex;

  /// 标签点击事件
  final ValueChanged<int> onTap;

  /// 是否可横向滚动
  final bool isScrollable;

  /// 指示器颜色
  final Color? indicatorColor;

  /// 标签文字颜色
  final Color? labelColor;

  /// 选中标签文字颜色
  final Color? selectedLabelColor;

  /// 标签文字大小
  final double? fontSize;

  /// 指示器高度
  final double indicatorHeight;

  /// 背景颜色
  final Color? backgroundColor;

  /// TabController（可选，由父组件提供）
  final TabController? controller;

  const CommonTabBar({
    super.key,
    required this.tabs,
    required this.currentIndex,
    required this.onTap,
    this.isScrollable = true,
    this.indicatorColor,
    this.labelColor,
    this.selectedLabelColor,
    this.fontSize,
    this.indicatorHeight = 3,
    this.backgroundColor,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    // 确定颜色
    final defaultIndicatorColor = indicatorColor ?? const Color(0xFFFF4757);
    final defaultLabelColor = labelColor ?? Colors.grey[600]!;
    final defaultSelectedLabelColor = selectedLabelColor ?? defaultIndicatorColor;

    return Container(
      color: backgroundColor ?? Colors.white,
      child: TabBar(
        controller: controller,
        isScrollable: isScrollable,
        onTap: onTap,
        labelColor: defaultLabelColor,
        labelStyle: TextStyle(
          fontSize: fontSize ?? 15,
        ),
        unselectedLabelColor: defaultLabelColor,
        unselectedLabelStyle: TextStyle(
          fontSize: fontSize ?? 15,
        ),
        indicatorColor: defaultIndicatorColor,
        indicatorWeight: indicatorHeight,
        labelPadding: const EdgeInsets.symmetric(horizontal: 8),
        tabs: tabs.map((tab) {
          if (tab.badge != null || tab.icon != null) {
            return _buildTabWithBadge(tab, defaultSelectedLabelColor);
          }
          return Tab(text: tab.label);
        }).toList(),
      ),
    );
  }

  /// 构建带角标的标签
  Widget _buildTabWithBadge(TabItem tab, Color selectedColor) {
    return Tab(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (tab.icon != null) ...[
                  Icon(tab.icon, size: 18),
                  const SizedBox(width: 6),
                ],
                Text(tab.label),
              ],
            ),
          ),
          // 角标
          if (tab.badge != null)
            Positioned(
              top: 0,
              right: -12,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                decoration: BoxDecoration(
                  color: selectedColor,
                  borderRadius: BorderRadius.circular(6),
                ),
                constraints: const BoxConstraints(
                  minWidth: 16,
                ),
                child: Text(
                  tab.badge!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 9,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
