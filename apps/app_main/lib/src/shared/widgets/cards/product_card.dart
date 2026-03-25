library;

import 'package:flutter/material.dart';

/// 商品/课程卡片组件
///
/// 用途：
/// - 首页推荐商品列表
/// - 分类页面课程列表
/// - 搜索结果列表
/// - 相关课程推荐
class ProductCard extends StatelessWidget {
  /// 商品图片URL
  final String imageUrl;

  /// 商品标题
  final String title;

  /// 商品副标题（可选）
  final String? subtitle;

  /// 价格（单位：分）
  final int price;

  /// 原价（可选，单位：分）
  final int? originalPrice;

  /// 学习人数
  final int studyCount;

  /// 是否有赠金活动
  final bool hasCommission;

  /// 赠金比例（可选）
  final int? commissionRate;

  /// 是否显示标签
  final bool showTag;

  /// 标签文字
  final String? tagText;

  /// 标签颜色
  final Color? tagColor;

  /// 点击事件
  final VoidCallback? onTap;

  /// 卡片宽度（可选，默认自适应）
  final double? width;

  /// 卡片高度（可选，默认自适应）
  final double? height;

  const ProductCard({
    super.key,
    required this.imageUrl,
    required this.title,
    this.subtitle,
    required this.price,
    this.originalPrice,
    required this.studyCount,
    this.hasCommission = false,
    this.commissionRate,
    this.showTag = false,
    this.tagText,
    this.tagColor,
    this.onTap,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
        ),
        child: Row(
          children: [
            // 商品图片
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                imageUrl,
                width: 100,
                height: 75,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  width: 100,
                  height: 75,
                  color: Colors.grey[300],
                  child: const Icon(Icons.image, size: 32),
                ),
              ),
            ),
            const SizedBox(width: 12),
            // 商品信息
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // 标题和标签
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      // 赠金标签
                      if (hasCommission && commissionRate != null)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.orange.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                              color: Colors.orange.withValues(alpha: 0.3),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.card_giftcard,
                                size: 11,
                                color: Colors.orange[700],
                              ),
                              const SizedBox(width: 2),
                              Text(
                                '赠金$commissionRate%',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.orange[700],
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      // 自定义标签
                      if (showTag && tagText != null)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                          decoration: BoxDecoration(
                            color: tagColor ?? Colors.blue.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                              color: tagColor ?? Colors.blue.withValues(alpha: 0.3),
                            ),
                          ),
                          child: Text(
                            tagText!,
                            style: TextStyle(
                              fontSize: 10,
                              color: tagColor ?? Colors.blue,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  // 副标题
                  if (subtitle != null)
                    Text(
                      subtitle!,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  const SizedBox(height: 8),
                  // 价格和学习人数
                  Row(
                    children: [
                      Text(
                        '¥${price ~/ 100}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFFF4757),
                        ),
                      ),
                      if (originalPrice != null) ...[
                        const SizedBox(width: 8),
                        Text(
                          '¥${originalPrice! ~/ 100}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[400],
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ],
                      const Spacer(),
                      Text(
                        '${(studyCount / 1000).toStringAsFixed(1)}k人学',
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
