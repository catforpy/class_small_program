library;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// 课程详情管理页面
///
/// 讲师可以在这里管理已上架的课程
class CourseDetailManagementPage extends StatefulWidget {
  final String courseId;

  const CourseDetailManagementPage({
    super.key,
    required this.courseId,
  });

  @override
  State<CourseDetailManagementPage> createState() => _CourseDetailManagementPageState();
}

class _CourseDetailManagementPageState extends State<CourseDetailManagementPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // 是否已预约到期下架
  bool _isScheduledForTakeDown = false;

  // 课程基本信息
  final Map<String, dynamic> _courseInfo = {
    'id': '1',
    'title': 'Python 全栈开发实战套课',
    'status': 'approved',
    // 租赁信息
    'leasingType': 'yearly', // yearly/quarterly/monthly/usage
    'leasingTypeText': '年费',
    'remainingDays': 245,
    'expiryDate': '2026-12-31',
    'remainingHours': null,
    'remainingMinutes': null,
  };

  // 课程大纲
  final List<Map<String, dynamic>> _chapters = [
    {
      'id': '1',
      'title': '第1章 课程介绍',
      'expanded': true,
      'lessons': [
        {
          'id': '1.1',
          'title': '1.1 Python环境搭建',
          'duration': '15:30',
          'uploaded': true,
          'freePreview': true,
          'scheduledDate': null,
        },
        {
          'id': '1.2',
          'title': '1.2 Python基本语法',
          'duration': '25:45',
          'uploaded': true,
          'freePreview': false,
          'scheduledDate': null,
        },
        {
          'id': '1.3',
          'title': '1.3 数据类型和变量',
          'duration': '20:15',
          'uploaded': true,
          'freePreview': false,
          'scheduledDate': null,
        },
      ],
    },
  ];

  // 课程资料
  final List<Map<String, dynamic>> _materials = [
    {
      'id': '1',
      'title': '课程源代码',
      'description': '包含所有章节的完整源代码',
      'fileSize': '15.2 MB',
      'uploaded': true,
    },
  ];

  // 互动数据
  final int _consultationCount = 23;
  final int _qaCount = 156;
  final double _averageRating = 4.8;
  final int _reviewCount = 89;

  // 销售数据
  final int _salesCount = 1250;
  final double _totalRevenue = 237500.00;
  final int _forwardCount = 342;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
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
        title: Text(
          _courseInfo['title'] as String,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        actions: [
          // 上架状态
          Container(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.green.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: Colors.green),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.check_circle, size: 14, color: Colors.green),
                SizedBox(width: 4),
                Text(
                  '已上架',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // 租赁信息区域
          _buildLeasingInfoSection(),

          // 标签栏
          Container(
            color: Colors.white,
            child: TabBar(
              controller: _tabController,
              isScrollable: true,
              labelColor: const Color(0xFFFF4757),
              unselectedLabelColor: Colors.grey[600],
              labelStyle: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
              unselectedLabelStyle: const TextStyle(
                fontSize: 14,
              ),
              indicatorColor: const Color(0xFFFF4757),
              tabs: const [
                Tab(text: '课程大纲'),
                Tab(text: '课程资料'),
                Tab(text: '互动管理'),
                Tab(text: '数据统计'),
              ],
            ),
          ),
          // 标签内容
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildCourseOutlineTab(),
                _buildCourseMaterialsTab(),
                _buildInteractionTab(),
                _buildDataStatsTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// ==================== 课程大纲标签页 ====================
  Widget _buildCourseOutlineTab() {
    return Column(
      children: [
        // 操作按钮
        Container(
          padding: const EdgeInsets.all(16),
          color: Colors.white,
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('批量上传功能开发中...')),
                    );
                  },
                  icon: const Icon(Icons.upload_file),
                  label: const Text('批量上传'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: _addChapter,
                  icon: const Icon(Icons.add),
                  label: const Text('添加章节'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF4757),
                    foregroundColor: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),

        // 大纲列表
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: _chapters.length,
            itemBuilder: (context, index) {
              final chapter = _chapters[index];
              return _buildChapterCard(chapter, index);
            },
          ),
        ),
      ],
    );
  }

  /// 构建章节卡片
  Widget _buildChapterCard(Map<String, dynamic> chapter, int chapterIndex) {
    final expanded = chapter['expanded'] as bool;
    final lessons = (chapter['lessons'] as List<dynamic>).cast<Map<String, dynamic>>();

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        children: [
          // 章节标题
          ListTile(
            title: Text(
              chapter['title'] as String,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text('${lessons.length}节课'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit, size: 20, color: Colors.blue),
                  onPressed: () => _editChapterTitle(chapterIndex),
                  tooltip: '编辑章节名称',
                ),
                IconButton(
                  icon: const Icon(Icons.add_circle_outline, size: 20, color: Colors.green),
                  onPressed: () => _addLesson(chapterIndex),
                  tooltip: '添加课程',
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline, size: 20, color: Colors.red),
                  onPressed: () => _deleteChapter(chapterIndex),
                  tooltip: '删除章节',
                ),
                IconButton(
                  icon: Icon(expanded ? Icons.expand_less : Icons.expand_more, size: 20),
                  onPressed: () {
                    setState(() {
                      chapter['expanded'] = !expanded;
                    });
                  },
                ),
              ],
            ),
          ),

          // 课程列表
          if (expanded)
            ...lessons.asMap().entries.map((entry) {
              final lessonIndex = entry.key;
              final lesson = entry.value;
              return _buildLessonItem(lesson, chapterIndex, lessonIndex);
            }),
        ],
      ),
    );
  }

  /// 构建课程项
  Widget _buildLessonItem(Map<String, dynamic> lesson, int chapterIndex, int lessonIndex) {
    final uploaded = lesson['uploaded'] as bool;
    final freePreview = lesson['freePreview'] as bool;

    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[50],
        border: Border(
          top: BorderSide(color: Colors.grey.withValues(alpha: 0.2)),
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Icon(
          Icons.play_circle_outline,
          size: 32,
          color: uploaded ? Colors.green : Colors.grey,
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                lesson['title'] as String,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                ),
              ),
            ),
            if (freePreview)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: Colors.green),
                ),
                child: const Text(
                  '可试看',
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.green,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
          ],
        ),
        subtitle: Text(
          '时长：${lesson['duration']}',
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit, size: 18, color: Colors.blue),
              onPressed: () => _editLessonTitle(chapterIndex, lessonIndex),
              tooltip: '编辑课程',
            ),
            IconButton(
              icon: Icon(
                freePreview ? Icons.visibility : Icons.visibility_off,
                size: 18,
                color: freePreview ? Colors.green : Colors.grey,
              ),
              onPressed: () => _toggleFreePreview(chapterIndex, lessonIndex),
              tooltip: freePreview ? '关闭试看' : '开启试看',
            ),
            IconButton(
              icon: const Icon(Icons.upload, size: 20, color: Colors.orange),
              onPressed: () => _reuploadLesson(chapterIndex, lessonIndex),
              tooltip: '重新上传',
            ),
            IconButton(
              icon: const Icon(Icons.delete_outline, size: 18, color: Colors.red),
              onPressed: () => _deleteLesson(chapterIndex, lessonIndex),
              tooltip: '删除课程',
            ),
          ],
        ),
      ),
    );
  }

  /// ==================== 课程资料标签页 ====================
  Widget _buildCourseMaterialsTab() {
    return Column(
      children: [
        // 上传资料按钮
        Container(
          padding: const EdgeInsets.all(16),
          color: Colors.white,
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('上传资料功能开发中...')),
                );
              },
              icon: const Icon(Icons.upload_file),
              label: const Text('上传课程资料'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF4757),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
        ),

        // 资料列表
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: _materials.length,
            itemBuilder: (context, index) {
              final material = _materials[index];
              return _buildMaterialCard(material, index);
            },
          ),
        ),
      ],
    );
  }

  /// 构建资料卡片
  Widget _buildMaterialCard(Map<String, dynamic> material, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey.withValues(alpha: 0.2),
        ),
      ),
      child: Row(
        children: [
          // 文件图标
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blue.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.description,
              size: 28,
              color: Colors.blue,
            ),
          ),
          const SizedBox(width: 12),
          // 文件信息
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  material['title'] as String,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  material['description'] as String,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  material['fileSize'] as String,
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
          // 操作按钮
          IconButton(
            icon: const Icon(Icons.delete_outline, size: 20, color: Colors.red),
            onPressed: () {
              setState(() {
                _materials.removeAt(index);
              });
            },
            tooltip: '删除',
          ),
        ],
      ),
    );
  }

  /// ==================== 互动管理标签页 ====================
  Widget _buildInteractionTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // 售前咨询
        _buildInteractionCard(
          icon: Icons.support_agent,
          iconColor: Colors.blue,
          title: '售前咨询',
          count: _consultationCount,
          description: '查看和回复学员的售前咨询',
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('售前咨询功能开发中...')),
            );
          },
        ),

        const SizedBox(height: 16),

        // 课程答疑
        _buildInteractionCard(
          icon: Icons.question_answer,
          iconColor: Colors.green,
          title: '课程答疑',
          count: _qaCount,
          description: '查看和回复学员的课程问题',
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('课程答疑功能开发中...')),
            );
          },
        ),

        const SizedBox(height: 16),

        // 用户评价
        _buildReviewCard(),
      ],
    );
  }

  /// 构建互动卡片
  Widget _buildInteractionCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required int count,
    required String description,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.grey.withValues(alpha: 0.2),
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                size: 28,
                color: iconColor,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
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
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFFFF4757).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                '$count',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFF4757),
                ),
              ),
            ),
            const SizedBox(width: 8),
            const Icon(
              Icons.chevron_right,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

  /// 构建评价卡片
  Widget _buildReviewCard() {
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
          Row(
            children: [
              const Icon(
                Icons.star,
                size: 28,
                color: Colors.amber,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '用户评价',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '$_reviewCount 条评价',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '$_averageRating',
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFF4757),
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(5, (index) {
                      return Icon(
                        Icons.star,
                        size: 16,
                        color: index < _averageRating.floor()
                            ? Colors.amber
                            : Colors.grey[300],
                      );
                    }),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 12),
          // 评价示例
          _buildReviewItem(
            author: '张同学',
            rating: 5.0,
            content: '课程内容非常详细，老师讲得很好，干货满满！',
            date: '2026-03-20',
          ),
          const SizedBox(height: 12),
          _buildReviewItem(
            author: '李同学',
            rating: 4.5,
            content: '学到很多实用技能，项目实战很有帮助。',
            date: '2026-03-18',
          ),
          const SizedBox(height: 12),
          Center(
            child: TextButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('查看全部评价功能开发中...')),
                );
              },
              child: const Text('查看全部评价'),
            ),
          ),
        ],
      ),
    );
  }

  /// 构建评价项
  Widget _buildReviewItem({
    required String author,
    required double rating,
    required String content,
    required String date,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 20,
          backgroundColor: Colors.grey[200],
          child: Text(
            author[0],
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey[700],
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    author,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(5, (index) {
                      return Icon(
                        Icons.star,
                        size: 12,
                        color: index < rating.floor() ? Colors.amber : Colors.grey[300],
                      );
                    }),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                content,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 4),
              Text(
                date,
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey[500],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// ==================== 数据统计标签页 ====================
  Widget _buildDataStatsTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // 销售数据
        _buildStatCard(
          icon: Icons.attach_money,
          iconColor: Colors.green,
          title: '销售数据',
          stats: [
            {'label': '销售数量', 'value': '$_salesCount', 'unit': '份'},
            {'label': '总收入', 'value': '¥${(_totalRevenue).toStringAsFixed(2)}', 'unit': ''},
          ],
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('销售详情功能开发中...')),
            );
          },
        ),

        const SizedBox(height: 16),

        // 转发数据
        _buildStatCard(
          icon: Icons.share,
          iconColor: Colors.blue,
          title: '转发数据',
          stats: [
            {'label': '转发次数', 'value': '$_forwardCount', 'unit': '次'},
            {'label': '转发转化', 'value': '12.5', 'unit': '%'},
          ],
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('转发详情功能开发中...')),
            );
          },
        ),

        const SizedBox(height: 16),

        // 学习数据
        _buildStatCard(
          icon: Icons.school,
          iconColor: Colors.orange,
          title: '学习数据',
          stats: [
            {'label': '学习人数', 'value': '$_salesCount', 'unit': '人'},
            {'label': '完课率', 'value': '68.3', 'unit': '%'},
          ],
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('学习详情功能开发中...')),
            );
          },
        ),
      ],
    );
  }

  /// 构建统计卡片
  Widget _buildStatCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required List<Map<String, String>> stats,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
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
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: iconColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    icon,
                    size: 24,
                    color: iconColor,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
                const Icon(
                  Icons.chevron_right,
                  color: Colors.grey,
                ),
              ],
            ),
            const SizedBox(height: 20),
            ...stats.map((stat) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      stat['label']!,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          stat['value']!,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFFF4757),
                          ),
                        ),
                        if (stat['unit']!.isNotEmpty) ...[
                          const SizedBox(width: 4),
                          Text(
                            stat['unit']!,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  /// ==================== 辅助方法 ====================

  /// 添加章节
  void _addChapter() {
    setState(() {
      _chapters.add({
        'id': DateTime.now().millisecondsSinceEpoch.toString(),
        'title': '第${_chapters.length + 1}章 新章节',
        'expanded': true,
        'lessons': <Map<String, dynamic>>[],
      });
    });
  }

  /// 添加课程
  void _addLesson(int chapterIndex) {
    final chapter = _chapters[chapterIndex];
    final lessons = (chapter['lessons'] as List<dynamic>).cast<Map<String, dynamic>>();

    setState(() {
      lessons.add({
        'id': '${chapterIndex + 1}.${lessons.length + 1}',
        'title': '${chapterIndex + 1}.${lessons.length + 1} 新课程',
        'duration': '00:00',
        'uploaded': false,
        'freePreview': false,
        'scheduledDate': null,
      });
    });
  }

  /// 编辑章节标题
  void _editChapterTitle(int chapterIndex) {
    final chapter = _chapters[chapterIndex];
    final TextEditingController controller = TextEditingController(text: chapter['title'] as String);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('编辑章节名称'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: '请输入章节名称',
            border: OutlineInputBorder(),
          ),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () {
              if (controller.text.trim().isNotEmpty) {
                setState(() {
                  chapter['title'] = controller.text.trim();
                });
                Navigator.pop(context);
              }
            },
            child: const Text(
              '确定',
              style: TextStyle(color: Color(0xFFFF4757)),
            ),
          ),
        ],
      ),
    );
  }

  /// 删除章节
  void _deleteChapter(int chapterIndex) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('删除章节'),
        content: const Text('确定要删除这个章节吗？章节内的所有课程也将被删除。'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _chapters.removeAt(chapterIndex);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('章节已删除')),
              );
            },
            child: const Text(
              '删除',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  /// 编辑课程标题
  void _editLessonTitle(int chapterIndex, int lessonIndex) {
    final lessons = (_chapters[chapterIndex]['lessons'] as List<dynamic>).cast<Map<String, dynamic>>();
    final lesson = lessons[lessonIndex];
    final TextEditingController controller = TextEditingController(text: lesson['title'] as String);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('编辑课程名称'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: '请输入课程名称',
            border: OutlineInputBorder(),
          ),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () {
              if (controller.text.trim().isNotEmpty) {
                setState(() {
                  lesson['title'] = controller.text.trim();
                });
                Navigator.pop(context);
              }
            },
            child: const Text(
              '确定',
              style: TextStyle(color: Color(0xFFFF4757)),
            ),
          ),
        ],
      ),
    );
  }

  /// 删除课程
  void _deleteLesson(int chapterIndex, int lessonIndex) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('删除课程'),
        content: const Text('确定要删除这个课程吗？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                final lessons = (_chapters[chapterIndex]['lessons'] as List<dynamic>).cast<Map<String, dynamic>>();
                lessons.removeAt(lessonIndex);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('课程已删除')),
              );
            },
            child: const Text(
              '删除',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  /// 切换试看状态
  void _toggleFreePreview(int chapterIndex, int lessonIndex) {
    final lessons = (_chapters[chapterIndex]['lessons'] as List<dynamic>).cast<Map<String, dynamic>>();
    setState(() {
      lessons[lessonIndex]['freePreview'] = !(lessons[lessonIndex]['freePreview'] as bool);
    });
  }

  /// 重新上传课程
  void _reuploadLesson(int chapterIndex, int lessonIndex) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('重新上传视频'),
        content: const Text('确定要重新上传这个课程的视频吗？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('视频上传功能开发中...')),
              );
            },
            child: const Text(
              '确定',
              style: TextStyle(color: Color(0xFFFF4757)),
            ),
          ),
        ],
      ),
    );
  }

  /// 构建租赁信息区域
  Widget _buildLeasingInfoSection() {
    final leasingType = _courseInfo['leasingType'] as String;
    final leasingTypeText = _courseInfo['leasingTypeText'] as String;

    String leasingInfo;

    if (leasingType == 'usage') {
      // 流量模式
      final remainingHours = _courseInfo['remainingHours'] as int;
      final remainingMinutes = _courseInfo['remainingMinutes'] as int;
      leasingInfo = '$leasingTypeText 剩余${remainingHours}小时${remainingMinutes}分';
    } else {
      // 周期性付费模式
      final remainingDays = _courseInfo['remainingDays'] as int;
      final expiryDate = _courseInfo['expiryDate'] as String;
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
                  GestureDetector(
                    onTap: () => _showRenewalDialog(context),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      child: const Text(
                        '续费',
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xFFFF4757),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  const Text('|', style: TextStyle(color: Colors.grey)),
                  GestureDetector(
                    onTap: () => _showChangePackageDialog(context),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      child: const Text(
                        '变更套餐',
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xFFFF4757),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  const Text('|', style: TextStyle(color: Colors.grey)),
                  GestureDetector(
                    onTap: () {
                      if (_isScheduledForTakeDown) {
                        _cancelScheduledTakeDown();
                      } else {
                        _showTakeDownDialog(context);
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      child: Text(
                        _isScheduledForTakeDown ? '取消预约下架' : '下架',
                        style: const TextStyle(
                          fontSize: 13,
                          color: Color(0xFFFF4757),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// 显示续费弹窗
  void _showRenewalDialog(BuildContext context) {
    final leasingTypeText = _courseInfo['leasingTypeText'] as String;
    String price = '';

    switch (_courseInfo['leasingType']) {
      case 'yearly':
        price = '¥2,988';
        break;
      case 'quarterly':
        price = '¥888';
        break;
      case 'monthly':
        price = '¥328';
        break;
      default:
        price = '¥699';
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
                  '续费',
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

            // 当前套餐信息
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.green.withValues(alpha: 0.2),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.workspace_premium,
                    color: Colors.green[700],
                    size: 32,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '当前套餐：$leasingTypeText',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '续费价格：$price',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.green[700],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // 确认续费按钮
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  // TODO: 跳转到支付页面
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('跳转到支付页面...')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  '确认续费',
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

  /// 显示变更套餐弹窗
  void _showChangePackageDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.6,
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
                    '变更套餐',
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

            // 套餐列表
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  _buildPackageOption(
                    title: '年费套餐',
                    description: '适合长期使用，性价比最高',
                    price: '¥2,988/年',
                    icon: Icons.workspace_premium,
                    iconColor: Colors.amber,
                    onTap: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('跳转到支付页面...')),
                      );
                    },
                  ),

                  const SizedBox(height: 12),

                  _buildPackageOption(
                    title: '季度套餐',
                    description: '按季度付费，灵活方便',
                    price: '¥888/季度',
                    icon: Icons.calendar_today,
                    iconColor: Colors.blue,
                    onTap: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('跳转到支付页面...')),
                      );
                    },
                  ),

                  const SizedBox(height: 12),

                  _buildPackageOption(
                    title: '月度套餐',
                    description: '按月付费，轻松上手',
                    price: '¥328/月',
                    icon: Icons.date_range,
                    iconColor: Colors.green,
                    onTap: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('跳转到支付页面...')),
                      );
                    },
                  ),

                  const SizedBox(height: 12),

                  _buildPackageOption(
                    title: '标准套餐（500小时）',
                    description: '按量付费，灵活使用',
                    price: '¥699',
                    icon: Icons.play_circle_outline,
                    iconColor: Colors.purple,
                    onTap: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('跳转到支付页面...')),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 构建套餐选项
  Widget _buildPackageOption({
    required String title,
    required String description,
    required String price,
    required IconData icon,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.grey.withValues(alpha: 0.2),
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
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
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
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: iconColor,
              ),
            ),

            const SizedBox(width: 8),

            // 箭头
            Icon(
              Icons.chevron_right,
              color: Colors.grey[400],
            ),
          ],
        ),
      ),
    );
  }

  /// 显示下架确认弹窗
  void _showTakeDownDialog(BuildContext context) {
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
                  '下架课架',
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

            // 警告信息
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.red.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.red.withValues(alpha: 0.2),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.warning,
                    color: Colors.red[700],
                    size: 28,
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '重要提示',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '当前套餐还未到期，如果选择立刻下架，剩余费用不退换。可选择到期预约下架，将在套餐结束后自动下架。',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.black87,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // 操作按钮
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      // TODO: 立刻下架
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('课架已下架'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.red,
                      side: const BorderSide(color: Colors.red),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      '立刻下架',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      setState(() {
                        _isScheduledForTakeDown = true;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('已设置到期自动下架'),
                          backgroundColor: Colors.green,
                        ),
                      );
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
                      '到期预约下架',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// 取消预约下架
  void _cancelScheduledTakeDown() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('取消预约下架'),
        content: const Text('确定要取消到期自动下架的预约吗？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _isScheduledForTakeDown = false;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('已取消预约下架'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text(
              '确定',
              style: TextStyle(color: Color(0xFFFF4757)),
            ),
          ),
        ],
      ),
    );
  }
}
