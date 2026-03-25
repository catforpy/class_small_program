library;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// 学习计划/课表页面
///
/// 两个部分：
/// 1. 更新中的课程（显示更新时间表）
/// 2. 已购课程列表（可添加学习计划）
class StudySchedulePage extends StatefulWidget {
  const StudySchedulePage({super.key});

  @override
  State<StudySchedulePage> createState() => _StudySchedulePageState();
}

class _StudySchedulePageState extends State<StudySchedulePage> {
  // 模拟数据 - 更新中的课程
  final List<Map<String, dynamic>> _updatingCourses = [
    {
      'id': '1',
      'title': 'Python 全栈开发实战套课',
      'imageUrl': 'https://picsum.photos/200/150?random=301',
      'instructor': '王老师',
      'updateSchedule': [
        {'date': '2026-04-01', 'chapter': '第4章 怎么查询速度更快？', 'status': 'pending'},
        {'date': '2026-04-15', 'chapter': '第5章 如何处理数据更新？', 'status': 'pending'},
      ],
    },
  ];

  // 模拟数据 - 已购课程
  final List<Map<String, dynamic>> _purchasedCourses = [
    {
      'id': '1',
      'title': 'Python 全栈开发实战套课',
      'imageUrl': 'https://picsum.photos/200/150?random=302',
      'progress': 0.35,
      'hasSchedule': true, // 是否已设置学习计划
      'schedule': [
        {'lessonId': '1.4', 'title': '1.4 流程控制语句', 'date': '2026-03-25', 'completed': false},
        {'lessonId': '2.1', 'title': '2.1 HTML与CSS基础', 'date': '2026-03-26', 'completed': false},
        {'lessonId': '2.2', 'title': '2.2 JavaScript入门', 'date': '2026-03-27', 'completed': false},
      ],
    },
    {
      'id': '2',
      'title': 'Vue3 前端开发实战',
      'imageUrl': 'https://picsum.photos/200/150?random=303',
      'progress': 0.12,
      'hasSchedule': false,
      'schedule': [],
    },
    {
      'id': '3',
      'title': 'Java高并发实战',
      'imageUrl': 'https://picsum.photos/200/150?random=304',
      'progress': 0.0,
      'hasSchedule': false,
      'schedule': [],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // 第一部分：更新中的课程
          if (_updatingCourses.isNotEmpty) ...[
            _buildSectionTitle('更新中的课程'),
            const SizedBox(height: 12),
            ..._updatingCourses.map((course) => _buildUpdatingCourseCard(course)),
            const SizedBox(height: 24),
          ],
          // 第二部分：已购课程
          _buildSectionTitle('已购课程'),
          const SizedBox(height: 12),
          ..._purchasedCourses.map((course) => _buildPurchasedCourseCard(course)),
          const SizedBox(height: 80),
        ],
      ),
    );
  }

  /// 构建区块标题
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }

  /// 构建更新中的课程卡片
  Widget _buildUpdatingCourseCard(Map<String, dynamic> course) {
    final updateSchedule = (course['updateSchedule'] as List<dynamic>).cast<Map<String, dynamic>>();

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 课程信息
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  course['imageUrl'] as String,
                  width: 80,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      course['title'] as String,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '讲师：${course['instructor']}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(height: 1),
          const SizedBox(height: 12),
          // 更新时间表
          Text(
            '更新计划',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 8),
          ...updateSchedule.map((schedule) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  Icon(
                    Icons.event,
                    size: 16,
                    color: Colors.orange,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    schedule['date'] as String,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      schedule['chapter'] as String,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.orange.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      '待更新',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.orange,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  /// 构建已购课程卡片
  Widget _buildPurchasedCourseCard(Map<String, dynamic> course) {
    final hasSchedule = course['hasSchedule'] as bool;
    final schedule = (course['schedule'] as List<dynamic>).cast<Map<String, dynamic>>();

    // 计算今天的学习任务
    final todayTasks = _getTodayTasks(schedule);
    final todayCompleted = todayTasks.where((t) => t['completed'] as bool).length;
    final todayTotal = todayTasks.length;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 课程信息和学习计划按钮
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  course['imageUrl'] as String,
                  width: 80,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      course['title'] as String,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    // 学习进度
                    Row(
                      children: [
                        Expanded(
                          child: LinearProgressIndicator(
                            value: course['progress'] as double,
                            backgroundColor: Colors.grey[200],
                            valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${((course['progress'] as double) * 100).toInt()}%',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // 添加课程表按钮
              GestureDetector(
                onTap: () {
                  // 跳转到课程表设置页面
                  context.push('/study/schedule/${course['id']}');
                },
                child: Column(
                  children: [
                    Icon(
                      hasSchedule ? Icons.calendar_today : Icons.add_circle_outline,
                      size: 24,
                      color: hasSchedule ? Colors.green : Colors.grey[400],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      hasSchedule ? '课程表' : '添加',
                      style: TextStyle(
                        fontSize: 11,
                        color: hasSchedule ? Colors.green : Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          // 如果设置了学习计划，显示今天的学习任务
          if (hasSchedule && todayTasks.isNotEmpty) ...[
            const SizedBox(height: 12),
            _buildTodayTasksCard(todayTasks, todayCompleted, todayTotal),
          ],
        ],
      ),
    );
  }

  /// 构建今日任务卡片
  Widget _buildTodayTasksCard(List<Map<String, dynamic>> tasks, int completed, int total) {
    // 计算最近的未来学习日期
    final nextLessonDays = _getDaysToNextLesson(tasks);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: completed == total
            ? Colors.green.withValues(alpha: 0.1)
            : Colors.orange.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: completed == total ? Colors.green : Colors.orange,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                completed == total ? Icons.check_circle : Icons.notifications_active,
                size: 16,
                color: completed == total ? Colors.green : Colors.orange,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  completed == total
                      ? '学习任务完成！'
                      : nextLessonDays == 0
                          ? '今日学习任务'
                          : '还有$nextLessonDays天开始学习',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: completed == total ? Colors.green : Colors.orange[700],
                  ),
                ),
              ),
            ],
          ),
          if (nextLessonDays == 0 && completed < total) ...[
            const SizedBox(height: 8),
            ...tasks.map((task) {
              final isCompleted = task['completed'] as bool;
              return Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Row(
                  children: [
                    Icon(
                      isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
                      size: 14,
                      color: isCompleted ? Colors.green : Colors.grey,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        task['title'] as String,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[700],
                          decoration: isCompleted ? TextDecoration.lineThrough : null,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
            const SizedBox(height: 4),
            Text(
              '还有${total - completed}节课未完成',
              style: TextStyle(
                fontSize: 11,
                color: Colors.grey[600],
              ),
            ),
          ],
        ],
      ),
    );
  }

  /// 获取今日的学习任务
  List<Map<String, dynamic>> _getTodayTasks(List<dynamic> schedule) {
    final today = DateTime.now();
    final todayStr = '${today.year}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}';

    return schedule.where((lesson) {
      return lesson['date'] == todayStr;
    }).toList().cast<Map<String, dynamic>>();
  }

  /// 获取距离下一课的天数
  int _getDaysToNextLesson(List<dynamic> schedule) {
    final today = DateTime.now();
    final todayDate = DateTime(today.year, today.month, today.day);

    for (var lesson in schedule) {
      final parts = (lesson['date'] as String).split('-');
      final lessonDate = DateTime(
        int.parse(parts[0]),
        int.parse(parts[1]),
        int.parse(parts[2]),
      );

      if (lessonDate.isAfter(todayDate)) {
        return lessonDate.difference(todayDate).inDays;
      }
    }

    return 0; // 今天有课程
  }
}
