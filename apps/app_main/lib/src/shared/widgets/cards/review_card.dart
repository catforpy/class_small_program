library;

import 'package:flutter/material.dart';

/// 评价卡片组件
///
/// 用途：
/// - 课程详情页评价列表
/// - 商品评价列表
/// - 用户评价历史
class ReviewCard extends StatelessWidget {
  /// 用户名称
  final String userName;

  /// 用户头像URL
  final String avatarUrl;

  /// 评分（1-5）
  final int rating;

  /// 评价内容
  final String content;

  /// 评价时间
  final String time;

  /// 点赞数
  final int likes;

  /// 是否已点赞
  final bool isLiked;

  /// 点赞事件
  final VoidCallback? onLike;

  /// 点击事件
  final VoidCallback? onTap;

  /// 是否显示头像
  final bool showAvatar;

  /// 是否显示时间
  final bool showTime;

  /// 是否显示点赞按钮
  final bool showLikeButton;

  const ReviewCard({
    super.key,
    required this.userName,
    required this.avatarUrl,
    required this.rating,
    required this.content,
    required this.time,
    required this.likes,
    this.isLiked = false,
    this.onLike,
    this.onTap,
    this.showAvatar = true,
    this.showTime = true,
    this.showLikeButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 用户信息、评分、时间和点赞
            Row(
              children: [
                // 头像
                if (showAvatar)
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(avatarUrl),
                  ),
                if (showAvatar) const SizedBox(width: 12),
                // 用户名和评分
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userName,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4),
                      // 星级评分
                      Row(
                        children: List.generate(5, (index) {
                          return Icon(
                            index < rating ? Icons.star : Icons.star_border,
                            size: 14,
                            color: const Color(0xFFFFB400),
                          );
                        }),
                      ),
                    ],
                  ),
                ),
                // 时间
                if (showTime)
                  Text(
                    time,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[500],
                    ),
                  ),
                if (showTime) const SizedBox(width: 12),
                // 点赞按钮
                if (showLikeButton)
                  GestureDetector(
                    onTap: onLike,
                    child: Row(
                      children: [
                        Icon(
                          isLiked ? Icons.thumb_up : Icons.thumb_up_outlined,
                          size: 16,
                          color: isLiked
                              ? const Color(0xFFFF4757)
                              : Colors.grey[600],
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '$likes',
                          style: TextStyle(
                            fontSize: 12,
                            color: isLiked
                                ? const Color(0xFFFF4757)
                                : Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            // 评价内容
            Text(
              content,
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey[700],
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
