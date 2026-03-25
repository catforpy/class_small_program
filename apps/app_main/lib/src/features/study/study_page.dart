library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ui_components/ui_components.dart';
import 'package:go_router/go_router.dart';
import '../../shared_providers.dart';
import '../../router/app_routes.dart';
import 'study_schedule_page.dart';

// ==================== Riverpod Providers ====================

/// 学习页内容标签状态 Provider（我的课程/我的专栏）
final studyContentTabProvider = StateProvider<int>((ref) => 0);

/// 学习页面
class StudyPage extends ConsumerStatefulWidget {
  const StudyPage({super.key});

  @override
  ConsumerState<StudyPage> createState() => _StudyPageState();
}

class _StudyPageState extends ConsumerState<StudyPage> {
  /// PageView 控制器
  late PageController _pageController;

  /// 学习页内容标签列表
  static const List<UnderlineTabItem> _contentTabs = [
    UnderlineTabItem(id: '0', title: '我的课程'),
    UnderlineTabItem(id: '1', title: '我的专栏'),
  ];

  @override
  void initState() {
    super.initState();
    final selectedTabIndex = ref.read(studyTabProvider);
    _pageController = PageController(initialPage: selectedTabIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 监听 provider 变化，同步 PageView
    ref.listen<int>(studyTabProvider, (previous, next) {
      if (previous != next && _pageController.hasClients) {
        _pageController.animateToPage(
          next,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });

    return Scaffold(
      backgroundColor: Colors.white,
      // AppBar 由 MainShell 提供（包含标签导航栏）
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          ref.read(studyTabProvider.notifier).state = index;
        },
        children: [
          _buildTabPage('学习'),
          _buildTabPage('课表'),
        ],
      ),
    );
  }

  /// 构建标签页
  Widget _buildTabPage(String title) {
    if (title == '学习') {
      // 学习页面：显示横向卡片 + 学习数据统计 + 标签栏
      final selectedContentTabIndex = ref.watch(studyContentTabProvider);

      return Column(
        children: [
          const SizedBox(height: 16),
          _buildActionCard(),
          const SizedBox(height: 16),
          // 学习数据统计
          _buildStudyStats(),
          const SizedBox(height: 16),
          // 横向滑动标签栏（我的课程/我的专栏）
          _buildContentTabBar(selectedContentTabIndex),
          // 内容区域
          Expanded(
            child: _buildContentPage(selectedContentTabIndex),
          ),
        ],
      );
    } else {
      // 课表页面：使用学习计划页面
      return const StudySchedulePage();
    }
  }

  /// 构建学习数据统计
  Widget _buildStudyStats() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Text(
                  '今日学习',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '45分钟',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 1,
            height: 40,
            color: Colors.grey[300],
          ),
          Expanded(
            child: Column(
              children: [
                Text(
                  '累计学习',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '12.5小时',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 构建内容页面
  Widget _buildContentPage(int selectedIndex) {
    if (selectedIndex == 0) {
      // 我的课程
      return _buildMyCoursesPage();
    } else {
      // 我的专栏
      return _buildMyColumnsPage();
    }
  }

  /// 构建我的课程页面
  Widget _buildMyCoursesPage() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // 上次学习
        _buildSectionTitle('上次学习'),
        const SizedBox(height: 12),
        _buildLastStudyCard(),
        const SizedBox(height: 24),
        // 已购课程
        _buildSectionTitle('已购课程'),
        const SizedBox(height: 12),
        ..._buildPurchasedCourses(),
        const SizedBox(height: 24),
        // 观看历史
        _buildSectionTitle('观看历史'),
        const SizedBox(height: 12),
        ..._buildWatchHistory(),
        const SizedBox(height: 80),
      ],
    );
  }

  /// 构建我的专栏页面
  Widget _buildMyColumnsPage() {
    final teachers = [
      {
        'id': '1',
        'name': '王老师',
        'title': '资深Python工程师',
        'avatar': 'https://picsum.photos/100/100?random=501',
        'courses': 12,
        'students': 50000,
        'rating': 4.8,
      },
      {
        'id': '2',
        'name': '李老师',
        'title': '前端架构师',
        'avatar': 'https://picsum.photos/100/100?random=502',
        'courses': 8,
        'students': 32000,
        'rating': 4.9,
      },
      {
        'id': '3',
        'name': '张老师',
        'title': '数据科学专家',
        'avatar': 'https://picsum.photos/100/100?random=503',
        'courses': 15,
        'students': 68000,
        'rating': 4.7,
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: teachers.length,
      itemBuilder: (context, index) {
        final teacher = teachers[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
          ),
          child: Row(
            children: [
              // 老师头像
              CircleAvatar(
                radius: 35,
                backgroundImage: NetworkImage(teacher['avatar'] as String),
              ),
              const SizedBox(width: 16),
              // 老师信息
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      teacher['name'] as String,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      teacher['title'] as String,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          Icons.school,
                          size: 14,
                          color: Colors.grey[600],
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${teacher['courses']}门课程',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Icon(
                          Icons.people,
                          size: 14,
                          color: Colors.grey[600],
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${((teacher['students'] as int) / 1000).toStringAsFixed(1)}k学员',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Icon(
                          Icons.star,
                          size: 14,
                          color: Colors.orange[400],
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${teacher['rating']}',
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
              // 查看按钮
              Icon(
                Icons.chevron_right,
                color: Colors.grey[400],
              ),
            ],
          ),
        );
      },
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

  /// 构建上次学习卡片
  Widget _buildLastStudyCard() {
    return GestureDetector(
      onTap: () {
        // 跳转到上次学习的课程播放页面
        context.push('/lesson/1/1.2/1.2%20Python%E5%9F%BA%E6%9C%AC%E8%AF%AD%E6%B3%95');
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
        ),
        child: Row(
          children: [
            // 课程封面
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                'https://picsum.photos/100/75?random=301',
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
                    'Python 全栈开发实战套课',
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
                    '上次学习：1.2 Python基本语法',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 8),
                  // 进度条
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '学习进度',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey[600],
                            ),
                          ),
                          Text(
                            '35%',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      LinearProgressIndicator(
                        value: 0.35,
                        backgroundColor: Colors.grey[200],
                        valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // 继续学习按钮
            Icon(
              Icons.play_circle_outline,
              size: 32,
              color: Colors.green,
            ),
          ],
        ),
      ),
    );
  }

  /// 构建已购课程列表
  List<Widget> _buildPurchasedCourses() {
    final courses = [
      {
        'id': '1',
        'title': 'Python 全栈开发实战套课',
        'imageUrl': 'https://picsum.photos/200/150?random=302',
        'progress': 0.35,
        'lessons': 45,
        'completed': 16,
        'lastLessonId': '1.4',
        'lastLessonTitle': '1.4 流程控制语句',
      },
      {
        'id': '2',
        'title': 'Vue3 前端开发实战',
        'imageUrl': 'https://picsum.photos/200/150?random=303',
        'progress': 0.12,
        'lessons': 32,
        'completed': 4,
        'lastLessonId': '1.2',
        'lastLessonTitle': '1.2 Vue基础语法',
      },
    ];

    return courses.map((course) {
      return GestureDetector(
        onTap: () {
          // 跳转到课程播放页面
          final lessonId = course['lastLessonId'] as String;
          final lessonTitle = Uri.encodeComponent(course['lastLessonTitle'] as String);
          context.push('/lesson/${course['id']}/$lessonId/$lessonTitle');
        },
        child: Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
          ),
          child: Row(
            children: [
              // 课程封面
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
              // 课程信息
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
                          '${course['completed']}/${course['lessons']}课',
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
            ],
          ),
        ),
      );
    }).toList();
  }

