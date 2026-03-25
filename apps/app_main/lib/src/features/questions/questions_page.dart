library;

import 'package:flutter/material.dart';

/// 我的问答页面
///
/// 多级折叠结构：课程 -> 章节 -> 问题
/// 可展开和收起
class QuestionsPage extends StatefulWidget {
  const QuestionsPage({super.key});

  @override
  State<QuestionsPage> createState() => _QuestionsPageState();
}

class _QuestionsPageState extends State<QuestionsPage> {
  // 跟踪每个课程的展开/收起状态
  final Map<String, bool> _expandedCourses = {};
  // 跟踪每个章节的展开/收起状态
  final Map<String, bool> _expandedChapters = {};

  // 模拟数据 - 按课程分组的问题
  final List<Map<String, dynamic>> _courseQuestions = [
    {
      'courseId': '1',
      'courseTitle': 'Python 全栈开发实战套课',
      'courseImage': 'https://picsum.photos/100/75?random=301',
      'chapters': [
        {
          'chapterId': '1.1',
          'chapterTitle': '第1章 课程介绍',
          'questions': [
            {
              'id': '1',
              'lessonId': '1.1',
              'lessonTitle': '1.1 Python环境搭建',
              'question': 'Windows 11安装Python 3.12一直失败怎么办？',
              'answer': '建议您先检查系统版本，如果是ARM架构的Mac，需要下载对应版本的Python。如果是Windows问题，可以尝试以管理员身份运行安装程序。',
              'time': '10分钟前',
              'likes': 5,
              'myRating': 5,
            },
            {
              'id': '2',
              'lessonId': '1.2',
              'lessonTitle': '1.2 Python基本语法',
              'question': 'VS Code和PyCharm应该选哪个？',
              'answer': '老师建议初学者使用VS Code，因为它更轻量级，插件丰富。等熟练后再考虑PyCharm。',
              'time': '2小时前',
              'likes': 18,
              'myRating': 4,
            },
          ],
        },
        {
          'chapterId': '1.2',
          'chapterTitle': '第2章 Web开发基础',
          'questions': [
            {
              'id': '3',
              'lessonId': '2.1',
              'lessonTitle': '2.1 HTML与CSS基础',
              'question': 'HTML和CSS必须学吗？可以直接学Python框架吗？',
              'answer': '',
              'time': '1天前',
              'likes': 8,
              'myRating': null,
            },
          ],
        },
      ],
    },
    {
      'courseId': '2',
      'courseTitle': 'Vue3 前端开发实战',
      'courseImage': 'https://picsum.photos/100/75?random=303',
      'chapters': [
        {
          'chapterId': '2.1',
          'chapterTitle': '第1章 Vue3基础',
          'questions': [
            {
              'id': '4',
              'lessonId': '1.1',
              'lessonTitle': '1.1 Vue3简介',
              'question': 'Vue2和Vue3区别大吗？需要先学Vue2吗？',
              'answer': 'Vue3使用了Composition API，与Vue2的Options API有很大不同。如果零基础学习，建议直接从Vue3开始。',
              'time': '3天前',
              'likes': 32,
              'myRating': 5,
            },
          ],
        },
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 20),
          color: Colors.black87,
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          '我的问答',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _courseQuestions.length,
        itemBuilder: (context, index) {
          final course = _courseQuestions[index];
          return _buildCourseCard(course);
        },
      ),
    );
  }

  /// 构建课程卡片（可折叠）
  Widget _buildCourseCard(Map<String, dynamic> course) {
    final courseId = course['courseId'] as String;
    final isExpanded = _expandedCourses[courseId] ?? false;
    final chapters = course['chapters'] as List<Map<String, dynamic>>;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
      ),
      child: Column(
        children: [
          // 课程标题（可点击展开/收起）
          GestureDetector(
            onTap: () {
              setState(() {
                _expandedCourses[courseId] = !isExpanded;
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      course['courseImage'] as String,
                      width: 60,
                      height: 45,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      course['courseTitle'] as String,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  // 折叠/展开图标
                  Icon(
                    isExpanded ? Icons.expand_less : Icons.expand_more,
                    color: Colors.grey[600],
                  ),
                ],
              ),
            ),
          ),
          // 章节列表（可折叠）
          if (isExpanded)
            ...chapters.map((chapter) {
              return _buildChapterSection(courseId, chapter);
            }),
        ],
      ),
    );
  }

  /// 构建章节区块（可折叠）
  Widget _buildChapterSection(String courseId, Map<String, dynamic> chapter) {
    final chapterId = '$courseId-${chapter['chapterId']}';
    final isExpanded = _expandedChapters[chapterId] ?? false;
    final questions = chapter['questions'] as List<Map<String, dynamic>>;

    return Column(
      children: [
        const Divider(height: 1),
        // 章节标题（可点击展开/收起）
        GestureDetector(
          onTap: () {
            setState(() {
              _expandedChapters[chapterId] = !isExpanded;
            });
          },
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
            child: Row(
              children: [
                Icon(
                  Icons.folder,
                  size: 16,
                  color: Colors.grey[600],
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    chapter['chapterTitle'] as String,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[700],
                    ),
                  ),
                ),
                Text(
                  '${questions.length}问',
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey[500],
                  ),
                ),
                const SizedBox(width: 8),
                // 折叠/展开图标
                Icon(
                  isExpanded ? Icons.expand_less : Icons.expand_more,
                  size: 20,
                  color: Colors.grey[600],
                ),
              ],
            ),
          ),
        ),
        // 问题列表（可折叠）
        if (isExpanded)
          Column(
            children: [
              const Divider(height: 1),
              ...questions.map((question) {
                return _buildQuestionItem(question);
              }),
              const SizedBox(height: 12),
            ],
          ),
      ],
    );
  }

  /// 构建问题项
  Widget _buildQuestionItem(Map<String, dynamic> question) {
    final hasAnswer = (question['answer'] as String).isNotEmpty;
    final myRating = question['myRating'] as int?;

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 课程标题和提问时间
          Row(
            children: [
              Expanded(
                child: Text(
                  question['lessonTitle'] as String,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ),
              Text(
                question['time'] as String,
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey[500],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // 我的问题
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.orange.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'Q: ${question['question'] as String}',
              style: TextStyle(
                fontSize: 13,
                color: Colors.orange[700],
                height: 1.4,
              ),
            ),
          ),
          if (hasAnswer) ...[
            const SizedBox(height: 8),
            // 老师回答
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'A: ${question['answer'] as String}',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[700],
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // 我的打分
                  if (myRating != null)
                    Row(
                      children: [
                        Text(
                          '我的评分：',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(width: 4),
                        ...List.generate(5, (starIndex) {
                          return Icon(
                            starIndex < myRating ? Icons.star : Icons.star_border,
                            size: 14,
                            color: Colors.orange[400],
                          );
                        }),
                      ],
                    ),
                ],
              ),
            ),
          ] else ...[
            const SizedBox(height: 8),
            Text(
              '等待老师回答...',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[500],
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

