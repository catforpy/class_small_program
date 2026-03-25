library;

import 'package:flutter/material.dart';

/// 底部操作导航栏
///
/// 用于课程详情页的底部操作按钮（收藏、提问、购买）
class BottomActionNav extends StatelessWidget {
  /// 价格（分）
  final int price;

  /// 原价（分）
  final int? originalPrice;

  /// 是否已收藏
  final bool isFavorited;

  /// 收藏回调
  final VoidCallback? onFavorite;

  /// 提问回调
  final VoidCallback? onQuestion;

  /// 购买回调
  final VoidCallback? onPurchase;

  /// 是否显示试看按钮
  final bool hasTrial;

  /// 试看回调
  final VoidCallback? onTrial;

  const BottomActionNav({
    super.key,
    required this.price,
    this.originalPrice,
    this.isFavorited = false,
    this.onFavorite,
    this.onQuestion,
    this.onPurchase,
    this.hasTrial = false,
    this.onTrial,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            // 收藏按钮
            _buildActionButton(
              icon: isFavorited ? Icons.favorite : Icons.favorite_border,
              label: '收藏',
              onTap: onFavorite,
              iconColor: isFavorited ? Colors.red : Colors.grey[600],
            ),

            const SizedBox(width: 8),

            // 提问按钮
            _buildActionButton(
              icon: Icons.question_answer_outlined,
              label: '提问',
              onTap: onQuestion,
            ),

            const Spacer(),

            // 试看按钮
            if (hasTrial && onTrial != null)
              ElevatedButton(
                onPressed: onTrial,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color(0xFFFF4757),
                  side: const BorderSide(color: Color(0xFFFF4757)),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('免费试看'),
              ),

            if (hasTrial && onTrial != null) const SizedBox(width: 12),

            // 购买按钮
            Expanded(
              child: ElevatedButton(
                onPressed: onPurchase,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF4757),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (originalPrice != null && originalPrice! > price) ...[
                      Text(
                        '¥${(price / 100).toStringAsFixed(0)}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '¥${(originalPrice! / 100).toStringAsFixed(0)}',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white.withValues(alpha: 0.7),
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ] else
                      Text(
                        '¥${(price / 100).toStringAsFixed(0)}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 构建操作按钮
  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback? onTap,
    Color? iconColor,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 24,
              color: iconColor ?? Colors.grey[600],
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
