library;

/// 课程申请页面 Mock 数据
///
/// 提供课程申请相关的测试数据
class CourseApplicationMockData {
  CourseApplicationMockData._();

  /// 获取课程分类列表
  static const List<String> categories = [
    '后端开发',
    '前端开发',
    '移动开发',
    '人工智能',
    '数据科学',
    '云计算',
    'DevOps',
    '设计',
  ];

  /// 获取难度等级列表
  static const List<String> difficulties = [
    '入门级',
    '初级',
    '中级',
    '高级',
    '专家级',
  ];

  /// 获取课程状态列表
  static const List<String> statuses = [
    '预售',
    '更新中',
    '已完结',
  ];

  /// 获取课程大纲（示例数据）
  static List<Map<String, dynamic>> getCourseOutline() {
    return [
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
  }

  /// 获取课程资料（示例数据）
  static List<Map<String, dynamic>> getCourseMaterials() {
    return [
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
  }

  /// 获取互动数据
  static Map<String, dynamic> getInteractionData() {
    return {
      'consultationCount': 23,
      'qaCount': 156,
      'averageRating': 4.8,
      'reviewCount': 89,
    };
  }

  /// 获取销售数据
  static Map<String, dynamic> getSalesData() {
    return {
      'salesCount': 1250,
      'totalRevenue': 237500.00,
      'forwardCount': 342,
    };
  }

  /// 获取已有课程数据（用于重新提交审核）
  static Map<String, dynamic> getExistingCourse(String courseId) {
    // TODO: 从API加载课程数据
    // 这里先使用模拟数据
    return {
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
  }
}
