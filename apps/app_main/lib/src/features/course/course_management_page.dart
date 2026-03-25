library;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// 课程管理页面
///
/// 讲师可以在这里申请上架课程
class CourseManagementPage extends StatefulWidget {
  const CourseManagementPage({super.key});

  @override
  State<CourseManagementPage> createState() => _CourseManagementPageState();
}

class _CourseManagementPageState extends State<CourseManagementPage> {
  // 模拟数据 - 已申请的课程
  final List<Map<String, dynamic>> _appliedCourses = [
    {
      'id': '1',
      'title': 'Python 全栈开发实战套课',
      'subtitle': '从零基础到项目实战',
      'coverImage': 'https://picsum.photos/400/300?random=401',
      'status': 'approved', // pending/approved/rejected
      'statusText': '已上架',
      'studentCount': 1250,
      'salesCount': 1250,
      'revenue': 237500.00,
      'forwardCount': 342,
      'price': 19900,
      'originalPrice': 29900,
      'hasActivity': true,
      'activityPrice': 14900,
      'commissionEnabled': true,
      'commissionRate': 10,
      'category': '后端开发',
      'lessons': 45,
      'duration': '36小时',
      'applyDate': '2026-03-01',
      // 租赁信息 - 年费
      'leasingType': 'yearly', // yearly/quarterly/monthly/usage
      'leasingTypeText': '年费',
      'remainingDays': 245,
      'expiryDate': '2026-12-31',
    },
    {
      'id': '2',
      'title': 'Flutter 移动应用开发',
      'subtitle': 'iOS & Android 双端开发',
      'coverImage': 'https://picsum.photos/400/300?random=402',
      'status': 'pending',
      'statusText': '审核中',
      'studentCount': 0,
      'salesCount': 0,
      'revenue': 0.0,
      'forwardCount': 0,
      'price': 15900,
      'originalPrice': 22900,
      'hasActivity': false,
      'activityPrice': 0,
      'commissionEnabled': false,
      'commissionRate': 0,
      'category': '移动开发',
      'lessons': 38,
      'duration': '28小时',
      'applyDate': '2026-03-20',
      // 租赁信息 - 流量
      'leasingType': 'usage',
      'leasingTypeText': '流量',
      'remainingHours': 500,
      'remainingMinutes': 30,
    },
    {
      'id': '3',
      'title': 'Vue3 前端开发实战',
      'subtitle': '现代前端框架完全指南',
      'coverImage': 'https://picsum.photos/400/300?random=403',
      'status': 'rejected',
      'statusText': '已拒绝',
      'rejectReason': '课程内容不够详细，请补充更多实战案例',
      'studentCount': 0,
      'salesCount': 0,
      'revenue': 0.0,
      'forwardCount': 0,
      'price': 12900,
      'originalPrice': 18900,
      'hasActivity': false,
      'activityPrice': 0,
      'commissionEnabled': false,
      'commissionRate': 0,
      'category': '前端开发',
      'lessons': 32,
      'duration': '24小时',
      'applyDate': '2026-03-10',
      // 租赁信息 - 月费
      'leasingType': 'monthly',
      'leasingTypeText': '月费',
      'remainingDays': 15,
      'expiryDate': '2026-04-09',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          '课架管理',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        actions: [
          // 申请租赁按钮
          TextButton.icon(
            onPressed: () {
              // 跳转到租赁签约页面
              _showLeasingOptions(context);
            },
            icon: const Icon(
              Icons.add_circle_outline,
              color: Color(0xFFFF4757),
            ),
            label: const Text(
              '申请租赁',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Color(0xFFFF4757),
              ),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _appliedCourses.length,
        itemBuilder: (context, index) {
          final course = _appliedCourses[index];
          return _buildCourseCard(course);
        },
      ),
    );
  }

  /// 构建课程卡片
  Widget _buildCourseCard(Map<String, dynamic> course) {
    final status = course['status'] as String;
    final statusText = course['statusText'] as String;
    final price = course['price'] as int;
    final originalPrice = course['originalPrice'] as int? ?? 0;

    return GestureDetector(
      onTap: () {
        // 根据状态跳转到不同页面
        if (status == 'pending') {
          // 审核中 -> 跳转到审核进度页面
          context.push('/course-review-progress/${course['id']}');
        } else {
          // 已上架或已拒绝 -> 跳转到课程详情管理页面
          context.push('/course-detail-management/${course['id']}');
        }
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.grey.withValues(alpha: 0.2),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          // 课程封面和状态标签
          Stack(
            children: [
              // 封面图
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
                child: Image.network(
                  course['coverImage'] as String,
                  width: double.infinity,
                  height: 160,
                  fit: BoxFit.cover,
                ),
              ),
              // 状态标签
              Positioned(
                top: 12,
                right: 12,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _buildStatusChip(status, statusText),
                    if (course.containsKey('leasingType'))
                      _buildLeasingInfoChip(course),
                  ],
                ),
              ),
              // 分类标签
              Positioned(
                top: 12,
                left: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.6),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    course['category'] as String,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),

          // 课程信息
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 课程标题
                Text(
                  course['title'] as String,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                // 副标题
                Text(
                  course['subtitle'] as String,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[600],
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 12),

                // 课程数据
                Row(
                  children: [
                    Icon(
                      Icons.play_circle_outline,
                      size: 16,
                      color: Colors.grey[600],
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${course['lessons']}节课',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Icon(
                      Icons.access_time,
                      size: 16,
                      color: Colors.grey[600],
                    ),
                    const SizedBox(width: 4),
                    Text(
                      course['duration'] as String,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                    if (status == 'approved') ...[
                      const SizedBox(width: 16),
                      Icon(
                        Icons.people_outline,
                        size: 16,
                        color: Colors.grey[600],
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${course['studentCount']}人学习',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ],
                ),

                const SizedBox(height: 12),

                // 零售价信息（讲师参考）
                Row(
                  children: [
                    Text(
                      '零售价：¥${(price / 100).toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[600],
                      ),
                    ),
                    if (originalPrice > price) ...[
                      const SizedBox(width: 8),
                      Text(
                        '原价¥${(originalPrice / 100).toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ],
                ),

                const SizedBox(height: 12),

                // 运营信息（仅已上架课程显示）
                if (status == 'approved')
                  Wrap(
                    spacing: 12,
                    runSpacing: 8,
                    children: [
                      _buildStatItem(
                        icon: Icons.shopping_cart,
                        label: '销量',
                        value: '${course['salesCount']}',
                      ),
                      _buildStatItem(
                        icon: Icons.monetization_on,
                        label: '收入',
                        value: '¥${((course['revenue'] as double) / 100).toStringAsFixed(0)}',
                      ),
                      _buildStatItem(
                        icon: Icons.share,
                        label: '转发',
                        value: '${course['forwardCount']}',
                      ),
                    ],
                  ),

                // 如果是拒绝状态，显示拒绝原因和重新申请按钮
                if (status == 'rejected') ...[
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.red.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Colors.red.withValues(alpha: 0.2),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.info_outline,
                              size: 14,
                              color: Colors.red[700],
                            ),
                            const SizedBox(width: 6),
                            Text(
                              '拒绝原因',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.red[700],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          course['rejectReason'] as String,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[700],
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 12),
                        // 重新提交审核按钮
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              // 跳转到重新申请页面，带上课程ID
                              context.push('/course-application?courseId=${course['id']}&mode=resubmit');
                            },
                            icon: const Icon(Icons.refresh, size: 16),
                            label: const Text('重新提交审核'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFFF4757),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              textStyle: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],

                // 申请时间
                const SizedBox(height: 8),
                Text(
                  '申请时间：${course['applyDate']}',
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
    );  // Close GestureDetector
  }

  /// 构建状态标签
  Widget _buildStatusChip(String status, String text) {
    Color backgroundColor;
    Color textColor;
    IconData? icon;

    switch (status) {
      case 'approved':
        backgroundColor = Colors.green.withValues(alpha: 0.1);
        textColor = Colors.green;
        icon = Icons.check_circle;
        break;
      case 'pending':
        backgroundColor = Colors.orange.withValues(alpha: 0.1);
        textColor = Colors.orange;
        icon = Icons.pending;
        break;
      case 'rejected':
        backgroundColor = Colors.red.withValues(alpha: 0.1);
        textColor = Colors.red;
        icon = Icons.cancel;
        break;
      default:
        backgroundColor = Colors.grey.withValues(alpha: 0.1);
        textColor = Colors.grey;
        icon = Icons.help_outline;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: textColor,
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              size: 14,
              color: textColor,
            ),
            const SizedBox(width: 4),
          ],
          Text(
            text,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }

  /// 构建租赁信息标签
  Widget _buildLeasingInfoChip(Map<String, dynamic> course) {
    final leasingType = course['leasingType'] as String;
    final leasingTypeText = course['leasingTypeText'] as String;

    String infoText;

    if (leasingType == 'usage') {
      // 流量模式
      final remainingHours = course['remainingHours'] as int;
      final remainingMinutes = course['remainingMinutes'] as int;
      infoText = '$leasingTypeText 剩余${remainingHours}小时${remainingMinutes}分';
    } else {
      // 周期性付费模式
      final remainingDays = course['remainingDays'] as int;
      final expiryDate = course['expiryDate'] as String;
      infoText = '$leasingTypeText 剩余${remainingDays}天 $expiryDate到期';
    }

    return Container(
      margin: const EdgeInsets.only(top: 4),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        infoText,
        style: const TextStyle(
          fontSize: 10,
          color: Colors.black87,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  /// 构建操作按钮
  Widget _buildActionButton({
    required String text,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: color,
            width: 1,
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
      ),
    );
  }

  /// 构建运营统计项
  Widget _buildStatItem({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.blue.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: Colors.blue.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 14,
            color: Colors.blue[700],
          ),
          const SizedBox(width: 4),
          Text(
            '$label: ',
            style: TextStyle(
              fontSize: 11,
              color: Colors.grey[600],
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: Colors.blue[700],
            ),
          ),
        ],
      ),
    );
  }

  /// 显示租赁选项弹窗
  void _showLeasingOptions(BuildContext context) {
    String? _selectedPlan;
    String? _selectedPackage;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => Container(
          height: MediaQuery.of(context).size.height * 0.85,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              // 标题栏
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey.withValues(alpha: 0.2),
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    const Text(
                      '课架租赁签约',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),

              // 内容区域
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    // 费用说明
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.orange.withValues(alpha: 0.05),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Colors.orange.withValues(alpha: 0.2),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.info_outline,
                            color: Colors.orange[700],
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          const Expanded(
                            child: Text(
                              '租赁课架需要支付相应费用，请选择合适的付费方案',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // 周期性付费
                    const Text(
                      '周期性付费',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // 年费
                    _buildPlanOption(
                      title: '年费套餐',
                      description: '适合长期使用，性价比最高',
                      price: '¥2,988/年',
                      originalPrice: '¥3,600',
                      tag: '省17%',
                      icon: Icons.workspace_premium,
                      iconColor: Colors.amber,
                      isSelected: _selectedPlan == 'yearly',
                      onTap: () {
                        setModalState(() {
                          _selectedPlan = 'yearly';
                          _selectedPackage = null;
                        });
                      },
                    ),

                    const SizedBox(height: 12),

                    // 季度费
                    _buildPlanOption(
                      title: '季度套餐',
                      description: '按季度付费，灵活方便',
                      price: '¥888/季度',
                      originalPrice: '¥960',
                      tag: '省8%',
                      icon: Icons.calendar_today,
                      iconColor: Colors.blue,
                      isSelected: _selectedPlan == 'quarterly',
                      onTap: () {
                        setModalState(() {
                          _selectedPlan = 'quarterly';
                          _selectedPackage = null;
                        });
                      },
                    ),

                    const SizedBox(height: 12),

                    // 月费
                    _buildPlanOption(
                      title: '月度套餐',
                      description: '按月付费，轻松上手',
                      price: '¥328/月',
                      originalPrice: null,
                      tag: null,
                      icon: Icons.date_range,
                      iconColor: Colors.green,
                      isSelected: _selectedPlan == 'monthly',
                      onTap: () {
                        setModalState(() {
                          _selectedPlan = 'monthly';
                          _selectedPackage = null;
                        });
                      },
                    ),

                    const SizedBox(height: 24),

                    // 按量付费
                    const Text(
                      '播放时长按量付费',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // 时长套餐1
                    _buildPackageOption(
                      title: '基础套餐',
                      description: '100小时播放时长',
                      price: '¥199',
                      icon: Icons.play_circle_outline,
                      iconColor: Colors.purple,
                      isSelected: _selectedPackage == 'basic',
                      onTap: () {
                        setModalState(() {
                          _selectedPackage = 'basic';
                          _selectedPlan = null;
                        });
                      },
                    ),

                    const SizedBox(height: 12),

                    // 时长套餐2
                    _buildPackageOption(
                      title: '标准套餐',
                      description: '500小时播放时长',
                      price: '¥699',
                      tag: '推荐',
                      icon: Icons.play_circle_outline,
                      iconColor: Colors.purple,
                      isSelected: _selectedPackage == 'standard',
                      onTap: () {
                        setModalState(() {
                          _selectedPackage = 'standard';
                          _selectedPlan = null;
                        });
                      },
                    ),

                    const SizedBox(height: 12),

                    // 时长套餐3
                    _buildPackageOption(
                      title: '高级套餐',
                      description: '2000小时播放时长',
                      price: '¥1,999',
                      tag: '超值',
                      icon: Icons.play_circle_outline,
                      iconColor: Colors.purple,
                      isSelected: _selectedPackage == 'premium',
                      onTap: () {
                        setModalState(() {
                          _selectedPackage = 'premium';
                          _selectedPlan = null;
                        });
                      },
                    ),

                    const SizedBox(height: 24),

                    // 说明文字
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey.withValues(alpha: 0.05),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '费用说明',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[700],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '• 费用由平台管理员设置，具体以实际支付为准',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                              height: 1.5,
                            ),
                          ),
                          Text(
                            '• 周期性付费套餐到期后需要续费',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                              height: 1.5,
                            ),
                          ),
                          Text(
                            '• 按量付费套餐购买后永久有效',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // 底部按钮
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    top: BorderSide(
                      color: Colors.grey.withValues(alpha: 0.2),
                    ),
                  ),
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _selectedPlan != null || _selectedPackage != null
                        ? () {
                            Navigator.pop(context);
                            // 显示支付二维码
                            _showPaymentQRCode(context, _selectedPlan ?? _selectedPackage!);
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF4757),
                      foregroundColor: Colors.white,
                      disabledBackgroundColor: Colors.grey.withValues(alpha: 0.3),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      '确定签约',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 构建周期性付费选项
  Widget _buildPlanOption({
    required String title,
    required String description,
    required String price,
    String? originalPrice,
    String? tag,
    required IconData icon,
    required Color iconColor,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xFFFF4757).withValues(alpha: 0.05) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? const Color(0xFFFF4757) : Colors.grey.withValues(alpha: 0.2),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            // 图标
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: iconColor,
                size: 28,
              ),
            ),
            const SizedBox(width: 12),

            // 内容
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      if (tag != null) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.red.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            tag,
                            style: const TextStyle(
                              fontSize: 11,
                              color: Colors.red,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),

            // 价格
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  price,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFF4757),
                  ),
                ),
                if (originalPrice != null)
                  Text(
                    originalPrice,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[500],
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
              ],
            ),

            const SizedBox(width: 8),

            // 选中图标
            if (isSelected)
              const Icon(
                Icons.check_circle,
                color: Color(0xFFFF4757),
                size: 24,
              ),
          ],
        ),
      ),
    );
  }

  /// 构建时长套餐选项
  Widget _buildPackageOption({
    required String title,
    required String description,
    required String price,
    String? tag,
    required IconData icon,
    required Color iconColor,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? Colors.purple.withValues(alpha: 0.05) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Colors.purple : Colors.grey.withValues(alpha: 0.2),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            // 图标
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: iconColor,
                size: 28,
              ),
            ),
            const SizedBox(width: 12),

            // 内容
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      if (tag != null) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.purple.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            tag,
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.purple,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),

            // 价格
            Text(
              price,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.purple,
              ),
            ),

            const SizedBox(width: 8),

            // 选中图标
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: Colors.purple,
                size: 24,
              ),
          ],
        ),
      ),
    );
  }

  /// 显示支付二维码
  void _showPaymentQRCode(BuildContext context, String selectedOption) {
    String planName = '';
    String price = '';

    switch (selectedOption) {
      case 'yearly':
        planName = '年费套餐';
        price = '¥2,988';
        break;
      case 'quarterly':
        planName = '季度套餐';
        price = '¥888';
        break;
      case 'monthly':
        planName = '月度套餐';
        price = '¥328';
        break;
      case 'basic':
        planName = '基础套餐（100小时）';
        price = '¥199';
        break;
      case 'standard':
        planName = '标准套餐（500小时）';
        price = '¥699';
        break;
      case 'premium':
        planName = '高级套餐（2000小时）';
        price = '¥1,999';
        break;
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 标题
            Row(
              children: [
                const Text(
                  '扫码支付',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // 订单信息
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '租赁方案',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[600],
                        ),
                      ),
                      Text(
                        planName,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '应付金额',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[600],
                        ),
                      ),
                      Text(
                        price,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFFF4757),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // 二维码（这里使用占位图）
            Container(
              width: 240,
              height: 240,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.grey.withValues(alpha: 0.3),
                  width: 2,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.qr_code_2,
                    size: 180,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '微信扫码支付',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // 温馨提示
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.orange.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    color: Colors.orange[700],
                    size: 16,
                  ),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Text(
                      '请在15分钟内完成支付，超时后订单将自动取消',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // 确认支付按钮
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // 关闭二维码弹窗
                  // 跳转到申请上架课程页面
                  context.push('/course-application');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF4757),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  '已完成支付',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
