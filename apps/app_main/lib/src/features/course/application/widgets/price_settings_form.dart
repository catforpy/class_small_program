library;

import 'package:flutter/material.dart';

/// 价格设置表单组件
///
/// 用于课程申请的价格设置输入
class PriceSettingsForm extends StatefulWidget {
  /// 初始价格
  final String? initialPrice;

  /// 初始原价
  final String? initialOriginalPrice;

  /// 是否有活动价
  final bool? initialHasActivity;

  /// 初始活动价
  final String? initialActivityPrice;

  /// 是否启用佣金
  final bool? initialCommissionEnabled;

  /// 初始佣金比例
  final double? initialCommissionRate;

  /// 表单变化回调
  final VoidCallback? onFormChanged;

  const PriceSettingsForm({
    super.key,
    this.initialPrice,
    this.initialOriginalPrice,
    this.initialHasActivity,
    this.initialActivityPrice,
    this.initialCommissionEnabled,
    this.initialCommissionRate,
    this.onFormChanged,
  });

  @override
  State<PriceSettingsForm> createState() => _PriceSettingsFormState();
}

class _PriceSettingsFormState extends State<PriceSettingsForm> {
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _originalPriceController = TextEditingController();
  final TextEditingController _activityPriceController = TextEditingController();

  bool _hasActivity = false;
  bool _commissionEnabled = true;
  double _commissionRate = 10.0;

  @override
  void initState() {
    super.initState();
    _priceController.text = widget.initialPrice ?? '199';
    _originalPriceController.text = widget.initialOriginalPrice ?? '299';
    _activityPriceController.text = widget.initialActivityPrice ?? '149';
    _hasActivity = widget.initialHasActivity ?? false;
    _commissionEnabled = widget.initialCommissionEnabled ?? true;
    _commissionRate = widget.initialCommissionRate ?? 10.0;
  }

  @override
  void dispose() {
    _priceController.dispose();
    _originalPriceController.dispose();
    _activityPriceController.dispose();
    super.dispose();
  }

  void _notifyChanged() {
    widget.onFormChanged?.call();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // 售价设置
        _buildSectionCard(
          title: '售价设置',
          child: Column(
            children: [
              // 售价
              TextField(
                controller: _priceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: '售价（元）',
                  hintText: '请输入售价',
                  border: OutlineInputBorder(),
                  prefixText: '¥ ',
                ),
                onChanged: (_) => _notifyChanged(),
              ),
              const SizedBox(height: 16),
              // 原价
              TextField(
                controller: _originalPriceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: '原价（元）',
                  hintText: '请输入原价',
                  border: OutlineInputBorder(),
                  prefixText: '¥ ',
                ),
                onChanged: (_) => _notifyChanged(),
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // 活动价设置
        _buildSectionCard(
          title: '活动价设置',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SwitchListTile(
                title: const Text('启用活动价'),
                subtitle: const Text('开启后可以设置促销价格'),
                value: _hasActivity,
                onChanged: (value) {
                  setState(() {
                    _hasActivity = value;
                  });
                  _notifyChanged();
                },
              ),
              if (_hasActivity) ...[
                const SizedBox(height: 12),
                TextField(
                  controller: _activityPriceController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: '活动价（元）',
                    hintText: '请输入活动价格',
                    border: OutlineInputBorder(),
                    prefixText: '¥ ',
                  ),
                  onChanged: (_) => _notifyChanged(),
                ),
                const SizedBox(height: 12),
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
                    children: [
                      const Icon(
                        Icons.info_outline,
                        color: Colors.orange,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          '活动价将在课程页面显示促销标签',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[700],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),

        const SizedBox(height: 16),

        // 转发赠金设置
        _buildSectionCard(
          title: '转发赠金设置',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SwitchListTile(
                title: const Text('启用转发赠金'),
                subtitle: const Text('开启后用户分享课程可获得赠金'),
                value: _commissionEnabled,
                onChanged: (value) {
                  setState(() {
                    _commissionEnabled = value;
                  });
                  _notifyChanged();
                },
              ),
              if (_commissionEnabled) ...[
                const SizedBox(height: 12),
                Text(
                  '赠金比例：${_commissionRate.toInt()}%',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFF4757),
                  ),
                ),
                const SizedBox(height: 12),
                Slider(
                  value: _commissionRate,
                  min: 1,
                  max: 50,
                  divisions: 49,
                  activeColor: const Color(0xFFFF4757),
                  label: '${_commissionRate.toInt()}%',
                  onChanged: (value) {
                    setState(() {
                      _commissionRate = value;
                    });
                    _notifyChanged();
                  },
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.green.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Colors.green.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.card_giftcard,
                            color: Colors.green[700],
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              '赠金说明',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[700],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '• 用户分享课程后，购买者支付课程金额\n'
                        '• 分享者获得${_commissionRate.toInt()}%的赠金奖励\n'
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
                ),
              ],
            ],
          ),
        ),

        const SizedBox(height: 16),

        // 预估收益
        _buildSectionCard(
          title: '预估收益',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '售价',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  Text(
                    '¥${_priceController.text}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '平台服务费（10%）',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  Text(
                    '¥${(double.tryParse(_priceController.text) ?? 0 * 0.1).toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const Divider(),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    '预估收益',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  Text(
                    '¥${(double.tryParse(_priceController.text) ?? 0 * 0.9).toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFF4757),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// 构建区域卡片
  Widget _buildSectionCard({required String title, required Widget child}) {
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
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }

  /// 获取表单数据
  Map<String, dynamic> getFormData() {
    return {
      'price': _priceController.text,
      'originalPrice': _originalPriceController.text,
      'hasActivity': _hasActivity,
      'activityPrice': _activityPriceController.text,
      'commissionEnabled': _commissionEnabled,
      'commissionRate': _commissionRate,
    };
  }
}
