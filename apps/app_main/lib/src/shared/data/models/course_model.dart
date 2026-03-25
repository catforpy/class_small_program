library;

/// 课程数据模型
class CourseModel {
  final String id;
  final String title;
  final String? subtitle;
  final String imageUrl;
  final int price; // 单位：分
  final int? originalPrice;
  final String status;
  final String difficulty;
  final String duration;
  final int studentCount;
  final double rating;
  final int ratingCount;
  final bool hasTrial;
  final int trialLessons;
  final bool hasCommission;
  final int commissionRate;
  final String? description;
  final InstructorModel? instructor;

  const CourseModel({
    required this.id,
    required this.title,
    this.subtitle,
    required this.imageUrl,
    required this.price,
    this.originalPrice,
    required this.status,
    required this.difficulty,
    required this.duration,
    required this.studentCount,
    required this.rating,
    required this.ratingCount,
    required this.hasTrial,
    required this.trialLessons,
    required this.hasCommission,
    required this.commissionRate,
    this.description,
    this.instructor,
  });

  /// 从Map创建
  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      id: json['id'] as String,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String?,
      imageUrl: json['imageUrl'] as String,
      price: json['price'] as int,
      originalPrice: json['originalPrice'] as int?,
      status: json['status'] as String,
      difficulty: json['difficulty'] as String,
      duration: json['duration'] as String,
      studentCount: json['studentCount'] as int,
      rating: (json['rating'] as num).toDouble(),
      ratingCount: json['ratingCount'] as int,
      hasTrial: json['hasTrial'] as bool,
      trialLessons: json['trialLessons'] as int,
      hasCommission: json['hasCommission'] as bool,
      commissionRate: json['commissionRate'] as int,
      description: json['description'] as String?,
      instructor: json['instructor'] != null
          ? InstructorModel.fromJson(json['instructor'] as Map<String, dynamic>)
          : null,
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
      'status': status,
      'difficulty': difficulty,
      'duration': duration,
      'studentCount': studentCount,
      'rating': rating,
      'ratingCount': ratingCount,
      'hasTrial': hasTrial,
      'trialLessons': trialLessons,
      'hasCommission': hasCommission,
      'commissionRate': commissionRate,
      'description': description,
      'instructor': instructor?.toJson(),
    };
  }

  /// 复制并修改部分属性
  CourseModel copyWith({
    String? id,
    String? title,
    String? subtitle,
    String? imageUrl,
    int? price,
    int? originalPrice,
    String? status,
    String? difficulty,
    String? duration,
    int? studentCount,
    double? rating,
    int? ratingCount,
    bool? hasTrial,
    int? trialLessons,
    bool? hasCommission,
    int? commissionRate,
    String? description,
    InstructorModel? instructor,
  }) {
    return CourseModel(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      imageUrl: imageUrl ?? this.imageUrl,
      price: price ?? this.price,
      originalPrice: originalPrice ?? this.originalPrice,
      status: status ?? this.status,
      difficulty: difficulty ?? this.difficulty,
      duration: duration ?? this.duration,
      studentCount: studentCount ?? this.studentCount,
      rating: rating ?? this.rating,
      ratingCount: ratingCount ?? this.ratingCount,
      hasTrial: hasTrial ?? this.hasTrial,
      trialLessons: trialLessons ?? this.trialLessons,
      hasCommission: hasCommission ?? this.hasCommission,
      commissionRate: commissionRate ?? this.commissionRate,
      description: description ?? this.description,
      instructor: instructor ?? this.instructor,
    );
  }
}

/// 讲师数据模型
class InstructorModel {
  final String name;
  final String title;
  final String avatar;
  final int followers;
  final int courses;

  const InstructorModel({
    required this.name,
    required this.title,
    required this.avatar,
    required this.followers,
    required this.courses,
  });

  /// 从Map创建
  factory InstructorModel.fromJson(Map<String, dynamic> json) {
    return InstructorModel(
      name: json['name'] as String,
      title: json['title'] as String,
      avatar: json['avatar'] as String,
      followers: json['followers'] as int,
      courses: json['courses'] as int,
    );
  }

  /// 转为Map
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'title': title,
      'avatar': avatar,
      'followers': followers,
      'courses': courses,
    };
  }
}
