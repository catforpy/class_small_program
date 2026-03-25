library;

import 'package:flutter/material.dart';

/// 应用统一样式管理
///
/// 集中管理应用中常用的样式，避免重复定义
class AppStyles {
  AppStyles._(); // 私有构造函数，防止实例化

  // ==================== 卡片样式 ====================

  /// 默认卡片装饰
  static const BoxDecoration cardDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.all(Radius.circular(12)),
    boxShadow: [
      BoxShadow(
        color: Color(0x0D000000),
        blurRadius: 10,
        offset: Offset(0, 2),
      ),
    ],
  );

  /// 简单卡片装饰（无阴影）
  static BoxDecoration simpleCardDecoration({Color? borderColor}) {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(
        color: borderColor ?? Colors.grey.withValues(alpha: 0.2),
      ),
    );
  }

  /// 圆角边框
  static RoundedRectangleBorder roundedRectangleBorder({double radius = 12}) {
    return RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(radius),
    );
  }

  // ==================== 按钮样式 ====================

  /// 主要按钮样式
  static final primaryButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: const Color(0xFFFF4757),
    foregroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
  );

  /// 次要按钮样式
  static final secondaryButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: Colors.grey[200],
    foregroundColor: Colors.black87,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
  );

  /// 描边按钮样式
  static final outlineButtonStyle = OutlinedButton.styleFrom(
    foregroundColor: const Color(0xFFFF4757),
    side: const BorderSide(color: Color(0xFFFF4757)),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
  );

  /// 危险按钮样式
  static final dangerButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: Colors.red,
    foregroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
  );

  // ==================== 输入框样式 ====================

  /// 默认输入框装饰
  static InputDecoration inputDecoration({String? hintText}) {
    return InputDecoration(
      hintText: hintText,
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey.withValues(alpha: 0.3)),
      ),
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        borderSide: BorderSide(color: Color(0xFFFF4757), width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    );
  }

  /// 带图标的输入框
  static InputDecoration inputWithIcon({
    IconData? icon,
    String? hintText,
  }) {
    return InputDecoration(
      hintText: hintText,
      prefixIcon: icon != null ? Icon(icon) : null,
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey.withValues(alpha: 0.3)),
      ),
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        borderSide: BorderSide(color: Color(0xFFFF4757), width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    );
  }

  // ==================== 文本样式 ====================

  /// 标题样式（大号）
  static const TextStyle titleLarge = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.black87,
  );

  /// 标题样式（中号）
  static const TextStyle titleMedium = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.black87,
  );

  /// 标题样式（小号）
  static const TextStyle titleSmall = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.black87,
  );

  /// 正文样式
  static const TextStyle bodyText = TextStyle(
    fontSize: 14,
    color: Colors.black87,
  );

  /// 副标题样式
  static TextStyle subtitleText(BuildContext context) {
    return TextStyle(
      fontSize: 13,
      color: Colors.grey[600],
    );
  }

  /// 说明文字样式
  static TextStyle captionText(BuildContext context) {
    return TextStyle(
      fontSize: 12,
      color: Colors.grey[500],
    );
  }

  // ==================== 价格样式 ====================

  /// 当前价格样式
  static const TextStyle currentPrice = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Color(0xFFFF4757),
  );

  /// 原价样式
  static TextStyle originalPrice(BuildContext context) {
    return TextStyle(
      fontSize: 14,
      color: Colors.grey[400],
      decoration: TextDecoration.lineThrough,
    );
  }

  // ==================== 间距 ====================

  /// 标准间距
  static const double spacingSmall = 8.0;
  static const double spacingMedium = 16.0;
  static const double spacingLarge = 24.0;

  /// 内边距
  static const double paddingSmall = 8.0;
  static const double paddingMedium = 16.0;
  static const double paddingLarge = 24.0;

  // ==================== 颜色 ====================

  /// 主题颜色
  static const Color primaryColor = Color(0xFFFF4757);
  static const Color backgroundColor = Color(0xFFF8F9FA);
  static const Color dividerColor = Color(0xFFEEEEEE);
  static const Color errorColor = Colors.red;
  static const Color successColor = Colors.green;
  static const Color warningColor = Colors.orange;

  /// 文字颜色
  static const Color textPrimary = Colors.black87;
  static const Color textSecondary = Colors.black54;
  static const Color textHint = Colors.black38;
}
