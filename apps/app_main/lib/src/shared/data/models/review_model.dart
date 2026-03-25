library;

/// 评价数据模型
class ReviewModel {
  final String id;
  final String userName;
  final String avatar;
  final int rating; // 1-5
  final String content;
  final String time;
  final int likes;
  final bool isLiked;

  const ReviewModel({
    required this.id,
    required this.userName,
    required this.avatar,
    required this.rating,
    required this.content,
    required this.time,
    required this.likes,
    this.isLiked = false,
  });

  /// 从Map创建
  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['id'] as String,
      userName: json['userName'] as String,
      avatar: json['avatar'] as String,
      rating: json['rating'] as int,
      content: json['content'] as String,
      time: json['time'] as String,
      likes: json['likes'] as int,
      isLiked: json['isLiked'] as bool? ?? false,
    );
  }

  /// 转为Map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userName': userName,
      'avatar': avatar,
      'rating': rating,
      'content': content,
      'time': time,
      'likes': likes,
      'isLiked': isLiked,
    };
  }

  /// 复制并修改
  ReviewModel copyWith({
    String? id,
    String? userName,
    String? avatar,
    int? rating,
    String? content,
    String? time,
    int? likes,
    bool? isLiked,
  }) {
    return ReviewModel(
      id: id ?? this.id,
      userName: userName ?? this.userName,
      avatar: avatar ?? this.avatar,
      rating: rating ?? this.rating,
      content: content ?? this.content,
      time: time ?? this.time,
      likes: likes ?? this.likes,
      isLiked: isLiked ?? this.isLiked,
    );
  }
}

/// 问答数据模型
class QAModel {
  final String id;
  final String question;
  final String answer;
  final String questioner;
  final String questionTime;
  final int likes;

  const QAModel({
    required this.id,
    required this.question,
    required this.answer,
    required this.questioner,
    required this.questionTime,
    required this.likes,
  });

  /// 从Map创建
  factory QAModel.fromJson(Map<String, dynamic> json) {
    return QAModel(
      id: json['id'] as String,
      question: json['question'] as String,
      answer: json['answer'] as String,
      questioner: json['questioner'] as String,
      questionTime: json['questionTime'] as String,
      likes: json['likes'] as int,
    );
  }

  /// 转为Map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'question': question,
      'answer': answer,
      'questioner': questioner,
      'questionTime': questionTime,
      'likes': likes,
    };
  }
}
