library;

/// 首页假数据
class HomeMockData {
  /// 首页标签列表
  static const List<String> homeTabs = ['推荐', '关注', '热门', '视频', '话题', '活动'];

  /// 搜索提示词组
  static const List<List<String>> searchSuggestions = [
    ['Python入门', 'Python爬虫', 'Python数据分析', 'Python Web'],
    ['Java基础', 'Java并发', 'JVM调优', 'Spring Boot'],
    ['Flutter教程', 'Dart语言', 'Flutter实战', '跨平台开发'],
    ['AI绘画', 'ChatGPT', '机器学习', '深度学习'],
  ];

  /// 热门内容列表
  static List<Map<String, dynamic>> getHotContentList(int count) {
    return List.generate(count, (index) {
      return {
        'id': 'hot_$index',
        'title': '热门内容标题 ${index + 1}',
        'subtitle': '这是热门内容的副标题描述',
        'imageUrl': 'https://picsum.photos/200/150?random=${100 + index}',
        'viewCount': 1000 + index * 500,
        'likeCount': 500 + index * 200,
        'author': '作者${index + 1}',
        'tags': index % 2 == 0 ? ['热门', '推荐'] : ['精选'],
      };
    });
  }

  /// 推荐商品/课程列表
  static List<Map<String, dynamic>> getRecommendedProducts(int count) {
    final titles = [
      'Python全栈开发实战',
      'Java从入门到精通',
      'Flutter移动应用开发',
      'AI人工智能实战',
      '数据分析与可视化',
    ];

    final subtitles = [
      '系统学习Python后端开发',
      '零基础学Java编程',
      '跨平台应用开发实战',
      '机器学习深度学习',
      'Excel SQL Python综合应用',
    ];

    return List.generate(count, (index) {
      final hasCommission = index % 2 == 0;
      return {
        'id': 'product_${index + 1}',
        'title': titles[index % titles.length],
        'subtitle': subtitles[index % subtitles.length],
        'imageUrl': 'https://picsum.photos/200/150?random=${200 + index}',
        'price': 19900 - index * 1000,
        'originalPrice': index % 3 == 0 ? 29900 : null,
        'studyCount': 12345 - index * 1000,
        'hasCommission': hasCommission,
        'commissionRate': hasCommission ? 10 + index * 2 : 0,
        'rating': 4.5 + (index % 5) * 0.1,
      };
    });
  }

  /// 个人中心菜单
  static const List<Map<String, dynamic>> profileMenuItems = [
    {
      'icon': Icons.school,
      'title': '我租赁的课架',
      'subtitle': '管理已租赁的课程',
      'route': '/course-management',
    },
    {
      'icon': Icons.favorite,
      'title': '我的收藏',
      'subtitle': '收藏的课程和内容',
      'route': '/favorites',
    },
    {
      'icon': Icons.history,
      'title': '学习记录',
      'subtitle': '查看学习历史',
      'route': '/study-history',
    },
    {
      'icon': Icons.card_giftcard,
      'title': '我的赠金',
      'subtitle': '查看赠金收益',
      'route': '/commission',
    },
    {
      'icon': Icons.settings,
      'title': '设置',
      'subtitle': '账号与资质管理',
      'route': '/settings',
    },
    {
      'icon': Icons.help_outline,
      'title': '帮助与反馈',
      'subtitle': '常见问题和建议',
      'route': '/help',
    },
  ];
}
