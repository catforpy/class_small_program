library;

import 'package:flutter/material.dart';
import 'package:core_router/core_router.dart';

// ==================== 页面导入 ====================
import '../widgets/main_shell.dart';
import '../features/home/home_page.dart';
import '../features/category/category_page.dart';
import '../features/discovery/discovery_page.dart';
import '../features/study/study_page.dart';
import '../features/profile/profile_page/profile_page.dart';
import '../features/profile/profile_page/config/profile_page_config.dart';
import '../features/profile/profile_page/config/profile_header_config.dart';
import '../features/profile/account_security_page.dart';
import '../pages/search_page.dart';
import '../pages/message_page.dart';
import '../features/favorites/favorites_page.dart';
import '../features/questions/questions_page.dart';
import '../features/notes/notes_page.dart';
import '../features/notebooks/notebooks_page.dart';
import '../features/downloads/downloads_page.dart';
import '../features/course/course_detail_page.dart';
import '../features/study/course_schedule_setting_page.dart';
import '../features/course/course_detail_page_v2.dart';
import '../features/course/course_lesson_page.dart';
import '../features/course/free_course_play_page.dart';
import '../features/course/paid_course_play_page.dart';
import '../features/course/user_profile_page.dart';
import '../features/course/course_download_page.dart';
import '../features/course/course_schedule_page.dart';
import '../features/course/course_schedule_edit_page.dart';
import '../features/course/course_management_page.dart';
import '../features/course/course_application_page.dart';
import '../features/course/course_outline_upload_page.dart';
import '../features/course/course_detail_management_page.dart';
import '../features/course/course_review_progress_page.dart';
import '../features/note/note_editor_page.dart';
import '../features/test/file_cache_test_page.dart';

// ==================== 路由配置 ====================

/// 应用路由配置
///
/// 定义应用中所有路由，支持类型安全的导航
final class AppRoutes {
  // ==================== 根路径 ====================

  /// 首页 (底部导航)
  static const String home = '/';

  /// 分类页 (底部导航)
  static const String category = '/category';

  /// 发现页 (底部导航)
  static const String discovery = '/discovery';

  /// 学习页 (底部导航)
  static const String study = '/study';

  /// 我的页面 (底部导航)
  static const String profile = '/profile';

  /// 账号与安全页
  static const String accountSecurity = '/account-security';

  // ==================== 独立页面 ====================

  /// 搜索页
  static const String search = '/search';

  /// 站内信页
  static const String message = '/message';

  /// 我的收藏页
  static const String favorites = '/favorites';

  /// 我的问答页
  static const String questions = '/questions';

  /// 我的笔记页
  static const String notes = '/notes';

  /// 我的手记页
  static const String notebooks = '/notebooks';

  /// 下载管理页
  static const String downloads = '/downloads';

  // ==================== 课程相关 ====================

  /// 课程详情页
  static const String courseDetail = '/course/:courseId';

  /// 课程详情页V2
  static const String courseDetailV2 = '/course2/:courseId';

  /// 课程内容播放页
  static const String courseLesson = '/lesson/:courseId/:lessonId/:lessonTitle';

  /// 免费课程播放页
  static const String freeCoursePlay = '/course/free/:courseId';

  /// 付费课程播放页
  static const String paidCoursePlay = '/course/paid/:courseId';

  /// 用户资料页
  static const String userProfile = '/user/:userId';

  /// 课程下载页
  static const String courseDownload = '/course/download';

  /// 课程时间表页
  static const String courseSchedule = '/course/schedule';

  /// 课程时间表编辑页
  static const String courseScheduleEdit = '/course/schedule/edit';

  /// 课程管理页
  static const String courseManagement = '/course-management';

  /// 课程申请上架页
  static const String courseApplication = '/course-application';

  /// 课程大纲上传页
  static const String courseOutlineUpload = '/course-outline-upload';

  /// 课程详情管理页
  static const String courseDetailManagement = '/course-detail-management/:courseId';

  /// 课程审核进度页
  static const String courseReviewProgress = '/course-review-progress/:courseId';

