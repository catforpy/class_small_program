library;

import 'package:flutter/material.dart';

/// 评价汇总卡片
///
/// 显示用户评价汇总信息
class ReviewSummaryCard extends StatelessWidget {
  /// 平均评分
  final double averageRating;

  /// 评价总数
  final int reviewCount;

  /// 评价示例列表
  final List<ReviewItem> reviews;

  /// 查看全部评价回调
  final VoidCallback? onViewAll;

  const ReviewSummaryCard({
    super.key,
    required this.averageRating,
    required this.reviewCount,
    required this.reviews,
    this.onViewAll,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 标题行
          Row(
            children: [
              const Icon(
                Icons.star,
                size: 28,
                color: Colors.amber,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '用户评价',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '$reviewCount 条评价',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '$averageRating',
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFF4757),
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(5, (index) {
                      return Icon(
                        Icons.star,
                        size: 16,
                        color: index < averageRating.floor()
                            ? Colors.amber
                            : Colors.grey[300],
                      );
                    }),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 12),
          // 评价示例
          ...reviews.map((review) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: ReviewItemWidget(
                author: review.author,
                rating: review.rating,
                content: review.content,
                date: review.date,
              ),
            );
          }),
          if (onViewAll != null)
            Center(
              child: TextButton(
                onPressed: onViewAll,
                child: const Text('查看全部评价'),
              ),
            ),
        ],
      ),
    );
  }
}

/// 评价项数据模型
class ReviewItem {
  final String author;
  final double rating;
  final String content;
  final String date;

  ReviewItem({
    required this.author,
    required this.rating,
    required this.content,
    required this.date,
  });
}

/// 单个评价项组件
class ReviewItemWidget extends StatelessWidget {
  final String author;
  final double rating;
  final String content;
  final String date;

  const ReviewItemWidget({
    super.key,
    required this.author,
    required this.rating,
    required this.content,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 20,
          backgroundColor: Colors.grey[200],
          child: Text(
            author[0],
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey[700],
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    author,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(5, (index) {
                      return Icon(
                        Icons.star,
                        size: 12,
                        color: index < rating.floor() ? Colors.amber : Colors.grey[300],
                      );
                    }),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                content,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 4),
              Text(
                date,
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey[500],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
