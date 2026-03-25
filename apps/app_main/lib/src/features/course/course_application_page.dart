library;

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:go_router/go_router.dart';

/// 课程申请上架页面
///
/// 讲师可以在这里创建新课程或编辑课程信息
class CourseApplicationPage extends StatefulWidget {
  const CourseApplicationPage({super.key});

  @override
  State<CourseApplicationPage> createState() => _CourseApplicationPageState();
}

class _CourseApplicationPageState extends State<CourseApplicationPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // 重新提交审核模式
  bool _isResubmitMode = false;
  String? _resubmitCourseId;

  // 基本信息
  String? _selectedCategory;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _subtitleController = TextEditingController();
  final TextEditingController _introductionController = TextEditingController();
  final TextEditingController _objectivesController = TextEditingController();
  final TextEditingController _highlightsController = TextEditingController();
  String? _selectedDifficulty;
  String? _selectedStatus;

  // 价格设置
  final TextEditingController _priceController = TextEditingController(text: '199');
  final TextEditingController _originalPriceController = TextEditingController(text: '299');
  bool _hasActivity = false;
  final TextEditingController _activityPriceController = TextEditingController(text: '149');
  bool _commissionEnabled = true;
  double _commissionRate = 10.0;

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
          'uploaded': false,
          'freePreview': false,
          'scheduledDate': '2026-04-01',
        },
      ],
    },
    {
      'id': '2',
      'title': '第2章 Web开发基础',
      'expanded': false,
      'lessons': [
        {
          'id': '2.1',
          'title': '2.1 HTML与CSS基础',
          'duration': '30:00',
          'uploaded': true,
          'freePreview': true,
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
    {
      'id': '2',
      'title': '课后练习题',
      'description': '每章配套练习题及答案',
      'fileSize': '2.5 MB',
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

  final List<String> _categories = [
    '后端开发',
    '前端开发',
    '移动开发',
    '人工智能',
    '数据科学',
    '云计算',
    'DevOps',
    '设计',
  ];

  final List<String> _difficulties = [
    '入门级',
    '初级',
    '中级',
    '高级',
    '专家级',
  ];

  final List<String> _statuses = [
    '预售',
    '更新中',
    '已完结',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);

    // 检查是否是重新提交模式
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final state = GoRouterState.of(context);
      final courseId = state.uri.queryParameters['courseId'];
      final mode = state.uri.queryParameters['mode'];

      if (courseId != null && mode == 'resubmit') {
        setState(() {
          _isResubmitMode = true;
          _resubmitCourseId = courseId;
        });
        // TODO: 加载已有课程数据
        _loadExistingCourseData(courseId);
      }
    });
  }

  /// 加载已有课程数据（用于重新提交审核）
  void _loadExistingCourseData(String courseId) {
    // TODO: 从API加载课程数据
    // 这里先使用模拟数据
    final existingCourse = {
      'title': 'Vue3 前端开发实战',
      'subtitle': '现代前端框架完全指南',
      'category': '前端开发',
      'price': 12900,
      'originalPrice': 18900,
      'hasActivity': false,
      'activityPrice': 0,
      'commissionEnabled': false,
      'commissionRate': 0,
    };

    // 填充表单数据
    _titleController.text = existingCourse['title'] as String;
    _subtitleController.text = existingCourse['subtitle'] as String;
    _selectedCategory = existingCourse['category'] as String?;
    _priceController.text = ((existingCourse['price'] as int) / 100).toStringAsFixed(0);
    _originalPriceController.text = ((existingCourse['originalPrice'] as int) / 100).toStringAsFixed(0);
    _hasActivity = existingCourse['hasActivity'] as bool;
    _commissionEnabled = existingCourse['commissionEnabled'] as bool;
    _commissionRate = (existingCourse['commissionRate'] as int).toDouble();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _titleController.dispose();
    _subtitleController.dispose();
    _introductionController.dispose();
    _objectivesController.dispose();
    _highlightsController.dispose();
    _priceController.dispose();
    _originalPriceController.dispose();
    _activityPriceController.dispose();
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
          _isResubmitMode ? '重新提交审核' : '申请上架课程',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        actions: [
          // 保存草稿按钮
          TextButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('草稿已保存')),
              );
            },
            child: const Text(
              '保存草稿',
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey,
              ),
            ),
          ),
          // 提交审核按钮
          TextButton(
            onPressed: _submitCourse,
            child: const Text(
              '提交审核',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Color(0xFFFF4757),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
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
                Tab(text: '基本信息'),
                Tab(text: '课程大纲'),
                Tab(text: '课程资料'),
                Tab(text: '价格设置'),
              ],
            ),
          ),
          // 标签内容
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildBasicInfoTab(),
                _buildCourseOutlineTab(),
                _buildCourseMaterialsTab(),
                _buildPriceSettingsTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// ==================== 基本信息标签页 ====================
  Widget _buildBasicInfoTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // 课程分类
        _buildSectionCard(
          title: '课程分类',
          child: DropdownButtonFormField<String>(
            value: _selectedCategory,
            decoration: const InputDecoration(
              hintText: '请选择课程分类',
              border: OutlineInputBorder(),
            ),
            items: _categories.map((category) {
              return DropdownMenuItem(
                value: category,
                child: Text(category),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedCategory = value;
              });
            },
          ),
        ),

        const SizedBox(height: 16),

        // 课程名称
        _buildSectionCard(
          title: '课程名称',
          child: Column(
            children: [
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  hintText: '请输入课程名称',
                  border: OutlineInputBorder(),
                ),
                maxLength: 50,
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _subtitleController,
                decoration: const InputDecoration(
                  hintText: '请输入课程副标题（可选）',
                  border: OutlineInputBorder(),
                ),
                maxLength: 100,
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // 课程介绍
        _buildSectionCard(
          title: '课程介绍',
          child: TextField(
            controller: _introductionController,
            maxLines: 5,
            decoration: const InputDecoration(
              hintText: '请输入课程详细介绍...',
              border: OutlineInputBorder(),
            ),
            maxLength: 500,
          ),
        ),

        const SizedBox(height: 16),

        // 课程目标
        _buildSectionCard(
          title: '课程目标',
          child: TextField(
            controller: _objectivesController,
            maxLines: 4,
            decoration: const InputDecoration(
              hintText: '学员完成课程后能够掌握什么技能？',
              border: OutlineInputBorder(),
            ),
            maxLength: 500,
          ),
        ),

        const SizedBox(height: 16),

        // 课程亮点
        _buildSectionCard(
          title: '课程亮点',
          child: TextField(
            controller: _highlightsController,
            maxLines: 4,
            decoration: const InputDecoration(
              hintText: '本课程的特色和亮点是什么？',
              border: OutlineInputBorder(),
            ),
            maxLength: 500,
          ),
        ),

        const SizedBox(height: 16),

        // 课程难度和状态
        Row(
          children: [
            Expanded(
              child: _buildSectionCard(
                title: '课程难度',
                child: DropdownButtonFormField<String>(
                  value: _selectedDifficulty,
                  decoration: const InputDecoration(
                    hintText: '选择难度',
                    border: OutlineInputBorder(),
                  ),
                  items: _difficulties.map((difficulty) {
                    return DropdownMenuItem(
                      value: difficulty,
                      child: Text(difficulty),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedDifficulty = value;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildSectionCard(
                title: '课程状态',
                child: DropdownButtonFormField<String>(
                  value: _selectedStatus,
                  decoration: const InputDecoration(
                    hintText: '选择状态',
                    border: OutlineInputBorder(),
                  ),
                  items: _statuses.map((status) {
                    return DropdownMenuItem(
                      value: status,
                      child: Text(status),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedStatus = value;
                    });
                  },
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 80),
      ],
    );
  }

  /// ==================== 课程大纲标签页 ====================
  Widget _buildCourseOutlineTab() {
    return Column(
      children: [
        // 上传大纲按钮
        Container(
          padding: const EdgeInsets.all(16),
          color: Colors.white,
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    GoRouter.of(context).push('/course-outline-upload');
                  },
                  icon: const Icon(Icons.upload_file),
                  label: const Text('批量上传课程大纲'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF4757),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
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

        // 添加章节按钮
        Container(
          padding: const EdgeInsets.all(16),
          color: Colors.white,
          child: SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: _addChapter,
              icon: const Icon(Icons.add),
              label: const Text('添加章节'),
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFFFF4757),
                padding: const EdgeInsets.symmetric(vertical: 12),
                side: const BorderSide(color: Color(0xFFFF4757)),
              ),
            ),
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
    final scheduledDate = lesson['scheduledDate'] as String?;

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
                style: TextStyle(
                  fontSize: 14,
                  color: uploaded ? Colors.black87 : Colors.grey[600],
                  decoration: !uploaded ? TextDecoration.lineThrough : null,
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
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              uploaded ? '时长：${lesson['duration']}' : '未上传',
              style: TextStyle(
                fontSize: 12,
                color: uploaded ? Colors.grey[600] : Colors.red,
              ),
            ),
            if (!uploaded && scheduledDate != null)
              Text(
                '预计上传：$scheduledDate',
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.orange[700],
                ),
              ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 编辑按钮
            IconButton(
              icon: const Icon(Icons.edit, size: 18, color: Colors.blue),
              onPressed: () => _editLessonTitle(chapterIndex, lessonIndex),
              tooltip: '编辑课程',
            ),
            // 试看开关
            if (uploaded)
              IconButton(
                icon: Icon(
                  freePreview ? Icons.visibility : Icons.visibility_off,
                  size: 18,
                  color: freePreview ? Colors.green : Colors.grey,
                ),
                onPressed: () => _toggleFreePreview(chapterIndex, lessonIndex),
                tooltip: freePreview ? '关闭试看' : '开启试看',
              ),
            // 上传按钮
            IconButton(
              icon: Icon(
                uploaded ? Icons.check_circle : Icons.upload,
                size: 20,
                color: uploaded ? Colors.green : Colors.orange,
              ),
              onPressed: () => _uploadLesson(chapterIndex, lessonIndex),
              tooltip: uploaded ? '已上传' : '上传课程',
            ),
            // 设置日期按钮
            if (!uploaded)
              IconButton(
                icon: const Icon(Icons.schedule, size: 20),
                onPressed: () => _setLessonDate(chapterIndex, lessonIndex),
                tooltip: '设置上传时间',
              ),
            // 删除按钮
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

  /// 价格设置标签页
  Widget _buildPriceSettingsTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // 课程定价
        _buildSectionCard(
          title: '课程定价',
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _priceController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: '售价（元）',
                        prefixText: '¥',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextField(
                      controller: _originalPriceController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: '原价（元）',
                        prefixText: '¥',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                '提示：设置原价后，售价前会显示划线的原价，突出优惠力度',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[500],
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // 活动设置
        _buildSectionCard(
          title: '活动设置',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SwitchListTile(
                title: const Text('开启活动价'),
                subtitle: const Text('开启后，学员可以以活动价购买课程'),
                value: _hasActivity,
                onChanged: (value) {
                  setState(() {
                    _hasActivity = value;
                  });
                },
              ),
              if (_hasActivity) ...[
                const SizedBox(height: 12),
                TextField(
                  controller: _activityPriceController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: '活动价（元）',
                    prefixText: '¥',
                    border: OutlineInputBorder(),
                    helperText: '活动价必须低于售价',
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.orange.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Colors.orange.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.info_outline, size: 16, color: Colors.orange[700]),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          '当前活动优惠：省¥${((double.tryParse(_originalPriceController.text) ?? 0.0) - (double.tryParse(_activityPriceController.text) ?? 0.0)).toStringAsFixed(0)}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.orange[700],
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
          title: '转发赠金',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SwitchListTile(
                title: const Text('启用转发赠金'),
                subtitle: const Text('学员通过分享链接购买后，分享者可获得赠金奖励'),
                value: _commissionEnabled,
                onChanged: (value) {
                  setState(() {
                    _commissionEnabled = value;
                  });
                },
              ),
              if (_commissionEnabled) ...[
                const SizedBox(height: 12),
                Text(
                  '赠金比例：${_commissionRate.toStringAsFixed(0)}%',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 12),
                Slider(
                  value: _commissionRate,
                  min: 0,
                  max: 50,
                  divisions: 50,
                  label: '${_commissionRate.toStringAsFixed(0)}%',
                  activeColor: const Color(0xFFFF4757),
                  onChanged: (value) {
                    setState(() {
                      _commissionRate = value;
                    });
                  },
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '0%',
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                    Text(
                      '25%',
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                    Text(
                      '50%',
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.blue.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Colors.blue.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.info_outline, size: 16, color: Colors.blue[700]),
                          const SizedBox(width: 8),
                          Text(
                            '赠金示例',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Colors.blue[700],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '假设课程售价¥${(double.tryParse(_priceController.text) ?? 0).toStringAsFixed(0)}，学员通过分享链接购买：',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[700],
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '• 您的收入：¥${(double.tryParse(_priceController.text) ?? 0 * (1 - _commissionRate / 100)).toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey[600],
                        ),
                      ),
                      Text(
                        '• 分享者赠金：¥${(double.tryParse(_priceController.text) ?? 0 * _commissionRate / 100).toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),

        const SizedBox(height: 80),
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
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.download, size: 20),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('下载 ${material['title']}')),
                  );
                },
                tooltip: '下载',
              ),
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
            {'label': '总收入', 'value': '¥${(29900 * _salesCount / 100).toStringAsFixed(2)}', 'unit': ''},
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

  /// 构建区块卡片
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
              fontSize: 15,
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
                // 重新编号章节
                for (int i = 0; i < _chapters.length; i++) {
                  final chapter = _chapters[i];
                  // 更新章节ID
                  chapter['id'] = (i + 1).toString();
                }
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
                // 重新编号课程
                for (int i = 0; i < lessons.length; i++) {
                  lessons[i]['id'] = '${chapterIndex + 1}.${i + 1}';
                }
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

  /// 上传课程
  void _uploadLesson(int chapterIndex, int lessonIndex) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('上传视频功能开发中...')),
    );
  }

  /// 设置课程上传时间
  void _setLessonDate(int chapterIndex, int lessonIndex) {
    final lessons = (_chapters[chapterIndex]['lessons'] as List<dynamic>).cast<Map<String, dynamic>>();

    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    ).then((date) {
      if (date != null) {
        setState(() {
          lessons[lessonIndex]['scheduledDate'] =
              '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
        });
      }
    });
  }

  /// 提交课程
  void _submitCourse() {
    // 验证必填项
    if (_selectedCategory == null ||
        _titleController.text.trim().isEmpty ||
        _selectedDifficulty == null ||
        _selectedStatus == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('请完善基本信息（分类、名称、难度、状态）')),
      );
      return;
    }

    // 显示确认对话框
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('提交审核'),
        content: const Text('确认提交课程审核？提交后将进入审核流程。'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('课程已提交审核，请等待审核结果')),
              );
            },
            child: const Text(
              '确认提交',
              style: TextStyle(color: Color(0xFFFF4757)),
            ),
          ),
        ],
      ),
    );
  }
}
