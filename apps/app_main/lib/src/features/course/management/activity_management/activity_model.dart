library;

import 'package:flutter/material.dart';

/// 活动配置数据模型
class ActivityConfig {
  final bool hasPromotion;
  final int promotionPrice;
  final bool hasCommission;
  final int commissionRate;
  final bool hasFreeTrial;
  final bool hasNewUserOffer;

  const ActivityConfig({
    this.hasPromotion = false,
    this.promotionPrice = 15900,
    this.hasCommission = true,
    this.commissionRate = 10,
    this.hasFreeTrial = false,
    this.hasNewUserOffer = false,
  });

  /// 从Map创建
  factory ActivityConfig.fromJson(Map<String, dynamic> json) {
    return ActivityConfig(
      hasPromotion: json['hasPromotion'] as bool? ?? false,
      promotionPrice: json['promotionPrice'] as int? ?? 15900,
      hasCommission: json['hasCommission'] as bool? ?? true,
      commissionRate: json['commissionRate'] as int? ?? 10,
      hasFreeTrial: json['hasFreeTrial'] as bool? ?? false,
      hasNewUserOffer: json['hasNewUserOffer'] as bool? ?? false,
    );
  }

  /// 转为Map
  Map<String, dynamic> toJson() {
    return {
      'hasPromotion': hasPromotion,
      'promotionPrice': promotionPrice,
      'hasCommission': hasCommission,
      'commissionRate': commissionRate,
      'hasFreeTrial': hasFreeTrial,
      'hasNewUserOffer': hasNewUserOffer,
    };
  }

  /// 复制并修改
  ActivityConfig copyWith({
    bool? hasPromotion,
    int? promotionPrice,
    bool? hasCommission,
    int? commissionRate,
    bool? hasFreeTrial,
    bool? hasNewUserOffer,
  }) {
    return ActivityConfig(
      hasPromotion: hasPromotion ?? this.hasPromotion,
      promotionPrice: promotionPrice ?? this.promotionPrice,
      hasCommission: hasCommission ?? this.hasCommission,
      commissionRate: commissionRate ?? this.commissionRate,
      hasFreeTrial: hasFreeTrial ?? this.hasFreeTrial,
      hasNewUserOffer: hasNewUserOffer ?? this.hasNewUserOffer,
    );
  }
}
