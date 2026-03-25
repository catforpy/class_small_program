library;

import 'package:flutter/material.dart';

/// 课程大纲标签页
///
/// 管理课程章节和课时
class CourseOutlineTab extends StatefulWidget {
  /// 章节列表
  final List<Map<String, dynamic>> chapters;

  /// 章节变化回调
  final ValueChanged<List<Map<String, dynamic>>>? onChaptersChanged;

  /// 批量上传回调
  final VoidCallback? onBatchUpload;

  const CourseOutlineTab({
    super.key,
    required this.chapters,
    this.onChaptersChanged,
    this.onBatchUpload,
  });

  @override
  State<CourseOutlineTab> createState() => _CourseOutlineTabState();
}

class _CourseOutlineTabState extends State<CourseOutlineTab> {
  late List<Map<String, dynamic>> _chapters;

  @override
  void initState() {
    super.initState();
    _chapters = List.from(widget.chapters);
  }

  @override
  void didUpdateWidget(CourseOutlineTab oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.chapters != oldWidget.chapters) {
      _chapters = List.from(widget.chapters);
    }
  }

  void _notifyChanged() {
    widget.onChaptersChanged?.call(_chapters);
  }

  void _addChapter() {
    setState(() {
      _chapters.add({
        'id': DateTime.now().millisecondsSinceEpoch.toString(),
        'title': '第${_chapters.length + 1}章 新章节',
        'expanded': true,
        'lessons': <Map<String, dynamic>>[],
      });
    });
    _notifyChanged();
  }

  void _addLesson(int chapterIndex) {
    final chapter = _chapters[chapterIndex];
    final lessons = (chapter['lessons'] as List<dynamic>).cast<Map<String, dynamic>>();

    setState(() {
      lessons.add({
        'id': '${chapterIndex + 1}.${lessons.length + 1}',
        'title': '${chapterIndex + 1}.${lessons.length + 1} 新课程',
        'duration': '00:00',
        'uploaded': false,
        'freePreview': false,
        'scheduledDate': null,
      });
    });
    _notifyChanged();
  }

  void _editChapterTitle(Map<String, dynamic> chapter) {
    final TextEditingController controller = TextEditingController(text: chapter['title'] as String);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('编辑章节名称'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: '请输入章节名称',
            border: OutlineInputBorder(),
          ),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () {
              if (controller.text.trim().isNotEmpty) {
                setState(() {
                  chapter['title'] = controller.text.trim();
                });
                _notifyChanged();
                Navigator.pop(context);
              }
            },
            child: const Text(
              '确定',
              style: TextStyle(color: Color(0xFFFF4757)),
            ),
          ),
        ],
      ),
    );
  }

  void _deleteChapter(int chapterIndex) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('删除章节'),
        content: const Text('确定要删除这个章节吗？章节内的所有课程也将被删除。'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _chapters.removeAt(chapterIndex);
              });
              _notifyChanged();
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('章节已删除')),
              );
            },
            child: const Text(
              '删除',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  void _editLessonTitle(Map<String, dynamic> lesson) {
    final TextEditingController controller = TextEditingController(text: lesson['title'] as String);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('编辑课程名称'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: '请输入课程名称',
            border: OutlineInputBorder(),
          ),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () {
              if (controller.text.trim().isNotEmpty) {
                setState(() {
                  lesson['title'] = controller.text.trim();
                });
                _notifyChanged();
                Navigator.pop(context);
              }
            },
            child: const Text(
              '确定',
              style: TextStyle(color: Color(0xFFFF4757)),
            ),
          ),
        ],
      ),
    );
  }

  void _deleteLesson(List<Map<String, dynamic>> lessons, int lessonIndex) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('删除课程'),
        content: const Text('确定要删除这个课程吗？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                lessons.removeAt(lessonIndex);
              });
              _notifyChanged();
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('课程已删除')),
              );
            },
            child: const Text(
              '删除',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  void _toggleFreePreview(Map<String, dynamic> lesson) {
    setState(() {
      lesson['freePreview'] = !(lesson['freePreview'] as bool);
    });
    _notifyChanged();
  }

  void _reuploadLesson(Map<String, dynamic> lesson) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('重新上传视频'),
        content: const Text('确定要重新上传这个课程的视频吗？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('视频上传功能开发中...')),
              );
            },
            child: const Text(
              '确定',
              style: TextStyle(color: Color(0xFFFF4757)),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 操作按钮
        Container(
          padding: const EdgeInsets.all(16),
          color: Colors.white,
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: widget.onBatchUpload ?? () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('批量上传功能开发中...')),
                    );
                  },
                  icon: const Icon(Icons.upload_file),
                  label: const Text('批量上传'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: _addChapter,
                  icon: const Icon(Icons.add),
                  label: const Text('添加章节'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF4757),
                    foregroundColor: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),

        // 大纲列表
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: _chapters.length,
            itemBuilder: (context, index) {
              final chapter = _chapters[index];
              return ChapterCard(
                chapter: chapter,
                chapterIndex: index,
                onEditTitle: _editChapterTitle,
                onAddLesson: _addLesson,
                onDeleteChapter: _deleteChapter,
                onEditLessonTitle: _editLessonTitle,
                onDeleteLesson: _deleteLesson,
                onToggleFreePreview: _toggleFreePreview,
                onReuploadLesson: _reuploadLesson,
              );
            },
          ),
        ),
      ],
    );
  }
}

