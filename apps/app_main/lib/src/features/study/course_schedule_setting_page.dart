library;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// 课程表设置页面
///
/// 为课程设置学习计划，选择每节课的学习日期
class CourseScheduleSettingPage extends StatefulWidget {
  final String courseId;

  const CourseScheduleSettingPage({
    super.key,
    required this.courseId,
  });

  @override
  State<CourseScheduleSettingPage> createState() => _CourseScheduleSettingPageState();
}

class _CourseScheduleSettingPageState extends State<CourseScheduleSettingPage> {
  // 模拟课程数据
  final Map<String, dynamic> _courseData = {
    'id': '1',
    'title': 'Python 全栈开发实战套课',
    'imageUrl': 'https://picsum.photos/600/400?random=101',
    'chapters': [
      {
        'id': '1',
        'title': '第1章 课程介绍',
        'lessons': [
          {'id': '1.1', 'title': '1.1 Python环境搭建', 'scheduledDate': null},
          {'id': '1.2', 'title': '1.2 Python基本语法', 'scheduledDate': null},
          {'id': '1.3', 'title': '1.3 数据类型和变量', 'scheduledDate': '2026-03-25'},
          {'id': '1.4', 'title': '1.4 流程控制语句', 'scheduledDate': null},
        ],
      },
      {
        'id': '2',
        'title': '第2章 Web开发基础',
        'lessons': [
          {'id': '2.1', 'title': '2.1 HTML与CSS基础', 'scheduledDate': null},
          {'id': '2.2', 'title': '2.2 JavaScript入门', 'scheduledDate': null},
        ],
      },
    ].map((ch) => Map<String, dynamic>.from(ch)).toList(),
  };

  @override
  Widget build(BuildContext context) {
    final chapters = (_courseData['chapters'] as List<dynamic>).cast<Map<String, dynamic>>();

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          '设置学习计划',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        actions: [
          // 确认按钮
          TextButton(
            onPressed: () {
              // 保存学习计划
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('学习计划已保存')),
              );
              Navigator.pop(context);
            },
            child: const Text(
              '确认',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFFFF4757),
              ),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: chapters.length,
        itemBuilder: (context, index) {
          final chapter = chapters[index];
          return _buildChapterSection(chapter);
        },
      ),
    );
  }

  /// 构建章节区块
  Widget _buildChapterSection(Map<String, dynamic> chapter) {
    final lessons = (chapter['lessons'] as List<dynamic>).cast<Map<String, dynamic>>();

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 章节标题
          Text(
            chapter['title'] as String,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          // 课程列表
          ...lessons.map((lesson) {
            return _buildLessonItem(lesson);
          }),
        ],
      ),
    );
  }

  /// 构建课程项
  Widget _buildLessonItem(Map<String, dynamic> lesson) {
    final scheduledDate = lesson['scheduledDate'] as String?;

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          // 课程标题
          Expanded(
            child: Text(
              lesson['title'] as String,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ),
          // 日期设置
          GestureDetector(
            onTap: () async {
              // 显示日期选择器
              final DateTime? picked = await showDatePicker(
                context: context,
                initialDate: scheduledDate != null
                    ? DateTime.parse(scheduledDate!)
                    : DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(const Duration(days: 365)),
              );

              if (picked != null) {
                setState(() {
                  lesson['scheduledDate'] =
                      '${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}';
                });
              }
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: scheduledDate != null
                    ? Colors.green.withValues(alpha: 0.1)
                    : Colors.grey[100],
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: scheduledDate != null ? Colors.green : Colors.grey,
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.calendar_today,
                    size: 14,
                    color: scheduledDate != null ? Colors.green : Colors.grey[600],
                  ),
                  const SizedBox(width: 4),
                  Text(
                    scheduledDate != null
                        ? _formatDate(scheduledDate!)
                        : '设置日期',
                    style: TextStyle(
                      fontSize: 12,
                      color: scheduledDate != null ? Colors.green : Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 格式化日期显示
  String _formatDate(String dateStr) {
    final parts = dateStr.split('-');
    final date = DateTime(
      int.parse(parts[0]),
      int.parse(parts[1]),
      int.parse(parts[2]),
    );
    return '${date.month}月${date.day}日';
  }
}
