library;

import 'package:flutter/material.dart';
import 'stat_card.dart';

/// 数据统计标签页
///
/// 显示销售、转发、学习等数据统计
class DataStatsTab extends StatelessWidget {
  /// 销售数量
  final int salesCount;

  /// 总收入
  final double totalRevenue;

  /// 转发次数
  final int forwardCount;

  /// 查看销售详情回调
  final VoidCallback? onViewSalesDetails;

  /// 查看转发详情回调
  final VoidCallback? onViewForwardDetails;

  /// 查看学习详情回调
  final VoidCallback? onViewStudyDetails;

  const DataStatsTab({
    super.key,
    required this.salesCount,
    required this.totalRevenue,
    required this.forwardCount,
    this.onViewSalesDetails,
    this.onViewForwardDetails,
    this.onViewStudyDetails,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // 销售数据
        StatCard(
          icon: Icons.attach_money,
          iconColor: Colors.green,
          title: '销售数据',
          stats: [
            {'label': '销售数量', 'value': '$salesCount', 'unit': '份'},
            {'label': '总收入', 'value': '¥${totalRevenue.toStringAsFixed(2)}', 'unit': ''},
          ],
          onTap: onViewSalesDetails,
        ),

        const SizedBox(height: 16),

        // 转发数据
        StatCard(
          icon: Icons.share,
          iconColor: Colors.blue,
          title: '转发数据',
          stats: [
            {'label': '转发次数', 'value': '$forwardCount', 'unit': '次'},
            {'label': '转发转化', 'value': '12.5', 'unit': '%'},
          ],
          onTap: onViewForwardDetails,
        ),

        const SizedBox(height: 16),

        // 学习数据
        StatCard(
          icon: Icons.school,
          iconColor: Colors.orange,
          title: '学习数据',
          stats: [
            {'label': '学习人数', 'value': '$salesCount', 'unit': '人'},
            {'label': '完课率', 'value': '68.3', 'unit': '%'},
          ],
          onTap: onViewStudyDetails,
        ),
      ],
    );
  }
}