/// 章节卡片
class ChapterCard extends StatelessWidget {
  final Map<String, dynamic> chapter;
  final int chapterIndex;
  final ValueChanged<Map<String, dynamic>> onEditTitle;
  final ValueChanged<int> onAddLesson;
  final ValueChanged<int> onDeleteChapter;
  final ValueChanged<Map<String, dynamic>> onEditLessonTitle;
  final Function(List<Map<String, dynamic>>, int) onDeleteLesson;
  final ValueChanged<Map<String, dynamic>> onToggleFreePreview;
  final ValueChanged<Map<String, dynamic>> onReuploadLesson;

  const ChapterCard({
    super.key,
    required this.chapter,
    required this.chapterIndex,
    required this.onEditTitle,
    required this.onAddLesson,
    required this.onDeleteChapter,
    required this.onEditLessonTitle,
    required this.onDeleteLesson,
    required this.onToggleFreePreview,
    required this.onReuploadLesson,
  });

  @override
  Widget build(BuildContext context) {
    final expanded = chapter['expanded'] as bool;
    final lessons = (chapter['lessons'] as List<dynamic>).cast<Map<String, dynamic>>();

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        children: [
          // 章节标题
          ListTile(
            title: Text(
              chapter['title'] as String,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text('${lessons.length}节课'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit, size: 20, color: Colors.blue),
                  onPressed: () => onEditTitle(chapter),
                  tooltip: '编辑章节名称',
                ),
                IconButton(
                  icon: const Icon(Icons.add_circle_outline, size: 20, color: Colors.green),
                  onPressed: () => onAddLesson(chapterIndex),
                  tooltip: '添加课程',
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline, size: 20, color: Colors.red),
                  onPressed: () => onDeleteChapter(chapterIndex),
                  tooltip: '删除章节',
                ),
                IconButton(
                  icon: Icon(expanded ? Icons.expand_less : Icons.expand_more, size: 20),
                  onPressed: () {
                    chapter['expanded'] = !expanded;
                  },
                ),
              ],
            ),
          ),

          // 课程列表
          if (expanded)
            ...lessons.asMap().entries.map((entry) {
              final lessonIndex = entry.key;
              final lesson = entry.value;
              return LessonItem(
                lesson: lesson,
                onEditTitle: () => onEditLessonTitle(lesson),
                onDelete: () => onDeleteLesson(lessons, lessonIndex),
                onToggleFreePreview: () => onToggleFreePreview(lesson),
                onReupload: () => onReuploadLesson(lesson),
              );
            }),
        ],
      ),
    );
  }
}

/// 课程项
class LessonItem extends StatelessWidget {
  final Map<String, dynamic> lesson;
  final VoidCallback onEditTitle;
  final VoidCallback onDelete;
  final VoidCallback onToggleFreePreview;
  final VoidCallback onReupload;

  const LessonItem({
    super.key,
    required this.lesson,
    required this.onEditTitle,
    required this.onDelete,
    required this.onToggleFreePreview,
    required this.onReupload,
  });

  @override
  Widget build(BuildContext context) {
    final uploaded = lesson['uploaded'] as bool;
    final freePreview = lesson['freePreview'] as bool;

    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[50],
        border: Border(
          top: BorderSide(color: Colors.grey.withValues(alpha: 0.2)),
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Icon(
          Icons.play_circle_outline,
          size: 32,
          color: uploaded ? Colors.green : Colors.grey,
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                lesson['title'] as String,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                ),
              ),
            ),
            if (freePreview)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: Colors.green),
                ),
                child: const Text(
                  '可试看',
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.green,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
          ],
        ),
        subtitle: Text(
          '时长：${lesson['duration']}',
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit, size: 18, color: Colors.blue),
              onPressed: onEditTitle,
              tooltip: '编辑课程',
            ),
            IconButton(
              icon: Icon(
                freePreview ? Icons.visibility : Icons.visibility_off,
                size: 18,
                color: freePreview ? Colors.green : Colors.grey,
              ),
              onPressed: onToggleFreePreview,
              tooltip: freePreview ? '关闭试看' : '开启试看',
            ),
            IconButton(
              icon: const Icon(Icons.upload, size: 20, color: Colors.orange),
              onPressed: onReupload,
              tooltip: '重新上传',
            ),
            IconButton(
              icon: const Icon(Icons.delete_outline, size: 18, color: Colors.red),
              onPressed: onDelete,
              tooltip: '删除课程',
            ),
          ],
        ),
      ),
    );
  }
}
