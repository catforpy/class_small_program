library;

/// 课程详情管理页面 Mock 数据
///
/// 提供课程管理相关的测试数据
class CourseManagementMockData {
  CourseManagementMockData._();

  /// 获取课程基本信息
  static Map<String, dynamic> getCourseInfo(String courseId) {
    return {
      'id': courseId,
      'title': 'Python 全栈开发实战套课',
      'status': 'approved',
      // 租赁信息
      'leasingType': 'yearly', // yearly/quarterly/monthly/usage
      'leasingTypeText': '年费',
      'remainingDays': 245,
      'expiryDate': '2026-12-31',
      'remainingHours': null,
      'remainingMinutes': null,
      // 活动状态
      'hasPromotion': false, // 活动价
      'promotionPrice': 15900, // 活动价格
      'hasCommission': true, // 转发赠金
      'commissionRate': 10, // 赠金比例
      'hasFreeTrial': false, // 限时免费
      'hasNewUserOffer': false, // 新用户专享
    };
  }

  /// 获取课程大纲
  static List<Map<String, dynamic>> getChapters() {
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
            'uploaded': true,
            'freePreview': false,
            'scheduledDate': null,
          },
        ],
      },
    ];
  }

  /// 获取课程资料
  static List<Map<String, dynamic>> getMaterials() {
    return [
      {
        'id': '1',
        'title': '课程源代码',
        'description': '包含所有章节的完整源代码',
        'fileSize': '15.2 MB',
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
}
