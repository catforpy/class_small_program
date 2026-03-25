library;

import 'package:flutter/material.dart';
import '../../../../shared/widgets/cards/activity_card.dart';

/// 活动管理标签页
///
/// 管理课程的各种营销活动
class ActivityManagementTab extends StatefulWidget {
  /// 课程信息（包含活动配置）
  final Map<String, dynamic> courseInfo;

  /// 课程信息变化回调
  final ValueChanged<Map<String, dynamic>>? onCourseInfoChanged;

  const ActivityManagementTab({
    super.key,
    required this.courseInfo,
    this.onCourseInfoChanged,
  });

  @override
  State<ActivityManagementTab> createState() => _ActivityManagementTabState();
}

class _ActivityManagementTabState extends State<ActivityManagementTab> {
  late Map<String, dynamic> _courseInfo;

  @override
  void initState() {
    super.initState();
    _courseInfo = Map.from(widget.courseInfo);
  }

  @override
  void didUpdateWidget(ActivityManagementTab oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.courseInfo != oldWidget.courseInfo) {
      _courseInfo = Map.from(widget.courseInfo);
    }
  }

  void _updateCourseInfo(Map<String, dynamic> newInfo) {
    setState(() {
      _courseInfo = newInfo;
    });
    widget.onCourseInfoChanged?.call(_courseInfo);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // 活动价设置
        ActivityCard(
          icon: Icons.local_offer,
          title: '活动价设置',
          subtitle: '开启后可以设置促销价格',
          enabled: _courseInfo['hasPromotion'] as bool? ?? false,
          onToggle: (value) {
            final newInfo = Map<String, dynamic>.from(_courseInfo);
            newInfo['hasPromotion'] = value;
            _updateCourseInfo(newInfo);

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(value ? '已开启活动价' : '已关闭活动价'),
                backgroundColor: value ? Colors.green : Colors.orange,
              ),
            );
          },
          onTap: () {
            if (_courseInfo['hasPromotion'] as bool? ?? false) {
              _showPromotionPriceDialog();
            }
          },
        ),

        const SizedBox(height: 16),

        // 转发赠金活动
        ActivityCard(
          icon: Icons.card_giftcard,
          title: '转发赠金活动',
          subtitle: '开启后用户分享可获得赠金',
          enabled: _courseInfo['hasCommission'] as bool? ?? false,
          onToggle: (value) {
            final newInfo = Map<String, dynamic>.from(_courseInfo);
            newInfo['hasCommission'] = value;
            _updateCourseInfo(newInfo);

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(value ? '已开启转发赠金' : '已关闭转发赠金'),
                backgroundColor: value ? Colors.green : Colors.orange,
              ),
            );
          },
          onTap: () {
            if (_courseInfo['hasCommission'] as bool? ?? false) {
              _showCommissionSettingsDialog();
            }
          },
        ),

        const SizedBox(height: 16),

        // 限时免费活动
        ActivityCard(
          icon: Icons.access_time,
          title: '限时免费活动',
          subtitle: '开启后课程可免费观看',
          enabled: _courseInfo['hasFreeTrial'] as bool? ?? false,
          onToggle: (value) {
            final newInfo = Map<String, dynamic>.from(_courseInfo);
            newInfo['hasFreeTrial'] = value;
            _updateCourseInfo(newInfo);

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(value ? '已开启限时免费' : '已关闭限时免费'),
                backgroundColor: value ? Colors.green : Colors.orange,
              ),
            );
          },
          onTap: () {
            if (_courseInfo['hasFreeTrial'] as bool? ?? false) {
              _showFreeTrialDialog();
            }
          },
        ),

        const SizedBox(height: 16),

        // 新用户专享
        ActivityCard(
          icon: Icons.person_add,
          title: '新用户专享',
          subtitle: '新用户首次购买享受优惠',
          enabled: _courseInfo['hasNewUserOffer'] as bool? ?? false,
          onToggle: (value) {
            final newInfo = Map<String, dynamic>.from(_courseInfo);
            newInfo['hasNewUserOffer'] = value;
            _updateCourseInfo(newInfo);

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(value ? '已开启新用户专享' : '已关闭新用户专享'),
                backgroundColor: value ? Colors.green : Colors.orange,
              ),
            );
          },
          onTap: () {
            if (_courseInfo['hasNewUserOffer'] as bool? ?? false) {
              _showNewUserOfferDialog();
            }
          },
        ),
      ],
    );
  }

  /// 显示活动价设置对话框
  void _showPromotionPriceDialog() {
    final originalPrice = 19900;
    int tempPromotionPrice = _courseInfo['promotionPrice'] as int? ?? 15900;
    final TextEditingController priceController = TextEditingController(
      text: (tempPromotionPrice ~/ 100).toString(),
    );

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) {
          double discount = (tempPromotionPrice / originalPrice) * 10;

          return AlertDialog(
            title: const Text('设置活动价'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '原价：¥${originalPrice ~/ 100}',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 16),
                const Text('活动价：', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                const SizedBox(height: 8),
                TextField(
                  controller: priceController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Color(0xFFFF4757), width: 2),
                    ),
                    prefixText: '¥ ',
                    hintText: '请输入活动价格',
                  ),
                  onChanged: (value) {
                    final newPrice = (double.tryParse(value) ?? 0) * 100;
                    setDialogState(() {
                      tempPromotionPrice = newPrice.toInt();
                    });
                  },
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.orange.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Colors.orange.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '折扣：',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[700],
                        ),
                      ),
                      Text(
                        '${discount.toStringAsFixed(1)}折',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange[700],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('取消'),
              ),
              ElevatedButton(
                onPressed: () {
                  final newInfo = Map<String, dynamic>.from(_courseInfo);
                  newInfo['promotionPrice'] = tempPromotionPrice;
                  _updateCourseInfo(newInfo);
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('活动价已设置为¥${tempPromotionPrice ~/ 100}'),
                      backgroundColor: Colors.green,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF4757),
                ),
                child: const Text('确定'),
              ),
            ],
          );
        },
      ),
    );
  }

  /// 显示赠金设置对话框
  void _showCommissionSettingsDialog() {
    int tempCommissionRate = _courseInfo['commissionRate'] as int? ?? 10;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('设置转发赠金'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 赠金比例显示
              Center(
                child: Text(
                  '赠金比例：$tempCommissionRate%',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFF4757),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // 滑动条
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '1%',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                      Text(
                        '50%',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  Slider(
                    value: tempCommissionRate.toDouble(),
                    min: 1,
                    max: 50,
                    divisions: 49,
                    activeColor: const Color(0xFFFF4757),
                    onChanged: (value) {
                      setDialogState(() {
                        tempCommissionRate = value.toInt();
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text('赠金说明：'),
              const SizedBox(height: 8),
              Text(
                '• 用户分享课程后，购买者支付课程金额\n'
                '• 分享者获得${tempCommissionRate}%的赠金奖励\n'
                '• 赠金将在交易完成后7个工作日到账\n'
                '• 退款订单不计入赠金',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[700],
                  height: 1.5,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('取消'),
            ),
            ElevatedButton(
              onPressed: () {
                final newInfo = Map<String, dynamic>.from(_courseInfo);
                newInfo['commissionRate'] = tempCommissionRate;
                _updateCourseInfo(newInfo);
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('赠金比例已设置为$tempCommissionRate%'),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF4757),
              ),
              child: const Text('确定'),
            ),
          ],
        ),
      ),
    );
  }

  /// 显示限时免费设置对话框
  void _showFreeTrialDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('限时免费设置'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '开启后，所有用户可免费观看课程内容',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              '温馨提示：',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Colors.orange,
              ),
            ),
            Text(
              '• 免费期间不产生收益\n'
              '• 可随时关闭免费活动\n'
              '• 关闭后已购买的用户不受影响',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[700],
                height: 1.5,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('限时免费设置已保存'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFF4757),
            ),
            child: const Text('确定'),
          ),
        ],
      ),
    );
  }

  /// 显示新用户专享设置对话框
  void _showNewUserOfferDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('新用户专享设置'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '新用户首次购买可享受优惠',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              '优惠方案：',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            Text(
              '• 首次购买享8折优惠\n'
              '• 仅限首次购买的用户\n'
              '• 每个用户仅可享受一次',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[700],
                height: 1.5,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('新用户专享设置已保存'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFF4757),
            ),
            child: const Text('确定'),
          ),
        ],
      ),
    );
  }
}
