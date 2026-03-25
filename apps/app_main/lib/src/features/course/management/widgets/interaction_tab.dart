library;

import 'package:flutter/material.dart';
import 'interaction_card.dart';
import 'review_summary_card.dart';

/// 互动管理标签页
///
/// 显示售前咨询、课程答疑、用户评价等互动入口
class InteractionTab extends StatelessWidget {
  /// 咨询数量
  final int consultationCount;

  /// 答疑数量
  final int qaCount;

  /// 平均评分
  final double averageRating;

  /// 评价数量
  final int reviewCount;

  /// 查看咨询回调
  final VoidCallback? onViewConsultation;

  /// 查看答疑回调
  final VoidCallback? onViewQA;

  /// 查看全部评价回调
  final VoidCallback? onViewAllReviews;

  const InteractionTab({
    super.key,
    required this.consultationCount,
    required this.qaCount,
    required this.averageRating,
    required this.reviewCount,
    this.onViewConsultation,
    this.onViewQA,
    this.onViewAllReviews,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // 售前咨询
        InteractionCard(
          icon: Icons.support_agent,
          iconColor: Colors.blue,
          title: '售前咨询',
          count: consultationCount,
          description: '查看和回复学员的售前咨询',
          onTap: onViewConsultation,
        ),

        const SizedBox(height: 16),

        // 课程答疑
        InteractionCard(
          icon: Icons.question_answer,
          iconColor: Colors.green,
          title: '课程答疑',
          count: qaCount,
          description: '查看和回复学员的课程问题',
          onTap: onViewQA,
        ),

        const SizedBox(height: 16),

        // 用户评价
        ReviewSummaryCard(
          averageRating: averageRating,
          reviewCount: reviewCount,
          reviews: [
            ReviewItem(
              author: '张同学',
              rating: 5.0,
              content: '课程内容非常详细，老师讲得很好，干货满满！',
              date: '2026-03-20',
            ),
            ReviewItem(
              author: '李同学',
              rating: 4.5,
              content: '学到很多实用技能，项目实战很有帮助。',
              date: '2026-03-18',
            ),
          ],
          onViewAll: onViewAllReviews,
        ),
      ],
    );
  }
}