  /// 课程表设置页
  static const String studyScheduleSetting = '/study/schedule/:courseId';

  // ==================== 笔记相关 ====================

  /// 笔记编辑器页
  static const String noteEditor = '/note/editor';

  // ==================== 测试页面 ====================

  /// 文件缓存测试页
  static const String fileCacheTest = '/test/file-cache';
}

// ==================== 路由配置 ====================

/// 应用路由配置
final appRouteConfig = RouteConfig(
  initialPath: AppRoutes.home,
  notFoundPath: '/404',
  routes: [
    // ==================== 主页面（底部导航） ====================
    AppRoute(
      path: AppRoutes.home,
      name: 'home',
      builder: (context, state) => MainShell(child: const HomePage()),
    ),
    AppRoute(
      path: AppRoutes.category,
      name: 'category',
      builder: (context, state) => MainShell(child: const CategoryPage()),
    ),
    AppRoute(
      path: AppRoutes.discovery,
      name: 'discovery',
      builder: (context, state) => MainShell(child: const DiscoveryPage()),
    ),
    AppRoute(
      path: AppRoutes.study,
      name: 'study',
      builder: (context, state) => MainShell(child: const StudyPage()),
    ),
    AppRoute(
      path: AppRoutes.profile,
      name: 'profile',
      builder: (context, state) => MainShell(
        child: ProfilePage(
          config: ProfilePageConfig(
            headerConfig: ProfileHeaderConfig(
              avatar: const CircleAvatar(
                backgroundImage: NetworkImage('https://picsum.photos/150/150?random=301'),
                radius: 30,
              ),
              name: '微信用户',
              subtitle: '已登录',
              nameStyle: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              subtitleStyle: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
              backgroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              avatarSize: 60,
              avatarShape: BoxShape.circle,
            ),
          ),
        ),
      ),
    ),

    // ==================== 独立页面 ====================
    AppRoute(
      path: AppRoutes.search,
      name: 'search',
      builder: (context, state) => SearchPage(),
    ),
    AppRoute(
      path: AppRoutes.message,
      name: 'message',
      builder: (context, state) => MessagePage(),
    ),
    AppRoute(
      path: AppRoutes.favorites,
      name: 'favorites',
      builder: (context, state) => const FavoritesPage(),
    ),
    AppRoute(
      path: AppRoutes.questions,
      name: 'questions',
      builder: (context, state) => const QuestionsPage(),
    ),
    AppRoute(
      path: AppRoutes.notes,
      name: 'notes',
      builder: (context, state) => const NotesPage(),
    ),
    AppRoute(
      path: AppRoutes.notebooks,
      name: 'notebooks',
      builder: (context, state) => const NotebooksPage(),
    ),
    AppRoute(
      path: AppRoutes.downloads,
      name: 'downloads',
      builder: (context, state) => const DownloadsPage(),
    ),
    AppRoute(
      path: AppRoutes.accountSecurity,
      name: 'accountSecurity',
      builder: (context, state) => const AccountSecurityPage(),
    ),

    // ==================== 课程相关 ====================
    AppRoute(
      path: AppRoutes.courseDetail,
      name: 'courseDetail',
      builder: (context, state) {
        final courseId = state.pathParameters['courseId']!;
        final query = state.uri.queryParameters;
        return CourseDetailPage(
          courseId: courseId,
          imageUrl: query['image'] ?? '',
          title: query['title'] ?? '课程详情',
          subtitle: query['subtitle'],
        );
      },
    ),
    AppRoute(
      path: AppRoutes.courseDetailV2,
      name: 'courseDetailV2',
      builder: (context, state) {
        final courseId = state.pathParameters['courseId']!;
        final query = state.uri.queryParameters;
        return CourseDetailPageV2(
          courseId: courseId,
          initialTab: query['tab'],
        );
      },
    ),
    AppRoute(
      path: AppRoutes.courseLesson,
      name: 'courseLesson',
      builder: (context, state) {
        final courseId = state.pathParameters['courseId']!;
        final lessonId = state.pathParameters['lessonId']!;
        final lessonTitle = state.pathParameters['lessonTitle']!;
        return CourseLessonPage(
          courseId: courseId,
          lessonId: lessonId,
          lessonTitle: lessonTitle,
        );
      },
    ),
    AppRoute(
      path: AppRoutes.freeCoursePlay,
      name: 'freeCoursePlay',
      builder: (context, state) {
        final courseId = state.pathParameters['courseId']!;
        final query = state.uri.queryParameters;
        return FreeCoursePlayPage(
          courseId: courseId,
          title: query['title'] ?? '课程',
          videoUrl: query['video'] ?? '',
          coverImage: query['cover'] ?? '',
        );
      },
    ),
    AppRoute(
      path: AppRoutes.paidCoursePlay,
      name: 'paidCoursePlay',
      builder: (context, state) {
        final courseId = state.pathParameters['courseId']!;
        final query = state.uri.queryParameters;
        final price = int.tryParse(query['price'] ?? '0') ?? 0;
        final originalPrice = query['originalPrice'] != null
            ? int.tryParse(query['originalPrice']!)
            : null;
        return PaidCoursePlayPage(
          courseId: courseId,
          title: query['title'] ?? '课程',
          coverImage: query['cover'] ?? '',
          price: price,
          originalPrice: originalPrice,
        );
      },
    ),
    AppRoute(
      path: AppRoutes.userProfile,
      name: 'userProfile',
      builder: (context, state) {
        final userId = state.pathParameters['userId']!;
        final query = state.uri.queryParameters;
        return UserProfilePage(
          userId: userId,
          username: query['username'] ?? '用户',
          avatarUrl: query['avatar'] ?? '',
          coverUrl: query['cover'],
        );
      },
    ),
    AppRoute(
      path: AppRoutes.courseDownload,
      name: 'courseDownload',
      builder: (context, state) => const CourseDownloadPage(),
    ),
    AppRoute(
      path: AppRoutes.courseSchedule,
      name: 'courseSchedule',
      builder: (context, state) => const CourseSchedulePage(),
    ),
    AppRoute(
      path: AppRoutes.courseScheduleEdit,
      name: 'courseScheduleEdit',
      builder: (context, state) => const CourseScheduleEditPage(),
    ),
    AppRoute(
      path: AppRoutes.courseManagement,
      name: 'courseManagement',
      builder: (context, state) => const CourseManagementPage(),
    ),
    AppRoute(
      path: AppRoutes.courseApplication,
      name: 'courseApplication',
      builder: (context, state) => const CourseApplicationPage(),
    ),
    AppRoute(
      path: AppRoutes.courseOutlineUpload,
      name: 'courseOutlineUpload',
      builder: (context, state) => const CourseOutlineUploadPage(),
    ),
    AppRoute(
      path: AppRoutes.courseDetailManagement,
      name: 'courseDetailManagement',
      builder: (context, state) {
        final courseId = state.pathParameters['courseId']!;
        return CourseDetailManagementPage(
          courseId: courseId,
        );
      },
    ),
    AppRoute(
      path: AppRoutes.courseReviewProgress,
      name: 'courseReviewProgress',
      builder: (context, state) {
        final courseId = state.pathParameters['courseId']!;
        return CourseReviewProgressPage(
          courseId: courseId,
        );
      },
    ),
    AppRoute(
      path: AppRoutes.studyScheduleSetting,
      name: 'studyScheduleSetting',
      builder: (context, state) {
        final courseId = state.pathParameters['courseId']!;
        return CourseScheduleSettingPage(
          courseId: courseId,
        );
      },
    ),

    // ==================== 笔记相关 ====================
    AppRoute(
      path: AppRoutes.noteEditor,
      name: 'noteEditor',
      builder: (context, state) {
        final query = state.uri.queryParameters;
        return NoteEditorPage(
          noteId: query['noteId'],
          initialContent: query['content'],
        );
      },
    ),

    // ==================== 测试页面 ====================
    AppRoute(
      path: AppRoutes.fileCacheTest,
      name: 'fileCacheTest',
      builder: (context, state) => const FileCacheTestPage(),
    ),
  ],
);
