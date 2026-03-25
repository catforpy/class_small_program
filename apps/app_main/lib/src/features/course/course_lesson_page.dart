library;

import 'package:flutter/material.dart';

/// 课程内容播放页面
///
/// ## 功能
/// - 顶部显示课程标题
/// - 视频播放器
/// - 四个标签：章节、大纲、答疑、资料
/// - 章节列表（当前课高亮显示）
/// - 课程大纲/介绍
/// - 答疑提问功能
/// - 学习资料下载
class CourseLessonPage extends StatefulWidget {
  final String courseId;
  final String lessonId;
  final String lessonTitle;

  const CourseLessonPage({
    super.key,
    required this.courseId,
    required this.lessonId,
    required this.lessonTitle,
  });

  @override
  State<CourseLessonPage> createState() => _CourseLessonPageState();
}

class _CourseLessonPageState extends State<CourseLessonPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // 模拟数据 - 当前课程的所有章节和课时
  final List<Map<String, dynamic>> _chapters = [
    {
      'id': '1',
      'title': '第1章 课程介绍',
      'lessons': [
        {'id': '1.1', 'title': '1.1 Python环境搭建', 'duration': '15分钟', 'isTrial': true},
        {'id': '1.2', 'title': '1.2 Python基本语法', 'duration': '45分钟', 'isTrial': true},
        {'id': '1.3', 'title': '1.3 数据类型和变量', 'duration': '30分钟', 'isTrial': true},
        {'id': '1.4', 'title': '1.4 流程控制语句', 'duration': '40分钟', 'isTrial': false},
      ],
    },
    {
      'id': '2',
      'title': '第2章 Web开发基础',
      'lessons': [
        {'id': '2.1', 'title': '2.1 HTML与CSS基础', 'duration': '50分钟', 'isTrial': false},
        {'id': '2.2', 'title': '2.2 JavaScript入门', 'duration': '1小时', 'isTrial': false},
      ],
    },
    {
      'id': '3',
      'title': '第3章 Django框架',
      'lessons': [
        {'id': '3.1', 'title': '3.1 Django项目结构', 'duration': '30分钟', 'isTrial': false},
      ],
    },
  ];

  // 当前课程大纲
  final String _lessonOutline = '''
# Python环境搭建 - 课程大纲

## 1. Python简介
- Python的历史和特点
- Python的应用领域
- 为什么选择Python

## 2. 安装Python
- Windows系统安装
- Mac系统安装
- Linux系统安装
- 验证安装是否成功

## 3. 开发环境配置
- IDLE使用介绍
- VS Code安装和配置
- PyCharm Community Edition介绍

## 4. 第一个Python程序
- Hello World
- Python交互式模式
- 运行Python脚本

## 5. 常见问题解决
- 安装失败的解决方案
- 环境变量配置问题
- 包管理工具pip的使用
''';

  // 当前课程介绍
  final String _lessonIntro = '''
本节课将带领大家从零开始搭建Python开发环境。无论您是Windows、Mac还是Linux用户，都能在本课程中找到适合自己的安装方法。

我们会详细介绍：
- 如何下载和安装Python
- 如何配置环境变量
- 如何选择合适的开发工具
- 如何编写和运行第一个Python程序

即使是完全没有编程经验的学员，通过本课程的学习也能顺利完成环境搭建，为后续的Python学习打下坚实的基础。
''';

  // 答疑列表
  final List<Map<String, dynamic>> _questions = [
    {
      'id': '1',
      'user': {'name': '学员小王', 'avatar': 'https://picsum.photos/50/50?random=801'},
      'question': 'Windows 11安装Python 3.12一直失败怎么办？',
      'answer': '',
      'time': '10分钟前',
      'likes': 5,
    },
    {
      'id': '2',
      'user': {'name': '编程新手', 'avatar': 'https://picsum.photos/50/50?random=802'},
      'question': 'VS Code和PyCharm应该选哪个？',
      'answer': '老师建议初学者使用VS Code，因为它更轻量级，插件丰富。等熟练后再考虑PyCharm。',
      'time': '2小时前',
      'likes': 18,
    },
  ];

  // 学习资料
  final List<Map<String, dynamic>>? _materials = [
    {
      'id': '1',
      'title': 'Python安装包下载链接.txt',
      'size': '1KB',
      'url': '#',
    },
    {
      'id': '2',
      'title': 'VS Code配置指南.pdf',
      'size': '2.3MB',
      'url': '#',
    },
    {
      'id': '3',
      'title': '课程源码.zip',
      'size': '15KB',
      'url': '#',
    },
  ];

  // 问题输入框控制器
  final TextEditingController _questionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _questionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: Text(widget.lessonTitle),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        children: [
          // 视频播放器
          _buildVideoPlayer(),
          // 标签栏
          _buildTabBar(),
          // 内容区域
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildChaptersTab(),
                _buildOutlineTab(),
                _buildQA_tab(),
                _buildMaterialsTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 构建视频播放器
  Widget _buildVideoPlayer() {
    return Container(
      color: Colors.black,
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.play_circle_outline,
                size: 80,
                color: Colors.white.withValues(alpha: 0.8),
              ),
              const SizedBox(height: 16),
              Text(
                '点击播放视频',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.8),
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 构建标签栏
  Widget _buildTabBar() {
    return Container(
      color: Colors.white,
      child: TabBar(
        controller: _tabController,
        labelColor: const Color(0xFFFF4757),
        labelStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        unselectedLabelColor: Colors.grey[600],
        unselectedLabelStyle: const TextStyle(fontSize: 15),
        indicatorColor: const Color(0xFFFF4757),
        indicatorWeight: 3,
        tabs: const [
          Tab(text: '章节'),
          Tab(text: '大纲'),
          Tab(text: '答疑'),
          Tab(text: '资料'),
        ],
      ),
    );
  }

  /// 构建章节标签页
  Widget _buildChaptersTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _chapters.length,
      itemBuilder: (context, index) {
        final chapter = _chapters[index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 章节标题
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Text(
                chapter['title'] as String,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            // 课时列表
            ...(chapter['lessons'] as List<Map<String, dynamic>>).map((lesson) {
              final isCurrentLesson = lesson['id'] as String == widget.lessonId;
              return Container(
                margin: const EdgeInsets.only(bottom: 8),
                decoration: BoxDecoration(
                  color: isCurrentLesson ? Colors.red.withValues(alpha: 0.1) : Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: isCurrentLesson ? Colors.red : Colors.grey.withValues(alpha: 0.2),
                    width: isCurrentLesson ? 1.5 : 1,
                  ),
                ),
                child: ListTile(
                  title: Text(
                    lesson['title'] as String,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: isCurrentLesson ? FontWeight.w600 : FontWeight.normal,
                      color: isCurrentLesson ? Colors.red : Colors.black87,
                    ),
                  ),
                  subtitle: Row(
                    children: [
                      if (lesson['isTrial'] as bool) ...[
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
                  trailing: isCurrentLesson
                      ? Icon(
                          Icons.play_circle_filled,
                          color: Colors.red,
                        )
                      : Icon(
                          Icons.play_circle_outline,
                          color: Colors.grey[400],
                        ),
                  onTap: () {
                    // 切换到该课
                    print('切换到课程: ${lesson['title']}');
                  },
                ),
              );
            }),
            const SizedBox(height: 16),
          ],
        );
      },
    );
  }

  /// 构建大纲标签页
  Widget _buildOutlineTab() {
    final hasOutline = _lessonOutline.isNotEmpty;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              hasOutline ? '课程大纲' : '课程介绍',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              hasOutline ? _lessonOutline : _lessonIntro,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
                height: 1.6,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 构建答疑标签页
  Widget _buildQA_tab() {
    return Column(
      children: [
        // 问题输入框
        Container(
          padding: const EdgeInsets.all(16),
          color: Colors.white,
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _questionController,
                  decoration: InputDecoration(
                    hintText: '输入您的问题...',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    filled: true,
                    fillColor: Colors.grey[100],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Container(
                decoration: const BoxDecoration(
                  color: Color(0xFFFF4757),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(Icons.send, color: Colors.white),
                  onPressed: () {
                    if (_questionController.text.trim().isNotEmpty) {
                      // 提交问题
                      print('提交问题: ${_questionController.text}');
                      _questionController.clear();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('问题提交成功')),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
        // 问题列表
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: _questions.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final question = _questions[index];
              final user = question['user'] as Map<String, dynamic>;
              final hasAnswer = (question['answer'] as String).isNotEmpty;

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
                          radius: 18,
                          backgroundImage: NetworkImage(user['avatar'] as String),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                user['name'] as String,
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
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
                        ),
                        Icon(
                          Icons.thumb_up_outlined,
                          size: 14,
                          color: Colors.grey[600],
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${question['likes']}',
                          style: TextStyle(
                            fontSize: 11,
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
                      // 回答
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
                            // 给回答打分
                            Row(
                              children: [
                                Text(
                                  '给回答打分：',
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                const SizedBox(width: 8),
                                ...List.generate(5, (starIndex) {
                                  return GestureDetector(
                                    onTap: () {
                                      // 记录打分
                                      print('给回答打分: ${starIndex + 1}星');
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text('感谢您的评分！${starIndex + 1}星')),
                                      );
                                    },
                                    child: Icon(
                                      Icons.star,
                                      size: 18,
                                      color: Colors.orange[300],
                                    ),
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
            },
          ),
        ),
      ],
    );
  }

  /// 构建资料标签页
  Widget _buildMaterialsTab() {
    if (_materials == null || _materials!.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.folder_off_outlined,
              size: 64,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              '暂无学习资料',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: _materials!.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final material = _materials![index];
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
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
                  color: Colors.blue,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              // 文件信息
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      material['title'] as String,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      material['size'] as String,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ),
              ),
              // 下载按钮
              IconButton(
                icon: const Icon(Icons.download, color: Color(0xFFFF4757)),
                onPressed: () {
                  print('下载资料: ${material['title']}');
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
