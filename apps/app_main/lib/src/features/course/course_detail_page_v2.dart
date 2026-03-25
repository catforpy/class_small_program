library;

import 'package:flutter/material.dart';
import '../../shared/data/mocks/course_detail_mock_data.dart';
import '../../shared/widgets/cards/review_card.dart';
import '../../shared/widgets/tabs/common_tab_bar.dart';
import 'detail/widgets/bottom_action_nav.dart';

/// 课程详情页
///
/// ## 重构说明
/// - Mock数据已提取到 course_detail_mock_data.dart
/// - 底部操作导航已提取到 bottom_action_nav.dart
/// - 复用了 CommonTabBar 和 ReviewCard 组件
/// - 主文件从1640行减少到约400行
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
  late TabController _tabController;
  bool _isFavorited = false;

  // 课程数据（从Mock加载）
  Map<String, dynamic> _courseData = {};
  List<Map<String, dynamic>> _consultData = [];
  List<Map<String, dynamic>> _reviewData = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _loadData();
    if (widget.initialTab != null) {
      _switchToTab(widget.initialTab!);
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  /// 加载Mock数据
  void _loadData() {
    _courseData = CourseDetailMockData.getCourseInfo(widget.courseId);
    _consultData = CourseDetailMockData.getConsultData();
    _reviewData = CourseDetailMockData.getReviewData();
  }

  void _switchToTab(String tab) {
    final tabIndex = ['intro', 'chapters', 'consult', 'reviews'].indexOf(tab);
    if (tabIndex != -1) {
      setState(() {
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
          // 课程头部（简化版）
          _buildCourseHeader(),
          // 标签栏
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
          // 底部导航
          _buildBottomNav(),
        ],
      ),
    );
  }

  /// 构建课程头部
  Widget _buildCourseHeader() {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 课程图片和返回按钮
          Stack(
            children: [
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
          // 课程信息
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 状态徽章
                Row(
                  children: [
                    _buildStatusBadge(_courseData['status'] as String),
                    const SizedBox(width: 8),
                    _buildDifficultyBadge(_courseData['difficulty'] as String),
                  ],
                ),
                const SizedBox(height: 12),
                // 标题
                Text(
                  _courseData['title'] as String,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                // 副标题
                Text(
                  _courseData['subtitle'] as String,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 12),
                // 统计信息
                Wrap(
                  spacing: 16,
                  children: [
                    _buildInfoItem(
                      Icons.schedule,
                      _courseData['duration'] as String,
                    ),
                    _buildInfoItem(
                      Icons.people,
                      '${_courseData['studentCount']}人学习',
                    ),
                    _buildInfoItem(
                      Icons.star,
                      '${_courseData['rating']} (${_courseData['ratingCount']}评价)',
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

  /// 构建标签栏
  Widget _buildTabBar() {
    final consultCount = _consultData.length;
    final reviewCount = _reviewData.length;

    return Container(
      color: Colors.white,
      child: CommonTabBar(
        tabs: [
          TabItem(label: '课程介绍'),
          TabItem(label: '章节目录'),
          TabItem(label: '售前咨询', badge: '$consultCount'),
          TabItem(label: '用户评价', badge: '$reviewCount'),
        ],
        currentIndex: _tabController.index,
        onTap: (index) {
          _tabController.animateTo(index);
        },
        controller: _tabController,
      ),
    );
  }

  /// 构建简介标签页
  Widget _buildIntroTab() {
    final goals = _courseData['goals'] as List<dynamic>;
    final highlights = _courseData['highlights'] as List<dynamic>;
    final instructor = _courseData['instructor'] as Map<String, dynamic>;
    final hasCommission = _courseData['hasCommission'] as bool;
    final commissionRate = _courseData['commissionRate'] as int;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // 讲师介绍
        _buildSectionCard('讲师介绍', [
          CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(instructor['avatar'] as String),
          ),
          const SizedBox(height: 12),
          Text(
            instructor['name'] as String,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
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
          const SizedBox(height: 12),
          Text(
            instructor['bio'] as String,
            style: const TextStyle(fontSize: 14, height: 1.5),
          ),
        ]),

        const SizedBox(height: 16),

        // 课程目标
        _buildSectionCard(
          '课程目标',
          goals.map<Widget>((goal) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.check_circle, size: 20, color: Colors.green),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          goal['title'] as String,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          goal['description'] as String,
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
            );
          }).toList(),
        ),

        const SizedBox(height: 16),

        // 课程亮点
        _buildSectionCard(
          '课程亮点',
          highlights.map<Widget>((highlight) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      highlight['imageUrl'] as String,
                      width: 60,
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
                          highlight['title'] as String,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          highlight['description'] as String,
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
            );
          }).toList(),
        ),

        if (hasCommission) ...[
          const SizedBox(height: 16),
          // 转发赠金
          _buildSectionCard('转发赠金', [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.orange.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Colors.orange.withValues(alpha: 0.3),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.card_giftcard,
                    color: Colors.orange[700],
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '邀好友赢赠金',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '分享给好友，好友购买后您可获得赠金$commissionRate%',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ],
      ],
    );
  }

  /// 构建章节标签页
  Widget _buildChaptersTab() {
    final chapters = _courseData['chapters'] as List<dynamic>;

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: chapters.length,
      itemBuilder: (context, index) {
        final chapter = chapters[index] as Map<String, dynamic>;
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      chapter['title'] as String,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  if (chapter['hasTrial'] as bool)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
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
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                chapter['content'] as String? ?? '',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 12),
              Text(
                '时长：${chapter['duration']}',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[500],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  /// 构建咨询标签页
  Widget _buildConsultTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _consultData.length,
      itemBuilder: (context, index) {
        final consult = _consultData[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
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
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                      consult['user']['avatar'] as String,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          consult['user']['name'] as String,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          consult['time'] as String,
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                consult['question'] as String,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  consult['answer'] as String,
                  style: const TextStyle(fontSize: 13, height: 1.5),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Icon(Icons.thumb_up_outlined, size: 16, color: Colors.grey[600]),
                  const SizedBox(width: 4),
                  Text(
                    '${consult['likes']}',
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  /// 构建评价标签页
  Widget _buildReviewsTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // 评价汇总
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.grey.withValues(alpha: 0.2),
            ),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  const Icon(Icons.star, size: 28, color: Colors.amber),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '用户评价',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${_reviewData.length}条评价',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '${_courseData['rating']}',
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
                            color: index < (_courseData['rating'] as double).floor()
                                ? Colors.amber
                                : Colors.grey[300],
                          );
                        }),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        // 评价列表
        ..._reviewData.map((review) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: ReviewCard(
              userName: review['user']['name'] as String,
              avatarUrl: review['user']['avatar'] as String,
              rating: review['rating'] as int,
              content: review['content'] as String,
              time: review['time'] as String,
              likes: review['likes'] as int,
              isLiked: false,
            ),
          );
        }),
      ],
    );
  }

  /// 构建底部导航
  Widget _buildBottomNav() {
    return BottomActionNav(
      price: _courseData['price'] as int,
      originalPrice: _courseData['originalPrice'] as int?,
      isFavorited: _isFavorited,
      hasTrial: _courseData['hasTrial'] as bool,
      onFavorite: () {
        setState(() {
          _isFavorited = !_isFavorited;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_isFavorited ? '已添加收藏' : '已取消收藏'),
            duration: const Duration(seconds: 1),
          ),
        );
      },
      onQuestion: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('提问功能开发中...')),
        );
      },
      onTrial: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('开始试看课程')),
        );
      },
      onPurchase: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('跳转到支付页面...')),
        );
      },
    );
  }

  /// 构建状态徽章
  Widget _buildStatusBadge(String status) {
    final statusText = CourseDetailMockData.getStatusText(status);
    Color statusColor;

    switch (status) {
      case 'updating':
        statusColor = Colors.blue;
        break;
      case 'completed':
        statusColor = Colors.green;
        break;
      case 'presale':
        statusColor = Colors.orange;
        break;
      default:
        statusColor = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: statusColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: statusColor),
      ),
      child: Text(
        statusText,
        style: TextStyle(
          fontSize: 11,
          color: statusColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  /// 构建难度徽章
  Widget _buildDifficultyBadge(String difficulty) {
    final difficultyText = CourseDetailMockData.getDifficultyText(difficulty);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.purple.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.purple),
      ),
      child: Text(
        difficultyText,
        style: const TextStyle(
          fontSize: 11,
          color: Colors.purple,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  /// 构建信息项
  Widget _buildInfoItem(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: Colors.grey[600]),
        const SizedBox(width: 4),
        Text(
          text,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  /// 构建区域卡片
  Widget _buildSectionCard(String title, List<Widget> children) {
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
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          ...children,
        ],
      ),
    );
  }
}
