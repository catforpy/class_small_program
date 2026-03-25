library;

/// 课程详情页面 Mock 数据
///
/// 提供课程详情相关的测试数据
class CourseDetailMockData {
  CourseDetailMockData._();

  /// 获取课程信息
  static Map<String, dynamic> getCourseInfo(String courseId) {
    return {
      'id': courseId,
      'title': 'Python 全栈开发实战套课',
      'subtitle': '从零开始掌握 Python 全栈开发，包含前端、后端、数据库等核心技术',
      'imageUrl': 'https://picsum.photos/600/400?random=101',
      'price': 19900,
      'originalPrice': 29900,
      'status': 'updating',
      'difficulty': 'intermediate',
      'duration': '32小时45分钟',
      'studentCount': 12345,
      'rating': 4.8,
      'ratingCount': 3567,
      'hasTrial': true,
      'trialLessons': 3,
      'hasCommission': true,
      'commissionRate': 10,
      'instructor': {
        'name': '王老师',
        'title': '资深Python工程师',
        'avatar': 'https://picsum.photos/100/100?random=501',
        'bio': '10年Python开发经验，曾任职于多家知名互联网公司，擅长Python全栈开发、数据分析、人工智能等领域。累计授课学员超过10万人次。',
        'courses': 12,
        'students': 50000,
      },
      'goals': [
        {'title': '掌握Python基础', 'description': '从零开始学习Python语法和数据结构'},
        {'title': 'Web全栈开发', 'description': '熟练使用Django/Flask进行Web应用开发'},
        {'title': '数据分析能力', 'description': '使用Pandas、NumPy进行数据分析和可视化'},
        {'title': '项目实战经验', 'description': '通过5个实战项目巩固所学知识'},
      ],
      'highlights': [
        {'imageUrl': 'https://picsum.photos/100/100?random=201', 'title': '实战导向', 'description': '5个真实企业级项目实战'},
        {'imageUrl': 'https://picsum.photos/100/100?random=202', 'title': '系统全面', 'description': '覆盖Python全栈开发所有核心技能'},
        {'imageUrl': 'https://picsum.photos/100/100?random=203', 'title': '就业指导', 'description': '提供简历优化和面试技巧指导'},
        {'imageUrl': 'https://picsum.photos/100/100?random=204', 'title': '终身更新', 'description': '课程内容持续更新，一次购买终身学习'},
      ],
      'chapters': [
        {
          'id': '1',
          'title': '第1章 课程介绍',
          'content': '本章对课程内容、知识点、授课过程进行引导性说明。',
          'duration': '4小时30分钟',
          'hasTrial': true,
          'lessons': [
            {'title': '1.1 Python环境搭建', 'duration': '15分钟', 'isTrial': true},
            {'title': '1.2 Python基本语法', 'duration': '45分钟', 'isTrial': true},
            {'title': '1.3 数据类型和变量', 'duration': '30分钟', 'isTrial': true},
            {'title': '1.4 流程控制语句', 'duration': '40分钟'},
          ],
        },
        {
          'id': '2',
          'title': '第2章 Web开发基础',
          'content': '本章介绍Web开发的基础知识。',
          'duration': '6小时15分钟',
          'hasTrial': false,
          'lessons': [
            {'title': '2.1 HTML与CSS基础', 'duration': '50分钟'},
            {'title': '2.2 JavaScript入门', 'duration': '1小时'},
          ],
        },
      ],
    };
  }

  /// 获取咨询数据
  static List<Map<String, dynamic>> getConsultData() {
    return [
      {
        'id': '1',
        'user': {'name': '学员小王', 'avatar': 'https://picsum.photos/50/50?random=601'},
        'question': '这个课程适合零基础学员吗？',
        'answer': '您好！本课程从Python基础讲起，非常适合零基础学员。课程内容循序渐进，包含大量实战项目，帮助您快速掌握Python全栈开发技能。',
        'time': '2小时前',
        'likes': 12,
      },
      {
        'id': '2',
        'user': {'name': '编程爱好者', 'avatar': 'https://picsum.photos/50/50?random=602'},
        'question': '学完能找到工作吗？',
        'answer': '课程包含5个企业级实战项目，并提供简历优化和面试技巧指导。很多学员通过学习本课程成功转行或升职加薪。',
        'time': '5小时前',
        'likes': 28,
      },
      {
        'id': '3',
        'user': {'name': '职场新人', 'avatar': 'https://picsum.photos/50/50?random=603'},
        'question': '课程有效期是多久？',
        'answer': '购买后可永久观看，课程内容会持续更新，一次购买终身学习。',
        'time': '1天前',
        'likes': 45,
      },
    ];
  }

  /// 获取评价数据
  static List<Map<String, dynamic>> getReviewData() {
    return [
      {
        'id': '1',
        'user': {'name': '张三', 'avatar': 'https://picsum.photos/50/50?random=701'},
        'rating': 5,
        'content': '课程非常棒！老师讲解清晰，项目实战很有帮助，学到了很多干货。强烈推荐！',
        'time': '3天前',
        'likes': 89,
      },
      {
        'id': '2',
        'user': {'name': '李四', 'avatar': 'https://picsum.photos/50/50?random=702'},
        'rating': 4,
        'content': '整体不错，内容很系统。就是有些地方讲得有点快，需要反复看几遍才能理解。',
        'time': '5天前',
        'likes': 56,
      },
      {
        'id': '3',
        'user': {'name': '王五', 'avatar': 'https://picsum.photos/50/50?random=703'},
        'rating': 5,
        'content': '作为零基础学员，这门课程让我从入门到精通，现在已经能独立开发项目了，感谢老师！',
        'time': '1周前',
        'likes': 123,
      },
    ];
  }

  /// 获取状态文本
  static String getStatusText(String status) {
    switch (status) {
      case 'updating':
        return '更新中';
      case 'completed':
        return '已完结';
      case 'presale':
        return '预售中';
      default:
        return '未知';
    }
  }

  /// 获取难度文本
  static String getDifficultyText(String difficulty) {
    switch (difficulty) {
      case 'beginner':
        return '入门级';
      case 'intermediate':
        return '中级';
      case 'advanced':
        return '高级';
      default:
        return '未知';
    }
  }
}
