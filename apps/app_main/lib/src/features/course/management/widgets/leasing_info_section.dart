library;

import 'package:flutter/material.dart';

/// 租赁信息区域组件
///
/// 显示课架租赁信息和操作按钮
class LeasingInfoSection extends StatelessWidget {
  /// 租赁类型：yearly/quarterly/monthly/usage
  final String leasingType;

  /// 租赁类型文本
  final String leasingTypeText;

  /// 剩余天数（周期性付费）
  final int? remainingDays;

  /// 到期日期（周期性付费）
  final String? expiryDate;

  /// 剩余小时数（按量付费）
  final int? remainingHours;

  /// 剩余分钟数（按量付费）
  final int? remainingMinutes;

  /// 续费回调
  final VoidCallback? onRenewal;

  /// 变更套餐回调
  final VoidCallback? onChangePackage;

  /// 下架回调
  final VoidCallback? onTakeDown;

  const LeasingInfoSection({
    super.key,
    required this.leasingType,
    required this.leasingTypeText,
    this.remainingDays,
    this.expiryDate,
    this.remainingHours,
    this.remainingMinutes,
    this.onRenewal,
    this.onChangePackage,
    this.onTakeDown,
  });

  @override
  Widget build(BuildContext context) {
    String leasingInfo;

    if (leasingType == 'usage') {
      // 流量模式
      leasingInfo = '$leasingTypeText 剩余${remainingHours}小时${remainingMinutes}分';
    } else {
      // 周期性付费模式
      leasingInfo = '$leasingTypeText 剩余${remainingDays}天 $expiryDate到期';
    }

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 租赁信息标题
          Row(
            children: [
              Icon(
                Icons.access_time,
                size: 18,
                color: Colors.grey[600],
              ),
              const SizedBox(width: 6),
              Text(
                '租赁信息',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          // 租赁信息 + 操作按钮
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 左侧：放大的租赁信息
              Expanded(
                child: Text(
                  leasingInfo,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),

              // 右侧：操作按钮
              Row(
                children: [
                  if (onRenewal != null)
                    _buildActionButton('续费', onRenewal!),
                  const Text('|', style: TextStyle(color: Colors.grey)),
                  if (onChangePackage != null)
                    _buildActionButton('变更套餐', onChangePackage!),
                  const Text('|', style: TextStyle(color: Colors.grey)),
                  if (onTakeDown != null)
                    _buildActionButton('下架', onTakeDown!),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// 构建操作按钮
  Widget _buildActionButton(String text, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 13,
            color: Color(0xFFFF4757),
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
