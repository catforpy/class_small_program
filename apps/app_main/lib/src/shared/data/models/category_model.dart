library;

/// 一级分类数据模型（行业分类）
class PrimaryCategoryModel {
  final String id;
  final String name;
  final String icon;
  final List<String> subCategories;

  const PrimaryCategoryModel({
    required this.id,
    required this.name,
    required this.icon,
    required this.subCategories,
  });

  /// 从Map创建
  factory PrimaryCategoryModel.fromJson(Map<String, dynamic> json) {
    return PrimaryCategoryModel(
      id: json['id'] as String,
      name: json['name'] as String,
      icon: json['icon'] as String,
      subCategories: (json['subCategories'] as List<String>),
    );
  }

  /// 转为Map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'icon': icon,
      'subCategories': subCategories,
    };
  }

  /// 复制并修改
  PrimaryCategoryModel copyWith({
    String? id,
    String? name,
    String? icon,
    List<String>? subCategories,
  }) {
    return PrimaryCategoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      icon: icon ?? this.icon,
      subCategories: subCategories ?? this.subCategories,
    );
  }
}

/// 分类下的课程数据模型
class CategoryCourseModel {
  final String id;
  final String title;
  final String subtitle;
  final String imageUrl;
  final int price;
  final int? originalPrice;
  final int studyCount;
  final bool hasCommission;
  final int commissionRate;
  final String primaryCategoryName;
  final String secondaryCategoryName;

  const CategoryCourseModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.price,
    this.originalPrice,
    required this.studyCount,
    required this.hasCommission,
    required this.commissionRate,
    required this.primaryCategoryName,
    required this.secondaryCategoryName,
  });

  /// 从Map创建
  factory CategoryCourseModel.fromJson(Map<String, dynamic> json) {
    return CategoryCourseModel(
      id: json['id'] as String,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String,
      imageUrl: json['imageUrl'] as String,
      price: json['price'] as int,
      originalPrice: json['originalPrice'] as int?,
      studyCount: json['studyCount'] as int,
      hasCommission: json['hasCommission'] as bool,
      commissionRate: json['commissionRate'] as int,
      primaryCategoryName: json['primaryCategoryName'] as String,
      secondaryCategoryName: json['secondaryCategoryName'] as String,
    );
  }

  /// 转为Map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'subtitle': subtitle,
      'imageUrl': imageUrl,
      'price': price,
      'originalPrice': originalPrice,
      'studyCount': studyCount,
      'hasCommission': hasCommission,
      'commissionRate': commissionRate,
      'primaryCategoryName': primaryCategoryName,
      'secondaryCategoryName': secondaryCategoryName,
    };
  }
}
