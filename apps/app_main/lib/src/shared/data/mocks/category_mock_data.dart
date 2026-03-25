library;

/// 分类假数据
///
/// 包含一级分类（行业）和二级分类（细分类目）数据
class CategoryMockData {
  /// 一级分类列表（行业分类）
  static const List<Map<String, dynamic>> primaryCategories = [
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

  /// 获取指定索引的一级分类
  static Map<String, dynamic> getPrimaryCategory(int index) {
    if (index < 0 || index >= primaryCategories.length) {
      return primaryCategories[0];
    }
    return primaryCategories[index];
  }

  /// 获取指定一级分类的二级分类列表
  static List<String> getSubCategories(int primaryIndex) {
    final category = getPrimaryCategory(primaryIndex);
    return (category['subCategories'] as List<String>);
  }

  /// 根据ID获取一级分类
  static Map<String, dynamic>? getPrimaryCategoryById(String id) {
    for (var category in primaryCategories) {
      if (category['id'] == id) {
        return category;
      }
    }
    return null;
  }
}
