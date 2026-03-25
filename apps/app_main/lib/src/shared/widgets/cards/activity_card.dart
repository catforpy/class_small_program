library;

import 'package:flutter/material.dart';

/// 活动卡片组件
///
/// 用途：
/// - 活动管理页面的活动开关卡片
/// - 活动价设置、转发赠金、限时免费、新用户专享等
class ActivityCard extends StatelessWidget {
  /// 活动图标
  final IconData icon;

  /// 活动标题
  final String title;

  /// 活动副标题
  final String subtitle;

  /// 是否启用
  final bool enabled;

  /// 开关切换事件
  final ValueChanged<bool> onToggle;

  /// 点击设置事件
  final VoidCallback? onTap;

  /// 活动颜色（启用时）
  final Color? activeColor;

  const ActivityCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.enabled,
    required this.onToggle,
    this.onTap,
    this.activeColor,
  });

  @override
  Widget build(BuildContext context) {
    final defaultActiveColor = activeColor ?? const Color(0xFFFF4757);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: enabled ? defaultActiveColor : Colors.grey.withValues(alpha: 0.3),
          width: enabled ? 2 : 1,
        ),
      ),
      child: Column(
        children: [
          // 标题行：图标、标题、开关
          Row(
            children: [
              // 图标
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: enabled
                      ? defaultActiveColor.withValues(alpha: 0.1)
                      : Colors.grey.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  icon,
                  color: enabled ? defaultActiveColor : Colors.grey[600],
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              // 标题和副标题
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: enabled ? defaultActiveColor : Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              // 开关
              Switch(
                value: enabled,
                onChanged: onToggle,
                activeColor: defaultActiveColor,
              ),
            ],
          ),
          // 启用时显示设置按钮
          if (enabled && onTap != null) ...[
            const SizedBox(height: 12),
            const Divider(),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: onTap,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: defaultActiveColor.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '点击设置详细参数',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[700],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Colors.grey[700],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
