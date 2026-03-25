library;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../shared/widgets/cards/product_card.dart';

/// 分类页面
///
/// ## 结构
/// - 一级标签（行业分类）：横向滚动
/// - 二级标签（细分类目）：横向滚动
/// - 课程列表
class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  /// 当前选中的一级分类索引
  int _selectedPrimaryIndex = 0;

  /// 当前选中的二级分类索引
  int _selectedSecondaryIndex = 0;

  /// 是否已经初始化
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // 从路由参数中获取初始选中的一级分类索引（只执行一次）
    if (!_initialized) {
      _initializeFromRoute();
      _initialized = true;
    }
  }

  /// 从路由参数初始化选中状态
  void _initializeFromRoute() {
    try {
      final state = GoRouterState.of(context);
      final extra = state.extra as Map<String, dynamic>?;
      if (extra != null && extra['selectedPrimaryIndex'] is int) {
        final initialIndex = extra['selectedPrimaryIndex'] as int;
        if (initialIndex >= 0 && initialIndex < _primaryCategories.length) {
          setState(() {
            _selectedPrimaryIndex = initialIndex;
            _selectedSecondaryIndex = 0; // 重置二级分类索引
          });
        }
      }
    } catch (e) {
      // 如果获取路由参数失败，使用默认值
      print('获取路由参数失败: $e');
    }
  }

  /// 一级分类列表（行业分类）
  static const List<Map<String, dynamic>> _primaryCategories = [
    {
      'id': '1',
      'name': '编程开发',
      'icon': '💻',
      'subCategories': ['Python', 'Java', 'JavaScript', 'Flutter', 'Go', 'C++'],
    },
    {
      'id': '2',
      'name': '心理学',
      'icon': '🧠',
      'subCategories': ['认知心理学', '社会心理学', '发展心理学', '临床心理学', '咨询心理学'],
    },
    {
      'id': '3',
      'name': '家庭教育',
      'icon': '👨‍👩‍👧‍👦',
      'subCategories': ['亲子关系', '儿童心理', '青少年教育', '家庭沟通', '学习指导'],
    },
    {
      'id': '4',
      'name': 'AI应用',
      'icon': '🤖',
      'subCategories': ['ChatGPT', 'Midjourney', 'Stable Diffusion', 'Prompt', 'AI工具'],
    },
    {
      'id': '5',
      'name': '视频设计',
      'icon': '🎬',
      'subCategories': ['Premiere', '剪映', '特效制作', '视频剪辑', '色彩搭配'],
    },
    {
      'id': '6',
      'name': '数据分析',
      'icon': '📊',
      'subCategories': ['Excel', 'SQL', 'Python数据分析', 'Tableau', 'Power BI'],
    },
    {
      'id': '7',
      'name': '项目管理',
      'icon': '📋',
      'subCategories': ['PMP', '敏捷开发', 'Scrum', '风险管理', '团队协作'],
    },
  ];

  /// 获取当前选中的一级分类
  Map<String, dynamic> get _selectedPrimaryCategory => _primaryCategories[_selectedPrimaryIndex];

  /// 获取当前选中的二级分类列表
  List<String> get _secondaryCategories => _selectedPrimaryCategory['subCategories'] as List<String>;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          '分类',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ),
      body: Column(
        children: [
          // 一级分类（行业分类）
          _buildPrimaryCategories(),

          const SizedBox(height: 8),

          // 二级分类（细分类目）
          _buildSecondaryCategories(),

          const SizedBox(height: 8),

          // 课程列表
          Expanded(
            child: _buildCourseList(),
          ),
        ],
      ),
    );
  }

  /// 构建一级分类标签（行业分类）
  Widget _buildPrimaryCategories() {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _primaryCategories.length,
        itemBuilder: (context, index) {
          final category = _primaryCategories[index];
          final isSelected = index == _selectedPrimaryIndex;

          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedPrimaryIndex = index;
                  _selectedSecondaryIndex = 0; // 切换一级分类时，重置二级分类
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.red : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected ? Colors.red : Colors.grey.withValues(alpha: 0.3),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      category['icon'] as String,
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      category['name'] as String,
                      style: TextStyle(
                        fontSize: 15,
                        color: isSelected ? Colors.white : Colors.black87,
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  /// 构建二级分类标签（细分类目）
  Widget _buildSecondaryCategories() {
    return SizedBox(
      height: 36,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _secondaryCategories.length,
        itemBuilder: (context, index) {
          final subCategory = _secondaryCategories[index];
          final isSelected = index == _selectedSecondaryIndex;

          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedSecondaryIndex = index;
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.red.withValues(alpha: 0.1) : Colors.transparent,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isSelected ? Colors.red : Colors.grey.withValues(alpha: 0.3),
                  ),
                ),
                child: Text(
                  subCategory,
                  style: TextStyle(
                    fontSize: 14,
                    color: isSelected ? Colors.red : Colors.black87,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  /// 构建课程列表
  Widget _buildCourseList() {
    final courses = [
      {
        'id': '1',
        'imageUrl': 'https://picsum.photos/200/150?random=201',
        'title': '${_secondaryCategories[_selectedSecondaryIndex]} 入门到精通',
        'subtitle': '系统学习${_primaryCategories[_selectedPrimaryIndex]['name']}',
        'price': 19900,
        'originalPrice': 29900,
        'studyCount': 12345,
        'hasCommission': true,
        'commissionRate': 10,
      },
      {
        'id': '2',
        'imageUrl': 'https://picsum.photos/200/150?random=202',
        'title': '${_primaryCategories[_selectedPrimaryIndex]['name']} 实战项目',
        'subtitle': '${_secondaryCategories[_selectedSecondaryIndex]} 应用案例',
        'price': 15900,
        'originalPrice': null,
        'studyCount': 5678,
        'hasCommission': false,
        'commissionRate': 0,
      },
      {
        'id': '3',
        'imageUrl': 'https://picsum.photos/200/150?random=203',
        'title': '${_secondaryCategories[_selectedSecondaryIndex]} 进阶教程',
        'subtitle': '深入理解核心概念',
        'price': 24900,
        'originalPrice': 34900,
        'studyCount': 8901,
        'hasCommission': true,
        'commissionRate': 15,
      },
      {
        'id': '4',
        'imageUrl': 'https://picsum.photos/200/150?random=204',
        'title': '${_primaryCategories[_selectedPrimaryIndex]['name']} 快速上手',
        'subtitle': '零基础友好',
        'price': 9900,
        'originalPrice': 14900,
        'studyCount': 4321,
        'hasCommission': true,
        'commissionRate': 8,
      },
    ];

    // 过滤出有提成的课程
    final commissionCourses = courses.where((c) => c['hasCommission'] as bool).toList();

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      children: [
        // 分享提成标签栏
        if (commissionCourses.isNotEmpty)
          Container(
            margin: const EdgeInsets.only(bottom: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.card_giftcard,
                      size: 18,
                      color: Colors.orange[700],
                    ),
                    const SizedBox(width: 6),
                    Text(
                      '邀好友赚赠金',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                // 可提成课程列表
                SizedBox(
                  height: 80,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: commissionCourses.length,
                    itemBuilder: (context, index) {
                      final course = commissionCourses[index];
                      return GestureDetector(
                        onTap: () {
                          // 跳转到课程详情页
                          context.push('/course2/${course['id']}');
                        },
                        child: Container(
                          width: 140,
                          margin: const EdgeInsets.only(right: 8),
                          decoration: BoxDecoration(
                            color: Colors.orange.withValues(alpha: 0.05),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Colors.orange.withValues(alpha: 0.3),
                            ),
                          ),
                          child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    course['title'] as String,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black87,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '赠金${course['commissionRate']}%',
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.orange[700],
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // 提成标签
                            Positioned(
                              top: 4,
                              right: 4,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                                decoration: BoxDecoration(
                                  color: Colors.orange[700],
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  '赚',
                                  style: TextStyle(
                                    fontSize: 9,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                ),
              ],
            ),
          ),

        // 课程列表
        ...courses.map((course) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: ProductCard(
              imageUrl: course['imageUrl'] as String,
              title: course['title'] as String,
              subtitle: course['subtitle'] as String,
              price: course['price'] as int,
              originalPrice: course['originalPrice'] as int?,
              studyCount: course['studyCount'] as int,
              hasCommission: course['hasCommission'] as bool,
              commissionRate: course['commissionRate'] as int?,
              onTap: () {
                context.push('/course2/${course['id']}');
              },
            ),
          );
        }),
      ],
    );
  }
}
