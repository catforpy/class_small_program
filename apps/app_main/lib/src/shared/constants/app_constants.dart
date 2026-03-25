library;

import 'package:flutter/material.dart';

/// 应用常量配置
///
/// 集中管理应用中的常量，便于统一修改
class AppConstants {
  AppConstants._(); // 私有构造函数，防止实例化

  // ==================== 标签配置 ====================

  /// 首页标签
  static const List<String> homeTabs = ['推荐', '关注', '热门', '视频', '话题', '活动'];

  /// 课程详情页标签
  static const List<String> courseDetailTabs = ['课程介绍', '章节目录', '售前咨询', '用户评价'];

  /// 学习页面标签
  static const List<String> studyTabs = ['学习', '资料', '目录'];

  // ==================== 分页配置 ====================

  /// 默认每页数量
  static const int pageSize = 20;

  /// 最大每页数量
  static const int maxPageSize = 100;

  // ==================== 图片尺寸 ====================

  /// 课程缩略图尺寸
  static const double courseThumbnailWidth = 100.0;
  static const double courseThumbnailHeight = 75.0;

  /// 课程封面尺寸
  static const double courseCoverWidth = 600.0;
  static const double courseCoverHeight = 400.0;

  /// 用户头像尺寸
  static const double avatarSmall = 32.0;
  static const double avatarMedium = 48.0;
  static const double avatarLarge = 64.0;

  // ==================== 价格相关 ====================

  /// 价格单位（分）
  static const int priceUnit = 100;

  /// 赠金最小比例
  static const int minCommissionRate = 1;

  /// 赠金最大比例
  static const int maxCommissionRate = 50;

  // ==================== 评分相关 ====================

  /// 最小评分
  static const double minRating = 1.0;

  /// 最大评分
  static const double maxRating = 5.0;

  /// 默认评分
  static const double defaultRating = 5.0;

  // ==================== 动画时长 ====================

  /// 短动画时长
  static const Duration animationDurationShort = Duration(milliseconds: 200);

  /// 中等动画时长
  static const Duration animationDurationMedium = Duration(milliseconds: 300);

  /// 长动画时长
  static const Duration animationDurationLong = Duration(milliseconds: 500);

  // ==================== 超时配置 ====================

  /// 网络请求超时
  static const Duration networkTimeout = Duration(seconds: 30);

  /// 缓存时长
  static const Duration cacheDuration = Duration(hours: 24);

  // ==================== 文本长度限制 ====================

  /// 标题最大长度
  static const int maxTitleLength = 50;

  /// 描述最大长度
  static const int maxDescriptionLength = 200;

  /// 评论最大长度
  static const int maxCommentLength = 500;

  // ==================== 数值范围 ====================

  /// 最大收藏数量显示
  static const int maxFavoriteCount = 999;

  /// 最大学习人数显示（以k为单位）
  static const int maxStudyCount = 999000;

  /// 最大粉丝数显示（以k为单位）
  static const int maxFollowerCount = 999000;

  // ==================== 格式化 ====================

  /// 格式化价格（分 -> 元）
  static String formatPrice(int priceInCents) {
    return '¥${(priceInCents / 100).toStringAsFixed(0)}';
  }

  /// 格式化学习人数
  static String formatStudyCount(int count) {
    if (count >= 10000) {
      return '${(count / 1000).toStringAsFixed(0)}k';
    } else if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}k';
    } else {
      return count.toString();
    }
  }

  /// 格式化粉丝数
  static String formatFollowers(int count) {
    if (count >= 10000) {
      return '${(count / 10000).toStringAsFixed(1)}万';
    } else if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}k';
    } else {
      return count.toString();
    }
  }

  /// 格式化时长（秒 -> 可读格式）
  static String formatDuration(int seconds) {
    final hours = seconds ~/ 3600;
    final minutes = (seconds % 3600) ~/ 60;
    final secs = seconds % 60;

    if (hours > 0) {
      return '${hours}小时${minutes}分钟';
    } else if (minutes > 0) {
      return '${minutes}分钟${secs}秒';
    } else {
      return '${secs}秒';
    }
  }

  // ==================== 正则表达式 ====================

  /// 手机号正则（中国大陆）
  static const RegExp phoneRegExp = RegExp(r'^1[3-9]\d{9}$');

  /// 邮箱正则
  static const RegExp emailRegExp = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  /// 身份证号正则
  static const RegExp idCardRegExp = RegExp(r'^[1-9]\d{5}(18|19|20)\d{2}((0[1-9])|(1[0-2]))\d{3}[0-9Xx]$');
}
