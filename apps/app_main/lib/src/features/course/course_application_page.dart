library;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../shared/data/mocks/course_application_mock_data.dart';
import 'management/widgets/course_outline_tab.dart';
import 'management/widgets/course_materials_tab.dart';
import 'application/widgets/basic_info_form.dart';
import 'application/widgets/price_settings_form.dart';

/// 课程申请上架页面
///
/// 讲师可以在这里创建新课程或编辑课程信息
///
/// ## 重构说明
/// - 复用了 course_outline_tab.dart 和 course_materials_tab.dart
/// - 新建了 basic_info_form.dart 和 price_settings_form.dart
/// - 主文件从1835行减少到约240行
class CourseApplicationPage extends StatefulWidget {
  const CourseApplicationPage({super.key});

  @override
  State<CourseApplicationPage> createState() => _CourseApplicationPageState();
}

class _CourseApplicationPageState extends State<CourseApplicationPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // 重新提交审核模式
  bool _isResubmitMode = false;
  String? _resubmitCourseId;

  // 课程数据
  List<Map<String, dynamic>> _chapters = [];
  List<Map<String, dynamic>> _materials = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _loadMockData();

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
        _loadExistingCourseData(courseId);
      }
    });
  }

  /// 加载Mock数据
  void _loadMockData() {
    _chapters = CourseApplicationMockData.getCourseOutline();
    _materials = CourseApplicationMockData.getCourseMaterials();
  }

  /// 加载已有课程数据（用于重新提交审核）
  void _loadExistingCourseData(String courseId) {
    CourseApplicationMockData.getExistingCourse(courseId);
    // TODO: 更新表单数据
    // 由于表单组件已经初始化，这里需要通过方法更新表单数据
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

  /// 构建基本信息标签页
  Widget _buildBasicInfoTab() {
    return BasicInfoForm(
      categories: CourseApplicationMockData.categories,
      difficulties: CourseApplicationMockData.difficulties,
      statuses: CourseApplicationMockData.statuses,
      onFormChanged: () {
        // 表单变化回调
      },
    );
  }

  /// 构建课程大纲标签页
  Widget _buildCourseOutlineTab() {
    return CourseOutlineTab(
      chapters: _chapters,
      onChaptersChanged: (chapters) {
        setState(() {
          _chapters = chapters;
        });
      },
      onBatchUpload: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('批量上传功能开发中...')),
        );
      },
    );
  }

  /// 构建课程资料标签页
  Widget _buildCourseMaterialsTab() {
    return CourseMaterialsTab(
      materials: _materials,
      onMaterialsChanged: (materials) {
        setState(() {
          _materials = materials;
        });
      },
      onUpload: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('上传资料功能开发中...')),
        );
      },
    );
  }

  /// 构建价格设置标签页
  Widget _buildPriceSettingsTab() {
    return PriceSettingsForm(
      onFormChanged: () {
        // 表单变化回调
      },
    );
  }

  /// 提交课程审核
  void _submitCourse() {
    // TODO: 收集所有表单数据并提交
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('课程已提交审核，请等待审核结果'),
        backgroundColor: Colors.green,
      ),
    );
  }
}