  /// 构建观看历史列表
  List<Widget> _buildWatchHistory() {
    final history = [
      {
        'courseId': '1',
        'courseTitle': 'Python 全栈开发实战套课',
        'lessonId': '1.2',
        'title': '1.2 Python基本语法',
        'time': '2小时前',
        'duration': '15分钟',
      },
      {
        'courseId': '1',
        'courseTitle': 'Python 全栈开发实战套课',
        'lessonId': '2.1',
        'title': '2.1 HTML与CSS基础',
        'time': '昨天',
        'duration': '50分钟',
      },
    ];

    return history.map((item) {
      return GestureDetector(
        onTap: () {
          // 跳转到课程播放页面
          final lessonTitle = Uri.encodeComponent(item['title'] as String);
          context.push('/lesson/${item['courseId']}/${item['lessonId']}/$lessonTitle');
        },
        child: Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(
                Icons.history,
                size: 20,
                color: Colors.grey[600],
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['title'] as String,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      item['courseTitle'] as String,
                      style: TextStyle(
                        fontSize: 11,
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
                    item['time'] as String,
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey[500],
                    ),
                  ),
                  Text(
                    item['duration'] as String,
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }).toList();
  }

  /// 构建内容标签栏（我的课程/我的专栏）
  Widget _buildContentTabBar(int selectedIndex) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          // 左侧：标签栏
          Expanded(
            child: UnderlineTabs(
              tabs: _contentTabs,
              currentIndex: selectedIndex,
              onTap: (index) {
                ref.read(studyContentTabProvider.notifier).state = index;
              },
              indicatorConfig: const UnderlineIndicatorConfig(
                color: Colors.transparent, // 不显示下划线
                height: 0,
              ),
              styleConfig: const UnderlineTabStyleConfig(
                selectedColor: Colors.black87,
                unselectedColor: Colors.grey,
                selectedFontSize: 15,
                unselectedFontSize: 14,
                selectedFontWeight: FontWeight.w500,
                unselectedFontWeight: FontWeight.normal,
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                spacing: 20,
              ),
              backgroundColor: Colors.white,
              scrollable: false, // 只有两个标签，不需要滚动
            ),
          ),
          // 右侧："全部"按钮（仅在"我的课程"选中时显示）
          if (selectedIndex == 0)
            GestureDetector(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('查看全部课程')),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '全部',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(
                      Icons.chevron_right,
                      size: 18,
                      color: Colors.grey[600],
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  /// 构建功能卡片（横向排列5个图标）
  Widget _buildActionCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildActionItem(
            icon: Icons.favorite,
            label: '收藏',
            onTap: () {
              context.push(AppRoutes.favorites);
            },
          ),
          _buildActionItem(
            icon: Icons.question_answer,
            label: '问答',
            onTap: () {
              context.push(AppRoutes.questions);
            },
          ),
          _buildActionItem(
            icon: Icons.edit_note,
            label: '笔记',
            onTap: () {
              context.push(AppRoutes.notes);
            },
          ),
          _buildActionItem(
            icon: Icons.menu_book,
            label: '手记',
            onTap: () {
              context.push(AppRoutes.notebooks);
            },
          ),
          _buildActionItem(
            icon: Icons.download,
            label: '下载',
            onTap: () {
              context.push(AppRoutes.downloads);
            },
          ),
        ],
      ),
    );
  }

  /// 构建单个功能项
  Widget _buildActionItem({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: Colors.green[50],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              size: 16,
              color: Colors.green[700],
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
