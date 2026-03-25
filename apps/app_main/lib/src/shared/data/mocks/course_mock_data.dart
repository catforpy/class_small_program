library;

/// 课程假数据
class CourseMockData {
  /// 课程基本信息
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
      'description': '本课程从零开始，系统讲解Python全栈开发技术，包括Python基础、Web开发、数据分析等内容。',
      'instructor': {
        'name': '张老师',
        'title': '资深Python工程师',
        'avatar': 'https://picsum.photos/100/100?random=501',
        'followers': 50000,
        'courses': 15,
      },
      'chapters': getCourseChapters(),
      'reviews': getCourseReviews(),
      'qa': getCourseQA(),
    };
  }

  /// 课程章节数据
  static List<Map<String, dynamic>> getCourseChapters() {
    return [
      {
        'id': '1',
        'title': '第1章 课程介绍与环境搭建',
        'duration': '45分钟',
        'lessons': [
          {'id': '1.1', 'title': '1.1 Python环境搭建', 'duration': '15:30', 'freePreview': true},
          {'id': '1.2', 'title': '1.2 Python基本语法', 'duration': '25:45', 'freePreview': true},
          {'id': '1.3', 'title': '1.3 开发工具配置', 'duration': '20:15', 'freePreview': false},
        ],
      },
      {
        'id': '2',
        'title': '第2章 Python基础知识',
        'duration': '120分钟',
        'lessons': [
          {'id': '2.1', 'title': '2.1 变量与数据类型', 'duration': '30:00', 'freePreview': false},
          {'id': '2.2', 'title': '2.2 条件语句与循环', 'duration': '35:00', 'freePreview': false},
          {'id': '2.3', 'title': '2.3 函数与模块', 'duration': '40:00', 'freePreview': false},
          {'id': '2.4', 'title': '2.4 面向对象编程', 'duration': '45:00', 'freePreview': false},
        ],
      },
      {
        'id': '3',
        'title': '第3章 Web开发基础',
        'duration': '180分钟',
        'lessons': [
          {'id': '3.1', 'title': '3.1 HTTP协议基础', 'duration': '25:00', 'freePreview': false},
          {'id': '3.2', 'title': '3.2 Flask框架入门', 'duration': '40:00', 'freePreview': false},
          {'id': '3.3', 'title': '3.3 数据库操作', 'duration': '50:00', 'freePreview': false},
          {'id': '3.4', 'title': '3.4 前后端交互', 'duration': '45:00', 'freePreview': false},
        ],
      },
    ];
  }

  /// 课程评价数据
  static List<Map<String, dynamic>> getCourseReviews() {
    return [
      {
        'id': '1',
        'userName': '学员小明',
        'avatar': 'https://picsum.photos/100/100?random=601',
        'rating': 5,
        'content': '课程内容非常详细，老师讲解清晰，从零基础到能够独立开发项目，收获很大！推荐给想学Python的同学。',
        'time': '3天前',
        'likes': 234,
      },
      {
        'id': '2',
        'userName': '学习者小红',
        'avatar': 'https://picsum.photos/100/100?random=602',
        'rating': 5,
        'content': '实战项目很棒，跟着做下来感觉提升很大。特别是Web开发部分，讲得很透彻。',
        'time': '1周前',
        'likes': 156,
      },
      {
        'id': '3',
        'userName': '编程爱好者',
        'avatar': 'https://picsum.photos/100/100?random=603',
        'rating': 4,
        'content': '整体不错，但是有些地方讲得有点快，需要反复看。建议增加更多练习题。',
        'time': '2周前',
        'likes': 89,
      },
    ];
  }

  /// 课程问答数据
  static List<Map<String, dynamic>> getCourseQA() {
    return [
      {
        'id': '1',
        'question': '零基础可以学这门课吗？',
        'answer': '可以的，课程从Python环境搭建开始，循序渐进地讲解基础知识，非常适合零基础学员。',
        'questioner': '学员小李',
        'questionTime': '3天前',
        'likes': 456,
      },
      {
        'id': '2',
        'question': '学完能找到工作吗？',
        'answer': '课程内容覆盖了企业实际开发中常用的技术栈，认真学完并完成项目后，可以达到初级Python工程师的水平。',
        'questioner': '求职者',
        'questionTime': '1周前',
        'likes': 789,
      },
    ];
  }

  /// 课程列表数据
  static List<Map<String, dynamic>> getCourseList(int count) {
    final titles = [
      'Python全栈开发实战',
      'Java从入门到精通',
      'Flutter移动应用开发',
      'AI人工智能实战',
      '数据分析与可视化',
      'Web前端开发教程',
      'Go语言高并发编程',
      '机器学习实战',
    ];

    return List.generate(count, (index) {
      final hasCommission = index % 2 == 0;
      return {
        'id': 'course_${index + 1}',
        'title': titles[index % titles.length],
        'subtitle': '系统学习${titles[index % titles.length].replaceAll('实战', '').replaceAll('教程', '').replaceAll('开发', '').replaceAll('编程', '')}',
        'imageUrl': 'https://picsum.photos/200/150?random=${300 + index}',
        'price': 19900 - index * 1000,
        'originalPrice': index % 3 == 0 ? 29900 : null,
        'studyCount': 12345 - index * 1000,
        'rating': 4.5 + (index % 5) * 0.1,
        'hasCommission': hasCommission,
        'commissionRate': hasCommission ? 10 + index * 2 : 0,
        'difficulty': ['初级', '中级', '高级'][index % 3],
      };
    });
  }
}
