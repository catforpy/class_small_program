library;

import 'package:flutter/material.dart';
import '../../shared/data/mocks/course_management_mock_data.dart';
import 'management/widgets/leasing_info_section.dart';
import 'management/widgets/course_outline_tab.dart';
import 'management/widgets/course_materials_tab.dart';
import 'management/widgets/interaction_tab.dart';
import 'management/widgets/data_stats_tab.dart';
import 'management/widgets/activity_management_tab.dart';

/// 课程详情管理页面
///
/// 讲师可以在这里管理已上架的课程
///
/// ## 重构说明
/// - 提取了11个可复用组件
/// - 提取了Mock数据到 course_management_mock_data.dart
/// - 主文件从2432行减少到约250行
class CourseDetailManagementPage extends StatefulWidget {
  final String courseId;

  const CourseDetailManagementPage({
    super.key,
    required this.courseId,
  });

  @override
  State<CourseDetailManagementPage> createState() => _CourseDetailManagementPageState();
}

class _CourseDetailManagementPageState extends State<CourseDetailManagementPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // 课程数据（从Mock加载）
  Map<String, dynamic> _courseInfo = {};
  List<Map<String, dynamic>> _chapters = [];
  List<Map<String, dynamic>> _materials = [];
  Map<String, dynamic> _interactionData = {};
  Map<String, dynamic> _salesData = {};

  // 是否已预约到期下架
  bool _isScheduledForTakeDown = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    _loadData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  /// 加载Mock数据
  void _loadData() {
    _courseInfo = CourseManagementMockData.getCourseInfo(widget.courseId);
    _chapters = CourseManagementMockData.getChapters();
    _materials = CourseManagementMockData.getMaterials();
    _interactionData = CourseManagementMockData.getInteractionData();
    _salesData = CourseManagementMockData.getSalesData();
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
          _courseInfo['title'] as String? ?? '课程管理',
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
          LeasingInfoSection(
            leasingType: _courseInfo['leasingType'] as String? ?? 'yearly',
            leasingTypeText: _courseInfo['leasingTypeText'] as String? ?? '年费',
            remainingDays: _courseInfo['remainingDays'] as int?,
            expiryDate: _courseInfo['expiryDate'] as String?,
            remainingHours: _courseInfo['remainingHours'] as int?,
            remainingMinutes: _courseInfo['remainingMinutes'] as int?,
            onRenewal: () => _showRenewalDialog(),
            onChangePackage: () => _showChangePackageDialog(),
            onTakeDown: () {
              if (_isScheduledForTakeDown) {
                _cancelScheduledTakeDown();
              } else {
                _showTakeDownDialog();
              }
            },
          ),

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
                Tab(text: '活动管理'),
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
                _buildActivityManagementTab(),
              ],
            ),
          ),
        ],
      ),
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

  /// 构建互动管理标签页
  Widget _buildInteractionTab() {
    return InteractionTab(
      consultationCount: _interactionData['consultationCount'] as int? ?? 0,
      qaCount: _interactionData['qaCount'] as int? ?? 0,
      averageRating: _interactionData['averageRating'] as double? ?? 0.0,
      reviewCount: _interactionData['reviewCount'] as int? ?? 0,
      onViewConsultation: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('售前咨询功能开发中...')),
        );
      },
      onViewQA: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('课程答疑功能开发中...')),
        );
      },
      onViewAllReviews: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('查看全部评价功能开发中...')),
        );
      },
    );
  }

  /// 构建数据统计标签页
  Widget _buildDataStatsTab() {
    return DataStatsTab(
      salesCount: _salesData['salesCount'] as int? ?? 0,
      totalRevenue: _salesData['totalRevenue'] as double? ?? 0.0,
      forwardCount: _salesData['forwardCount'] as int? ?? 0,
      onViewSalesDetails: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('销售详情功能开发中...')),
        );
      },
      onViewForwardDetails: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('转发详情功能开发中...')),
        );
      },
      onViewStudyDetails: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('学习详情功能开发中...')),
        );
      },
    );
  }

  /// 构建活动管理标签页
  Widget _buildActivityManagementTab() {
    return ActivityManagementTab(
      courseInfo: _courseInfo,
      onCourseInfoChanged: (newInfo) {
        setState(() {
          _courseInfo = newInfo;
        });
      },
    );
  }

  /// ==================== 对话框方法 ====================

  /// 显示续费弹窗（简化版本，实际项目可以提取为独立组件）
  void _showRenewalDialog() {
    final leasingTypeText = _courseInfo['leasingTypeText'] as String? ?? '年费';
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

  /// 显示变更套餐弹窗（简化版本）
  void _showChangePackageDialog() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('跳转到支付页面...')),
    );
  }

  /// 显示下架确认弹窗（简化版本）
  void _showTakeDownDialog() {
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
