library;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// 课程详情页
///
/// ## 设计理念
/// - 顶部横向滑动标签：课程介绍、章节目录、售前咨询、用户评价
/// - 课程介绍页面包含：课程状态、基本信息、讲师介绍、课程目标、课程亮点、课程大纲
/// - 底部导航栏：收藏、提问、购买（icon+文字，column布局）
class CourseDetailPageV2 extends StatefulWidget {
  final String courseId;
  final String? initialTab;

  const CourseDetailPageV2({
    super.key,
    required this.courseId,
    this.initialTab,
  });

  @override
  State<CourseDetailPageV2> createState() => _CourseDetailPageV2State();
}

class _CourseDetailPageV2State extends State<CourseDetailPageV2>
    with SingleTickerProviderStateMixin {
  int _selectedTabIndex = 0;
  late TabController _tabController;

  // 模拟数据
  final int _consultCount = 15; // 售前咨询数量
  final int _reviewCount = 328; // 用户评价数量

  // 模拟咨询数据
  final List<Map<String, dynamic>> _consultData = [
    {
      'id': '1',
      'user': {'name': '学员小王', 'avatar': 'https://picsum.photos/50/50?random=601'},
      'question': '这个课程适合零基础学员吗？',
      'answer': '您好！本课程从Python基础讲起，非常适合零基础学员。课程内容循序渐进，包含大量实战项目，帮助您快速掌握Python全栈开发技能。',
      'time': '2小时前',
      'likes': 12,
    },
    {
      'id': '2',
      'user': {'name': '编程爱好者', 'avatar': 'https://picsum.photos/50/50?random=602'},
      'question': '学完能找到工作吗？',
      'answer': '课程包含5个企业级实战项目，并提供简历优化和面试技巧指导。很多学员通过学习本课程成功转行或升职加薪。',
      'time': '5小时前',
      'likes': 28,
    },
    {
      'id': '3',
      'user': {'name': '职场新人', 'avatar': 'https://picsum.photos/50/50?random=603'},
      'question': '课程有效期是多久？',
      'answer': '购买后可永久观看，课程内容会持续更新，一次购买终身学习。',
      'time': '1天前',
      'likes': 45,
    },
  ];

  // 模拟评价数据
  final List<Map<String, dynamic>> _reviewData = [
    {
      'id': '1',
      'user': {'name': '张三', 'avatar': 'https://picsum.photos/50/50?random=701'},
      'rating': 5,
      'content': '课程非常棒！老师讲解清晰，项目实战很有帮助，学到了很多干货。强烈推荐！',
      'time': '3天前',
      'likes': 89,
    },
    {
      'id': '2',
      'user': {'name': '李四', 'avatar': 'https://picsum.photos/50/50?random=702'},
      'rating': 4,
      'content': '整体不错，内容很系统。就是有些地方讲得有点快，需要反复看几遍才能理解。',
      'time': '5天前',
      'likes': 56,
    },
    {
      'id': '3',
      'user': {'name': '王五', 'avatar': 'https://picsum.photos/50/50?random=703'},
      'rating': 5,
      'content': '作为零基础学员，这门课程让我从入门到精通，现在已经能独立开发项目了，感谢老师！',
      'time': '1周前',
      'likes': 123,
    },
  ];

  // 模拟课程数据
  final Map<String, dynamic> _courseData = {
    'id': '1',
    'title': 'Python 全栈开发实战套课',
    'subtitle': '从零开始掌握 Python 全栈开发，包含前端、后端、数据库等核心技术',
    'imageUrl': 'https://picsum.photos/600/400?random=101',
    'price': 19900,
    'originalPrice': 29900,
    'status': 'updating',
    'difficulty': 'intermediate',
    'duration': '32小时45分钟',
    'studentCount': 12345,
    'rating': 4.8,
    'ratingCount': 3567,
    'hasTrial': true, // 是否有试看
    'trialLessons': 3, // 试看课时数
    'hasCommission': true, // 是否有提成
    'commissionRate': 10, // 提成百分比
    'instructor': {
      'name': '王老师',
      'title': '资深Python工程师',
      'avatar': 'https://picsum.photos/100/100?random=501',
      'bio': '10年Python开发经验，曾任职于多家知名互联网公司，擅长Python全栈开发、数据分析、人工智能等领域。累计授课学员超过10万人次。',
      'courses': 12,
      'students': 50000,
    },
    'goals': [
      {'title': '掌握Python基础', 'description': '从零开始学习Python语法和数据结构'},
      {'title': 'Web全栈开发', 'description': '熟练使用Django/Flask进行Web应用开发'},
      {'title': '数据分析能力', 'description': '使用Pandas、NumPy进行数据分析和可视化'},
      {'title': '项目实战经验', 'description': '通过5个实战项目巩固所学知识'},
    ],
    'highlights': [
      {'imageUrl': 'https://picsum.photos/100/100?random=201', 'title': '实战导向', 'description': '5个真实企业级项目实战'},
      {'imageUrl': 'https://picsum.photos/100/100?random=202', 'title': '系统全面', 'description': '覆盖Python全栈开发所有核心技能'},
      {'imageUrl': 'https://picsum.photos/100/100?random=203', 'title': '就业指导', 'description': '提供简历优化和面试技巧指导'},
      {'imageUrl': 'https://picsum.photos/100/100?random=204', 'title': '终身更新', 'description': '课程内容持续更新，一次购买终身学习'},
    ],
    'chapters': [
      {
        'id': '1',
        'title': '第1章 课程介绍',
        'content': '本章对课程内容、知识点、授课过程进行引导性说明。',
        'duration': '4小时30分钟',
        'hasTrial': true,
        'lessons': [
          {'title': '1.1 Python环境搭建', 'duration': '15分钟', 'isTrial': true, 'updateDate': null},
          {'title': '1.2 Python基本语法', 'duration': '45分钟', 'isTrial': true, 'updateDate': null},
          {'title': '1.3 数据类型和变量', 'duration': '30分钟', 'isTrial': true, 'updateDate': null},
          {'title': '1.4 流程控制语句', 'duration': '40分钟', 'updateDate': null},
        ],
      },
      {
        'id': '2',
        'title': '第2章 一个SQL语句是怎么执行的？',
        'content': '本章介绍MySQL的各个组成部分与架构设计思路，演示MySQL的网络连接方法及图解一次更新SQL的执行过程等，建立MySQL清晰的架构体系，深入理解MySQL Server层+存储引擎层的架构体系，并理解存储引擎插化的好处。',
        'duration': '6小时15分钟',
        'hasTrial': false,
        'lessons': [
          {'title': '2.1 HTML与CSS基础', 'duration': '50分钟', 'updateDate': null},
          {'title': '2.2 JavaScript入门', 'duration': '1小时', 'updateDate': null},
        ],
      },
      {
        'id': '3',
        'title': '第3章 如何建表更符合业务？',
        'content': '本章详细学习InnoDB的数据表底层原理，详细阐述B+树与逻辑存储结构，掌握如何建立高效索引、如何优化数据表结构。',
        'duration': '8小时',
        'hasTrial': false,
        'lessons': [
          {'title': '3.1 Django项目结构', 'duration': '30分钟', 'updateDate': null},
        ],
      },
      {
        'id': '4',
        'title': '第4章 怎么查询速度更快？',
        'content': '本章讲解MySQL排序、随机、联合索引等原理。在丰富的实战场景下学习分析慢SQL语句的思路，并学习如何多角度优化慢SQL性能。',
        'duration': '10小时',
        'hasTrial': false,
        'lessons': [],
        'updateDate': '2026-04-01', // 章节预计更新时间
        'updateStatus': 'pending', // pending/updating/completed
      },
      {
        'id': '5',
        'title': '第5章 如何处理数据更新？',
        'content': '本章讲解InnoDB日志、锁和事务的原理，并讲述MVCC原理、间隙锁原理。并学习如何解决事务场景下的慢事务、死锁等问题。',
        'duration': '4小时',
        'hasTrial': false,
        'lessons': [],
        'updateDate': '2026-04-15', // 章节预计更新时间
        'updateStatus': 'pending',
      },
    ],
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    if (widget.initialTab != null) {
      _switchToTab(widget.initialTab!);
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _switchToTab(String tab) {
    final tabIndex = ['intro', 'chapters', 'consult', 'reviews'].indexOf(tab);
    if (tabIndex != -1) {
      setState(() {
        _selectedTabIndex = tabIndex;
        _tabController.animateTo(tabIndex);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: Column(
        children: [
          // 课程信息区域（状态 + 基本信息 + 课程图片）
          _buildCourseHeader(),
          // 横向滑动标签
          _buildTabBar(),
          // 内容区域
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildIntroTab(),
                _buildChaptersTab(),
                _buildConsultTab(),
                _buildReviewsTab(),
              ],
            ),
          ),
          // 底部导航栏
          _buildBottomNav(),
        ],
      ),
    );
  }

  /// 构建课程头部信息
  Widget _buildCourseHeader() {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 返回按钮 + 课程图片
          Stack(
            children: [
              // 课程图片
              AspectRatio(
                aspectRatio: 16 / 9,
                child: Image.network(
                  _courseData['imageUrl'] as String,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    color: Colors.grey[300],
                    child: const Icon(Icons.image, size: 48),
                  ),
                ),
              ),
              // 返回按钮
              Positioned(
                top: 8,
                left: 8,
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.5),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
              ),
            ],
          ),
          // 状态标签和信息
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 课程状态
                Row(
                  children: [
                    _buildStatusBadge(_courseData['status'] as String),
                    const SizedBox(width: 8),
                    _buildDifficultyBadge(_courseData['difficulty'] as String),
                  ],
                ),
                const SizedBox(height: 12),
                // 课程标题
                Text(
                  _courseData['title'] as String,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                // 课程副标题
                Text(
                  _courseData['subtitle'] as String,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 16),
                // 基本信息（时长、学习人数、评分）
                Row(
                  children: [
                    _buildInfoItem(
                      Icons.access_time,
                      _courseData['duration'] as String,
                    ),
                    const SizedBox(width: 16),
                    _buildInfoItem(
                      Icons.people,
                      '${((_courseData['studentCount'] as int) / 1000).toStringAsFixed(1)}k人学',
                    ),
                    const SizedBox(width: 16),
                    _buildInfoItem(
                      Icons.star,
                      '${_courseData['rating']} 分',
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

  /// 构建状态标签
  Widget _buildStatusBadge(String status) {
    String label;
    Color color;

    switch (status) {
      case 'completed':
        label = '已完结';
        color = Colors.green;
        break;
      case 'updating':
        label = '更新中';
        color = Colors.blue;
        break;
      case 'presale':
        label = '预售中';
        color = Colors.orange;
        break;
      default:
        label = '已完结';
        color = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  /// 构建难度标签
  Widget _buildDifficultyBadge(String difficulty) {
    String label;
    Color color;

    switch (difficulty) {
      case 'beginner':
        label = '初级';
        color = const Color(0xFF4CAF50);
        break;
      case 'intermediate':
        label = '中级';
        color = const Color(0xFFFF9800);
        break;
      case 'advanced':
        label = '高级';
        color = const Color(0xFFF44336);
        break;
      case 'practical':
        label = '实战';
        color = const Color(0xFF9C27B0);
        break;
      default:
        label = '中级';
        color = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: color, width: 1),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  /// 构建信息项
  Widget _buildInfoItem(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: Colors.grey[600]),
        const SizedBox(width: 4),
        Text(
          text,
          style: TextStyle(
            fontSize: 13,
            color: Colors.grey[700],
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  /// 构建横向滑动标签栏
  Widget _buildTabBar() {
    return Container(
      color: Colors.white,
      child: TabBar(
        controller: _tabController,
        onTap: (index) {
          setState(() {
            _selectedTabIndex = index;
          });
        },
        labelColor: Colors.grey[600],
        labelStyle: const TextStyle(fontSize: 15),
        unselectedLabelColor: Colors.grey[400],
        unselectedLabelStyle: const TextStyle(fontSize: 15),
        indicatorColor: const Color(0xFFFF4757),
        indicatorWeight: 3,
        labelPadding: const EdgeInsets.symmetric(horizontal: 8),
        tabs: [
          const Tab(text: '课程介绍'),
          Tab(
            child: _buildTabWithBadge(
              '章节目录',
              badge: _courseData['hasTrial'] as bool ? '试看' : null,
            ),
          ),
          Tab(
            child: _buildTabWithBadge(
              '售前咨询',
              badge: _consultCount > 0 ? (_consultCount > 99 ? '99+' : '$_consultCount') : null,
            ),
          ),
          Tab(
            child: _buildTabWithBadge(
              '用户评价',
              badge: _reviewCount > 0 ? (_reviewCount > 999 ? '999+' : '$_reviewCount') : null,
            ),
          ),
        ],
      ),
    );
  }

  /// 构建带角标的标签
  Widget _buildTabWithBadge(String text, {String? badge}) {
    if (badge == null) {
      return Text(text);
    }
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(text),
        ),
        Positioned(
          top: 0,
          right: -12,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(6),
            ),
            constraints: const BoxConstraints(
              minWidth: 16,
            ),
            child: Text(
              badge,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 9,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }

  /// 构建课程介绍标签页
  Widget _buildIntroTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // 讲师介绍
        _buildSection('讲师介绍', _buildInstructorSection()),
        const SizedBox(height: 24),
        // 课程目标
        _buildSection('课程目标', _buildGoalsSection()),
        const SizedBox(height: 24),
        // 课程亮点
        _buildSection('课程亮点', _buildHighlightsSection()),
        const SizedBox(height: 24),
        // 课程大纲
        _buildSection('课程大纲', _buildOutlineSection()),
        const SizedBox(height: 24),
        // 分享提成规则（仅在有提成的课程显示）
        if (_courseData['hasCommission'] as bool) ...[
          _buildCommissionSection(),
          const SizedBox(height: 24),
        ],
        const SizedBox(height: 80), // 为底部导航栏留空间
      ],
    );
  }

  /// 构建章节目录标签页
  Widget _buildChaptersTab() {
    final chapters = _courseData['chapters'] as List<Map<String, dynamic>>;
    final isUpdating = _courseData['status'] == 'updating';

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: chapters.length,
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final chapter = chapters[index];
        final hasTrial = chapter['hasTrial'] as bool? ?? false;
        final lessons = chapter['lessons'] as List<dynamic>;
        final updateDate = chapter['updateDate'] as String?;
        final updateStatus = chapter['updateStatus'] as String?;

        // 判断章节是否待更新
        final isChapterPending = isUpdating && updateStatus == 'pending' && lessons.isEmpty;

        return ExpansionTile(
          title: Row(
            children: [
              Expanded(
                child: Text(
                  chapter['title'] as String,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              if (hasTrial)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text(
                    '试看',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
            ],
          ),
          subtitle: isChapterPending
              ? Text(
                  '待更新，预计${updateDate ?? '4月1日'}更新',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.orange,
                    fontWeight: FontWeight.w500,
                  ),
                )
              : Text(
                  chapter['duration'] as String,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[600],
                  ),
                ),
          children: lessons.isEmpty
              ? []
              : lessons.map<Widget>((lesson) {
                  final isTrial = lesson['isTrial'] as bool? ?? false;
                  final lessonUpdateDate = lesson['updateDate'] as String?;
                  final isLessonPending = lessonUpdateDate != null;

                  return ListTile(
                    dense: true,
                    title: Text(
                      lesson['title'] as String,
                      style: const TextStyle(fontSize: 13),
                    ),
                    trailing: isLessonPending
                        ? Text(
                            '待更新，预计$lessonUpdateDate',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.orange,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        : Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (isTrial) ...[
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                                  decoration: BoxDecoration(
                                    color: Colors.orange.withValues(alpha: 0.15),
                                    borderRadius: BorderRadius.circular(3),
                                    border: Border.all(color: Colors.orange, width: 0.5),
                                  ),
                                  child: Text(
                                    '试看',
                                    style: TextStyle(
                                      color: Colors.orange,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                              ],
                              Text(
                                lesson['duration'] as String,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[500],
                                ),
                              ),
                            ],
                          ),
                    onTap: () {
                      // 跳转到课程播放页面
                      final lessonIndex = lessons.indexOf(lesson) + 1;
                      final lessonId = '${chapter['id']}.$lessonIndex';
                      final lessonTitle = lesson['title'] as String;
                      context.push('/lesson/${_courseData['id']}/$lessonId/$lessonTitle');
                    },
                  );
                }).toList(),
        );
      },
    );
  }

  /// 构建售前咨询标签页
  Widget _buildConsultTab() {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: _consultData.length,
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final consult = _consultData[index];
        final user = consult['user'] as Map<String, dynamic>;

        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 用户信息
              Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(user['avatar'] as String),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user['name'] as String,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          consult['time'] as String,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.thumb_up_outlined,
                    size: 16,
                    color: Colors.grey[600],
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${consult['likes']}',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              // 问题
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.orange.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Q: ${consult['question'] as String}',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.orange[700],
                    height: 1.4,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              // 回答
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'A: ${consult['answer'] as String}',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[700],
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  /// 构建用户评价标签页
  Widget _buildReviewsTab() {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: _reviewData.length,
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final review = _reviewData[index];
        final user = review['user'] as Map<String, dynamic>;
        final rating = review['rating'] as int;

        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 用户信息和评分
              Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(user['avatar'] as String),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user['name'] as String,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Row(
                          children: List.generate(5, (starIndex) {
                            return Icon(
                              starIndex < rating ? Icons.star : Icons.star_border,
                              size: 14,
                              color: const Color(0xFFFFB400),
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    review['time'] as String,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              // 评价内容
              Text(
                review['content'] as String,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey[700],
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 8),
              // 点赞
              Row(
                children: [
                  Icon(
                    Icons.thumb_up_outlined,
                    size: 16,
                    color: Colors.grey[600],
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${review['likes']}',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  /// 构建区块
  Widget _buildSection(String title, Widget child) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
        child,
      ],
    );
  }

  /// 构建讲师介绍
  Widget _buildInstructorSection() {
    final instructor = _courseData['instructor'] as Map<String, dynamic>;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          // 讲师头像
          CircleAvatar(
            radius: 40,
            backgroundImage: NetworkImage(
              instructor['avatar'] as String,
            ),
          ),
          const SizedBox(width: 16),
          // 讲师信息
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  instructor['name'] as String,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  instructor['title'] as String,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  instructor['bio'] as String,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[700],
                    height: 1.4,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      '${instructor['courses']}门课程',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${((instructor['students'] as int) / 1000).toStringAsFixed(1)}k学员',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
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

  /// 构建课程目标
  Widget _buildGoalsSection() {
    final goals = _courseData['goals'] as List<Map<String, dynamic>>;

    return Column(
      children: goals.map((goal) => Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.check_circle,
                  color: Color(0xFFFF4757),
                  size: 20,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    goal['title'] as String,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ),
            ],
          ),
            const SizedBox(height: 8),
            Text(
              goal['description'] as String,
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey[600],
                height: 1.4,
              ),
            ),
          ],
        ),
      )).toList(),
    );
  }

  /// 构建课程亮点
  Widget _buildHighlightsSection() {
    final highlights = _courseData['highlights'] as List<Map<String, dynamic>>;

    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 2.5,
      children: highlights.map((highlight) => Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
        ),
        child: Row(
          children: [
            // 图片
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.network(
                highlight['imageUrl'] as String,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  width: 50,
                  height: 50,
                  color: Colors.grey[300],
                  child: const Icon(Icons.image, size: 24),
                ),
              ),
            ),
            const SizedBox(width: 10),
            // 文字描述
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    highlight['title'] as String,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    highlight['description'] as String,
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey[600],
                      height: 1.3,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      )).toList(),
    );
  }

  /// 构建课程大纲（部分显示）
  Widget _buildOutlineSection() {
    final chapters = _courseData['chapters'] as List<Map<String, dynamic>>;

    return Column(
      children: [
        // 只显示前2章
        ...chapters.take(2).map((chapter) => Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 章节标题和时长
              Row(
                children: [
                  Expanded(
                    child: Text(
                      chapter['title'] as String,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  Text(
                    chapter['duration'] as String,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              // 章节内容（带渐变遮罩效果）
              ClipRect(
                child: SizedBox(
                  height: 60,
                  child: ShaderMask(
                    shaderCallback: (bounds) {
                      return const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Color(0xFF000000), Color(0x00000000)],
                        stops: [0.0, 1.0],
                      ).createShader(bounds);
                    },
                    blendMode: BlendMode.dstIn,
                    child: SingleChildScrollView(
                      physics: const NeverScrollableScrollPhysics(),
                      child: Text(
                        chapter['content'] as String? ?? '',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[600],
                          height: 1.5,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )),

        // 剩余章节提示
        if (chapters.length > 2)
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                Text(
                  '还有 ${chapters.length - 2} 个章节',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    // 跳转到章节目录标签页
                    _tabController.animateTo(1);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF4757),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                  ),
                  child: const Text(
                    '查看完整目录',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  /// 构建分享提成规则部分
  Widget _buildCommissionSection() {
    final commissionRate = _courseData['commissionRate'] as int;
    final price = _courseData['price'] as int;
    final commissionAmount = (price * commissionRate / 100).toInt();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.orange.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.orange.withValues(alpha: 0.3),
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 标题栏
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.orange.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.card_giftcard,
                  color: Colors.orange[700],
                  size: 24,
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
                          '分享赚佣金',
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.orange[700],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            '提成$commissionRate%',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '分享课程成功后可获得佣金',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // 收益示例
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.orange.withValues(alpha: 0.2),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.payments_outlined,
                  color: Colors.orange[700],
                  size: 28,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '收益示例',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[800],
                        ),
                      ),
                      const SizedBox(height: 6),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(fontSize: 13, color: Colors.grey[700]),
                          children: [
                            TextSpan(text: '课程价格 '),
                            TextSpan(
                              text: '¥${price ~/ 100}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFFF4757),
                              ),
                            ),
                            TextSpan(text: '，您可获得 '),
                            TextSpan(
                              text: '¥${commissionAmount ~/ 100}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.orange[700],
                                fontSize: 15,
                              ),
                            ),
                            TextSpan(text: ' 佣金'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // 提成规则
          Text(
            '提成规则',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          _buildRuleItem(
            icon: Icons.share,
            title: '分享课程',
            description: '点击分享按钮，将课程分享给好友或发布到社交媒体',
          ),
          const SizedBox(height: 10),
          _buildRuleItem(
            icon: Icons.person_add,
            title: '好友购买',
            description: '好友通过您的分享链接购买课程',
          ),
          const SizedBox(height: 10),
          _buildRuleItem(
            icon: Icons.check_circle,
            title: '获得佣金',
            description: '交易完成后，佣金将自动转入您的账户',
          ),

          const SizedBox(height: 20),

          // 费用说明
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.orange.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: Colors.orange[700],
                      size: 18,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      '费用说明',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.orange[900],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  '• 佣金比例按课程实际成交价格计算\n'
                  '• 退款订单不计入佣金\n'
                  '• 佣金将在交易完成后7个工作日内到账\n'
                  '• 单笔订单最高佣金不超过¥1000\n'
                  '• 月累计佣金超过¥800需缴纳个人所得税',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[700],
                    height: 1.6,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 构建规则项
  Widget _buildRuleItem({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: Colors.orange.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: Colors.orange[700],
            size: 18,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                description,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// 构建底部导航栏
  Widget _buildBottomNav() {
    final price = _courseData['price'] as int;
    final originalPrice = _courseData['originalPrice'] as int?;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            // 收藏按钮 - Column布局
            Expanded(
              child: GestureDetector(
                onTap: () {
                  print('收藏');
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.favorite_border,
                      color: Colors.grey[700],
                      size: 20,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '收藏',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 12),
            // 提问按钮 - Column布局
            Expanded(
              child: GestureDetector(
                onTap: () {
                  print('提问');
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.question_answer_outlined,
                      color: Colors.grey[700],
                      size: 20,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '提问',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 12),
            // 价格和购买按钮
            Expanded(
              flex: 2,
              child: ElevatedButton(
                onPressed: () {
                  print('购买课程');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF4757),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // 价格显示
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '¥${(price ~/ 100)}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (originalPrice != null) ...[
                          const SizedBox(height: 1),
                          Text(
                            '¥${(originalPrice! ~/ 100)}',
                            style: TextStyle(
                              fontSize: 9,
                              decoration: TextDecoration.lineThrough,
                              color: Colors.white.withValues(alpha: 0.7),
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(width: 6),
                    const Text(
                      '立即购买',
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
