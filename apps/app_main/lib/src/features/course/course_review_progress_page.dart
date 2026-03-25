library;

import 'package:flutter/material.dart';

/// 课程审核进度页面
///
/// 显示课程在审核流程中的当前状态和进度
class CourseReviewProgressPage extends StatefulWidget {
  final String courseId;

  const CourseReviewProgressPage({
    super.key,
    required this.courseId,
  });

  @override
  State<CourseReviewProgressPage> createState() => _CourseReviewProgressPageState();
}

class _CourseReviewProgressPageState extends State<CourseReviewProgressPage> {
  // 模拟课程数据
  Map<String, dynamic> _courseData = {};

  // 审核流程步骤
  final List<Map<String, dynamic>> _reviewSteps = [
    {
      'id': '1',
      'title': '提交申请',
      'description': '讲师已提交课架租赁申请',
      'status': 'completed', // pending/in_progress/completed/rejected
      'timestamp': '2026-03-20 09:30',
    },
    {
      'id': '2',
      'title': '讲师资质审核',
      'description': '审核讲师身份和教学资质',
      'status': 'completed',
      'timestamp': '2026-03-20 14:20',
    },
    {
      'id': '3',
      'title': '课架内容审核',
      'description': '检查课架内容是否符合平台规范',
      'status': 'in_progress',
      'timestamp': '2026-03-21 10:00',
      'estimatedTime': '预计1-2个工作日',
    },
    {
      'id': '4',
      'title': '课架租赁签约',
      'description': '审核通过后，完成租赁签约和支付',
      'status': 'pending',
      'timestamp': null,
    },
    {
      'id': '5',
      'title': '开通完成',
      'description': '课架租赁成功，开始使用',
      'status': 'pending',
      'timestamp': null,
    },
  ];

  @override
  void initState() {
    super.initState();
    _loadCourseData();
  }

  void _loadCourseData() {
    // TODO: 从API加载课程数据
    // 这里使用模拟数据
    setState(() {
      _courseData = {
        'id': widget.courseId,
        'title': 'Flutter 移动应用开发',
        'subtitle': 'iOS & Android 双端开发',
        'coverImage': 'https://picsum.photos/400/300?random=402',
        'category': '移动开发',
        'submitTime': '2026-03-20 09:30',
        'estimatedCompleteTime': '2026-03-23',
      };
    });
  }

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
          '审核进度',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // 课程基本信息卡片
          _buildCourseInfoCard(),

          const SizedBox(height: 20),

          // 审核进度标题
          const Text(
            '审核流程',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),

          const SizedBox(height: 16),

          // 审核步骤列表
          _buildReviewSteps(),

          const SizedBox(height: 20),

          // 预计完成时间
          _buildEstimatedTimeCard(),

          const SizedBox(height: 20),

          // 注意事项
          _buildNoticeCard(),
        ],
      ),
    );
  }

  /// 构建课程信息卡片
  Widget _buildCourseInfoCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // 课程封面
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              _courseData['coverImage'] ?? 'https://picsum.photos/400/300?random=402',
              width: 100,
              height: 75,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          // 课程信息
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _courseData['title'] ?? '课程标题',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  _courseData['subtitle'] ?? '副标题',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[600],
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.orange.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                          color: Colors.orange.withValues(alpha: 0.3),
                        ),
                      ),
                      child: Text(
                        _courseData['category'] ?? '分类',
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.orange,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 构建审核步骤列表
  Widget _buildReviewSteps() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: List.generate(_reviewSteps.length, (index) {
          final step = _reviewSteps[index];
          final isLast = index == _reviewSteps.length - 1;

          return Column(
            children: [
              _buildStepItem(step, index),
              if (!isLast) _buildStepLine(step, _reviewSteps[index + 1]),
            ],
          );
        }),
      ),
    );
  }

  /// 构建单个步骤项
  Widget _buildStepItem(Map<String, dynamic> step, int index) {
    final status = step['status'] as String;
    final timestamp = step['timestamp'] as String?;
    final estimatedTime = step['estimatedTime'] as String?;

    Color statusColor;
    IconData statusIcon;
    String statusText;

    switch (status) {
      case 'completed':
        statusColor = Colors.green;
        statusIcon = Icons.check_circle;
        statusText = '已完成';
        break;
      case 'in_progress':
        statusColor = Colors.blue;
        statusIcon = Icons.pending;
        statusText = '审核中';
        break;
      case 'rejected':
        statusColor = Colors.red;
        statusIcon = Icons.cancel;
        statusText = '已拒绝';
        break;
      default:
        statusColor = Colors.grey;
        statusIcon = Icons.radio_button_unchecked;
        statusText = '待审核';
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 左侧序号和图标
        Column(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: statusColor.withValues(alpha: 0.1),
                shape: BoxShape.circle,
                border: Border.all(
                  color: statusColor,
                  width: 2,
                ),
              ),
              child: Center(
                child: status == 'completed'
                    ? Icon(
                        statusIcon,
                        size: 18,
                        color: statusColor,
                      )
                    : Text(
                        '${index + 1}',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: statusColor,
                        ),
                      ),
              ),
            ),
          ],
        ),
        const SizedBox(width: 12),
        // 右侧内容
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    step['title'] as String,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: status == 'in_progress' ? Colors.blue[700] : Colors.black87,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: statusColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      statusText,
                      style: TextStyle(
                        fontSize: 11,
                        color: statusColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                step['description'] as String,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey[600],
                ),
              ),
              if (timestamp != null) ...[
                const SizedBox(height: 4),
                Text(
                  '完成时间：$timestamp',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[500],
                  ),
                ),
              ],
              if (estimatedTime != null) ...[
                const SizedBox(height: 4),
                Text(
                  estimatedTime,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.blue[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  /// 构建步骤之间的连接线
  Widget _buildStepLine(Map<String, dynamic> currentStep, Map<String, dynamic> nextStep) {
    final currentStatus = currentStep['status'] as String;
    final nextStatus = nextStep['status'] as String;

    Color lineColor;
    if (currentStatus == 'completed' && (nextStatus == 'in_progress' || nextStatus == 'completed')) {
      lineColor = Colors.green;
    } else if (currentStatus == 'rejected' || nextStatus == 'rejected') {
      lineColor = Colors.grey;
    } else {
      lineColor = Colors.grey.withValues(alpha: 0.3);
    }

    return Padding(
      padding: const EdgeInsets.only(left: 15),
      child: Container(
        height: 30,
        width: 2,
        decoration: BoxDecoration(
          color: lineColor,
        ),
      ),
    );
  }

  /// 构建预计完成时间卡片
  Widget _buildEstimatedTimeCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.blue.withValues(alpha: 0.2),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.access_time,
            color: Colors.blue[700],
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '预计审核完成时间',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _courseData['estimatedCompleteTime'] ?? '2026-03-23',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[700],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 构建注意事项卡片
  Widget _buildNoticeCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.orange.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.orange.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.info_outline,
                color: Colors.orange[700],
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                '温馨提示',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange[700],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildNoticeItem('• 课架审核通常需要1-3个工作日'),
          const SizedBox(height: 8),
          _buildNoticeItem('• 请保持手机畅通，如有问题我们会及时联系您'),
          const SizedBox(height: 8),
          _buildNoticeItem('• 审核通过后，请完成租赁签约和支付'),
          const SizedBox(height: 8),
          _buildNoticeItem('• 如审核未通过，请根据反馈修改后重新提交'),
        ],
      ),
    );
  }

  Widget _buildNoticeItem(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 13,
        color: Colors.grey[700],
        height: 1.5,
      ),
    );
  }
}
