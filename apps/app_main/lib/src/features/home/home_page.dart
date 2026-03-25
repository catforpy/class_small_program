library;

import 'package:flutter/material.dart';
import 'package:ui_components/ui_components.dart';
import 'package:go_router/go_router.dart';

/// 首页
///
/// ## 新架构
/// - 轮播图：推荐视频/课程
/// - 行业分类：横向滚动的一级分类（编程开发、心理学等）
/// - 推荐课程列表
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  /// 轮播图当前页索引
  int _carouselCurrentIndex = 0;

  /// 课程简介滚动控制器
  late ScrollController _descriptionScrollController;

  /// 广告栏当前索引
  int _adCurrentIndex = 0;

  /// 广告栏滚动控制器
  late ScrollController _adScrollController;

  /// 轮播图数据
  final List<Map<String, dynamic>> _carouselItems = [
    {
      'imageUrl': 'https://picsum.photos/800/400?random=1',
      'title': 'Python 全栈开发实战',
      'subtitle': '从零开始掌握全栈开发',
    },
    {
      'imageUrl': 'https://picsum.photos/800/400?random=2',
      'title': '心理咨询师认证课程',
      'subtitle': '专业导师一对一指导',
    },
    {
      'imageUrl': 'https://picsum.photos/800/400?random=3',
      'title': 'AI 绘画全能班',
      'subtitle': 'Midjourney + Stable Diffusion',
    },
  ];

  /// 广告数据
  final List<Map<String, dynamic>> _ads = [
    {
      'title': '限时优惠',
      'content': '新用户首单立减50元，限时抢购中！',
      'color': 0xFFFF6B6B,
    },
    {
      'title': '热门推荐',
      'content': 'Python全栈开发课程正在热销，超过1万人已学习',
      'color': 0xFF4ECDC4,
    },
    {
      'title': '系统通知',
      'content': '会员中心全新升级，更多权益等你来体验',
      'color': 0xFF95E1D3,
    },
    {
      'title': '新课上线',
      'content': 'AI绘画实战课程震撼上线，早鸟价优惠中',
      'color': 0xFFDDA0DD,
    },
  ];

  /// 一级行业分类数据（与分类页面保持一致）
  static const List<Map<String, dynamic>> _primaryCategories = [
    {
      'id': '1',
      'name': '编程开发',
      'icon': '💻',
    },
    {
      'id': '2',
      'name': '心理学',
      'icon': '🧠',
    },
    {
      'id': '3',
      'name': '家庭教育',
      'icon': '👨‍👩‍👧‍👦',
    },
    {
      'id': '4',
      'name': 'AI应用',
      'icon': '🤖',
    },
    {
      'id': '5',
      'name': '视频设计',
      'icon': '🎬',
    },
    {
      'id': '6',
      'name': '数据分析',
      'icon': '📊',
    },
    {
      'id': '7',
      'name': '项目管理',
      'icon': '📋',
    },
  ];

  @override
  void initState() {
    super.initState();
    _descriptionScrollController = ScrollController();
    _adScrollController = ScrollController();
    _startAutoScroll();
    _startAdRotation();
  }

  @override
  void dispose() {
    _descriptionScrollController.dispose();
    _adScrollController.dispose();
    super.dispose();
  }

  /// 开始自动滚动课程简介
  void _startAutoScroll() {
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        _scrollDescription();
      }
    });
  }

  /// 开始广告栏自动轮转
  void _startAdRotation() {
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        _rotateAd();
      }
    });
  }

  /// 轮转广告栏
  void _rotateAd() {
    if (!mounted) return;

    setState(() {
      _adCurrentIndex = (_adCurrentIndex + 1) % _ads.length;
    });

    // 每3秒切换到下一条广告
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        _rotateAd();
      }
    });
  }

  /// 滚动课程简介
  void _scrollDescription() {
    if (!mounted) return;

    final maxScroll = _descriptionScrollController.position.maxScrollExtent;
    if (maxScroll > 0) {
      _descriptionScrollController.animateTo(
        maxScroll,
        duration: const Duration(seconds: 10),
        curve: Curves.linear,
      ).then((_) {
        if (mounted) {
          Future.delayed(const Duration(seconds: 2), () {
            if (mounted) {
              _descriptionScrollController.animateTo(
                0,
                duration: const Duration(seconds: 1),
                curve: Curves.easeInOut,
              ).then((_) {
                if (mounted) {
                  Future.delayed(const Duration(seconds: 2), () {
                    _scrollDescription();
                  });
                }
              });
            }
          });
        }
      });
    } else {
      // 如果内容不需要滚动，稍后重试
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          _scrollDescription();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: Column(
        children: [
          // 顶部：轮播图 + 分类（不占用固定空间）
          _buildTopSection(),
          // 推荐课程卡片（填满剩余空间，从分类到底部导航栏）
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: _buildRecommendList(),
            ),
          ),
        ],
      ),
    );
  }

  /// 构建顶部部分（轮播图 + 广告栏 + 分类）
  Widget _buildTopSection() {
    return Column(
      children: [
        // 轮播图
        _buildCarousel(),
        const SizedBox(height: 12),
        // 广告栏（横向滑动）
        _buildAdBanner(),
        const SizedBox(height: 12),
        // 行业分类（横向滚动）
        _buildPrimaryCategories(),
        const SizedBox(height: 8),
      ],
    );
  }

  /// 构建广告栏（文字轮转滚动）
  Widget _buildAdBanner() {
    if (_ads.isEmpty) return const SizedBox.shrink();

    final currentAd = _ads[_adCurrentIndex];

    return Container(
      height: 40,
      margin: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Color(currentAd['color'] as int).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Color(currentAd['color'] as int).withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, -0.3),
                  end: Offset.zero,
                ).animate(CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeOut,
                )),
                child: child,
              ),
            );
          },
          child: Container(
            key: ValueKey(_adCurrentIndex),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                // 标签
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: Color(currentAd['color'] as int),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    currentAd['title'] as String,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                // 广告内容
                Expanded(
                  child: Text(
                    currentAd['content'] as String,
                    style: TextStyle(
                      color: Color(currentAd['color'] as int),
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                // 右侧喇叭图标
                Icon(
                  Icons.campaign,
                  color: Color(currentAd['color'] as int),
                  size: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// 构建轮播图
  Widget _buildCarousel() {
    return SizedBox(
      height: 180,
      child: PageView.builder(
        onPageChanged: (index) {
          setState(() {
            _carouselCurrentIndex = index % _carouselItems.length;
          });
        },
        itemCount: _carouselItems.length,
        itemBuilder: (context, index) {
          final item = _carouselItems[index];
          return GestureDetector(
            onTap: () {
              print('点击轮播图：${item['title']}');
            },
            child: Stack(
              fit: StackFit.expand,
              children: [
                // 轮播图图片
                ClipRRect(
                  borderRadius: BorderRadius.zero,
                  child: Image.network(
                    item['imageUrl'] as String,
                    fit: BoxFit.cover,
                  ),
                ),
                // 渐变遮罩
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withValues(alpha: 0.7),
                      ],
                    ),
                  ),
                ),
                // 文字内容
                Positioned(
                  bottom: 16,
                  left: 16,
                  right: 16,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['title'] as String,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item['subtitle'] as String,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.white70,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  /// 构建一级行业分类（横向滚动）
  Widget _buildPrimaryCategories() {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(vertical: 12),
      color: Colors.white,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: _primaryCategories.length,
        itemBuilder: (context, index) {
          final category = _primaryCategories[index];
          return Padding(
            padding: const EdgeInsets.only(right: 24),
            child: GestureDetector(
              onTap: () {
                // 跳转到分类页面，并选中对应的一级分类
                context.push('/category', extra: {
                  'selectedPrimaryIndex': index,
                });
              },
              child: Text(
                category['name'] as String,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          );
        },
      ),
    );
  }

  /// 构建推荐课程卡片（竖向填满）
  Widget _buildRecommendList() {
    final course = {
      'id': '1',
      'imageUrl': 'https://picsum.photos/600/800?random=101',
      'recommenderAvatar': 'https://picsum.photos/100/100?random=201',
      'recommenderName': '李明',
      'title': 'Python 全栈开发实战套课',
      'description': '从零开始掌握 Python 全栈开发，包含前端、后端、数据库等核心技术，共32节精品课程。本课程适合零基础学员，从Python基础语法讲起，逐步深入到Web开发、数据分析、人工智能等领域。通过5个实战项目，让你快速掌握全栈开发技能。课程内容包括Python基础、Flask/Django框架、前端技术、数据库设计、RESTful API开发、部署上线等完整技能体系。',
      'price': 19900,
      'originalPrice': 29900,
      'studyCount': 12345,
      'rating': 4.8,
      'subCourses': [
        {'title': 'Python 基础语法', 'duration': '12课时'},
        {'title': 'Web 前端开发', 'duration': '8课时'},
        {'title': '后端框架 Django', 'duration': '10课时'},
        {'title': '数据库操作', 'duration': '6课时'},
        {'title': '项目实战', 'duration': '16课时'},
      ],
    };

    return GestureDetector(
      onTap: () {
        // 跳转到课程详情页
        context.push('/course2/${course['id']}');
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // 背景图片（填满整个卡片）
            Image.network(
              course['imageUrl'] as String,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                color: Colors.grey[300],
                child: const Icon(Icons.image, size: 48),
              ),
            ),

            // 顶部渐变蒙版
            Positioned.fill(
              top: 0,
              child: Container(
                height: 150,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                    Colors.black.withValues(alpha: 0.75),
                    Colors.black.withValues(alpha: 0.4),
                    Colors.transparent,
                  ],
                  ),
                ),
              ),
            ),

            // 底部渐变蒙版
            Positioned.fill(
              bottom: 0,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withValues(alpha: 0.6),
                      Colors.black.withValues(alpha: 0.85),
                    ],
                  ),
                ),
              ),
            ),

            // 顶部：课程名字 + 推荐人信息
            Positioned(
              top: 16,
              left: 16,
              right: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 课程名字
                  Text(
                    course['title'] as String,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          color: Colors.black45,
                          offset: Offset(0, 1),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  // 推荐人信息（头像 + 名字 + 推荐）
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 10,
                        backgroundImage: NetworkImage(
                          course['recommenderAvatar'] as String? ?? 'https://i.pravatar.cc/100?img=1',
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        course['recommenderName'] as String,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          shadows: [
                            Shadow(
                              color: Colors.black45,
                              offset: Offset(0, 1),
                              blurRadius: 3,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFF4757).withValues(alpha: 0.9),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text(
                          '推荐',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // 中部：课程简介（左侧）+ 子课程列表（右侧）
            Positioned(
              top: 130,
              bottom: 80,
              left: 16,
              right: 16,
              child: Row(
                children: [
                  // 左侧：课程简介
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 套课标签
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFF4757),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Text(
                            '精选套课',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        // 课程简介（自动滚动）
                        Expanded(
                          child: SingleChildScrollView(
                            controller: _descriptionScrollController,
                            child: Text(
                              course['description'] as String,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                height: 1.5,
                                shadows: [
                                  Shadow(
                                    color: Colors.black45,
                                    offset: Offset(0, 1),
                                    blurRadius: 4,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  // 右侧：子课程列表
                  Expanded(
                    flex: 2,
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.25),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.list,
                                color: Colors.white,
                                size: 16,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '课程目录',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  shadows: [
                                    Shadow(
                                      color: Colors.black45,
                                      offset: Offset(0, 1),
                                      blurRadius: 3,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Expanded(
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: (course['subCourses'] as List).length,
                              itemBuilder: (context, index) {
                                final subCourse = (course['subCourses'] as List)[index] as Map<String, dynamic>;
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 6,
                                        height: 6,
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              subCourse['title'] as String,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 11,
                                                fontWeight: FontWeight.w500,
                                                shadows: [
                                                  Shadow(
                                                    color: Colors.black45,
                                                    offset: Offset(0, 1),
                                                    blurRadius: 2,
                                                  ),
                                                ],
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Text(
                                              subCourse['duration'] as String,
                                              style: TextStyle(
                                                color: Colors.white.withValues(alpha: 0.8),
                                                fontSize: 10,
                                                shadows: [
                                                  Shadow(
                                                    color: Colors.black45,
                                                    offset: Offset(0, 1),
                                                    blurRadius: 2,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // 底部：价格、评分、学习人数
            Positioned(
              bottom: 16,
              left: 16,
              right: 16,
              child: Row(
                children: [
                  // 价格
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '¥' + (((course['price'] as int) ~/ 100).toString()),
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          height: 1.0,
                          shadows: [
                            Shadow(
                              color: Colors.black45,
                              offset: Offset(0, 1),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                      ),
                      if (course['originalPrice'] != null) ...[
                        const SizedBox(width: 8),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: Text(
                            '¥' + (((course['originalPrice'] as int) ~/ 100).toString()),
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white.withValues(alpha: 0.7),
                              decoration: TextDecoration.lineThrough,
                              height: 1.0,
                              shadows: [
                                Shadow(
                                  color: Colors.black45,
                                  offset: Offset(0, 1),
                                  blurRadius: 3,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const Spacer(),
                  // 评分
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.3),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 14,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          (course['rating'] as num).toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            shadows: [
                              Shadow(
                                color: Colors.black45,
                                offset: Offset(0, 1),
                                blurRadius: 3,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  // 学习人数
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.3),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.people,
                          color: Colors.white,
                          size: 14,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          (((course['studyCount'] as int) / 1000).toStringAsFixed(1)) + 'k',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            shadows: [
                              Shadow(
                                color: Colors.black45,
                                offset: Offset(0, 1),
                                blurRadius: 3,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
