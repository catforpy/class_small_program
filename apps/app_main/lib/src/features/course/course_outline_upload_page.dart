library;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// 批量上传课程大纲页面
///
/// 支持Excel/文本文件批量导入课程大纲
class CourseOutlineUploadPage extends StatefulWidget {
  const CourseOutlineUploadPage({super.key});

  @override
  State<CourseOutlineUploadPage> createState() => _CourseOutlineUploadPageState();
}

class _CourseOutlineUploadPageState extends State<CourseOutlineUploadPage> {
  int _selectedMethod = 0; // 0=手动输入, 1=Excel导入, 2=文本导入

  // 手动输入的数据
  final List<Map<String, dynamic>> _chapters = [];
  final List<TextEditingController> _chapterControllers = [];
  final List<List<TextEditingController>> _lessonControllers = [];

  @override
  void dispose() {
    for (var controller in _chapterControllers) {
      controller.dispose();
    }
    for (var controllers in _lessonControllers) {
      for (var controller in controllers) {
        controller.dispose();
      }
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          '批量上传课程大纲',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ),
      body: Column(
        children: [
          // 选择上传方式
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '选择上传方式',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    _buildMethodSelector(0, Icons.edit, '手动输入'),
                    const SizedBox(width: 12),
                    _buildMethodSelector(1, Icons.table_chart, 'Excel导入'),
                    const SizedBox(width: 12),
                    _buildMethodSelector(2, Icons.text_snippet, '文本导入'),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // 内容区域
          Expanded(
            child: _selectedMethod == 0
                ? _buildManualInput()
                : _selectedMethod == 1
                    ? _buildExcelImport()
                    : _buildTextImport(),
          ),

          // 底部按钮
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('取消'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _confirmUpload,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF4757),
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('确认导入'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 构建上传方式选择器
  Widget _buildMethodSelector(int index, IconData icon, String label) {
    final selected = _selectedMethod == index;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedMethod = index;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: selected ? const Color(0xFFFF4757).withValues(alpha: 0.1) : Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: selected ? const Color(0xFFFF4757) : Colors.grey[300]!,
              width: selected ? 2 : 1,
            ),
          ),
          child: Column(
            children: [
              Icon(
                icon,
                color: selected ? const Color(0xFFFF4757) : Colors.grey[600],
                size: 28,
              ),
              const SizedBox(height: 8),
              Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: selected ? FontWeight.bold : FontWeight.normal,
                  color: selected ? const Color(0xFFFF4757) : Colors.grey[700],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 手动输入方式
  Widget _buildManualInput() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                '课程大纲',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              TextButton.icon(
                onPressed: _addChapter,
                icon: const Icon(Icons.add),
                label: const Text('添加章节'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: _chapters.isEmpty
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.playlist_add,
                          size: 64,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 16),
                        Text(
                          '暂无章节，点击上方按钮添加',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: _chapters.length,
                    itemBuilder: (context, chapterIndex) {
                      return _buildChapterEditor(chapterIndex);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  /// 构建章节编辑器
  Widget _buildChapterEditor(int chapterIndex) {
    final chapter = _chapters[chapterIndex];
    final lessons = (chapter['lessons'] as List<dynamic>).cast<Map<String, dynamic>>();
    final chapterController = _chapterControllers[chapterIndex];
    final lessonControllers = _lessonControllers[chapterIndex];

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 章节标题
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: chapterController,
                    decoration: const InputDecoration(
                      labelText: '章节名称',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.delete_outline, color: Colors.red),
                  onPressed: () => _deleteChapter(chapterIndex),
                  tooltip: '删除章节',
                ),
              ],
            ),
            const SizedBox(height: 12),

            // 课程列表
            Text(
              '课程列表',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 8),
            ...lessonControllers.asMap().entries.map((entry) {
              final lessonIndex = entry.key;
              final controller = entry.value;
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: controller,
                        decoration: InputDecoration(
                          labelText: '课程 ${lessonIndex + 1}',
                          border: const OutlineInputBorder(),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.close, size: 18),
                            onPressed: () => _deleteLesson(chapterIndex, lessonIndex),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),

            // 添加课程按钮
            TextButton.icon(
              onPressed: () => _addLesson(chapterIndex),
              icon: const Icon(Icons.add),
              label: const Text('添加课程'),
            ),
          ],
        ),
      ),
    );
  }

  /// Excel导入方式
  Widget _buildExcelImport() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.table_chart,
            size: 80,
            color: Colors.green[400],
          ),
          const SizedBox(height: 24),
          const Text(
            'Excel导入',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            '支持 .xlsx 和 .xls 格式',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Excel格式要求：\n第一列：章节名称\n第二列：课程名称',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[500],
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          ElevatedButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Excel导入功能开发中...')),
              );
            },
            icon: const Icon(Icons.upload_file),
            label: const Text('选择Excel文件'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            ),
          ),
          const SizedBox(height: 16),
          TextButton.icon(
            onPressed: () {
              _showFormatExample();
            },
            icon: const Icon(Icons.help_outline),
            label: const Text('查看格式示例'),
          ),
        ],
      ),
    );
  }

  /// 文本导入方式
  Widget _buildTextImport() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.text_snippet,
            size: 80,
            color: Colors.blue[400],
          ),
          const SizedBox(height: 24),
          const Text(
            '文本导入',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            '支持 .txt 和 .md 格式',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              '文本格式示例：\n\n第1章 课程介绍\n1.1 Python环境搭建\n1.2 Python基本语法\n\n第2章 Web开发基础\n2.1 HTML与CSS基础\n2.2 JavaScript入门',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[700],
                height: 1.5,
                fontFamily: 'monospace',
              ),
            ),
          ),
          const SizedBox(height: 32),
          ElevatedButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('文本导入功能开发中...')),
              );
            },
            icon: const Icon(Icons.upload_file),
            label: const Text('选择文本文件'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            ),
          ),
        ],
      ),
    );
  }

  /// 添加章节
  void _addChapter() {
    setState(() {
      _chapters.add({
        'title': '第${_chapters.length + 1}章',
        'lessons': <Map<String, dynamic>>[],
      });
      _chapterControllers.add(TextEditingController(text: '第${_chapters.length}章'));
      _lessonControllers.add(<TextEditingController>[]);
    });
  }

  /// 删除章节
  void _deleteChapter(int chapterIndex) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('删除章节'),
        content: const Text('确定要删除这个章节吗？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _chapterControllers[chapterIndex].dispose();
                for (var controller in _lessonControllers[chapterIndex]) {
                  controller.dispose();
                }
                _chapters.removeAt(chapterIndex);
                _chapterControllers.removeAt(chapterIndex);
                _lessonControllers.removeAt(chapterIndex);
              });
              Navigator.pop(context);
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

  /// 添加课程
  void _addLesson(int chapterIndex) {
    setState(() {
      final lessons = (_chapters[chapterIndex]['lessons'] as List<dynamic>).cast<Map<String, dynamic>>();
      lessons.add({'title': ''});
      _lessonControllers[chapterIndex].add(TextEditingController());
    });
  }

  /// 删除课程
  void _deleteLesson(int chapterIndex, int lessonIndex) {
    setState(() {
      _lessonControllers[chapterIndex][lessonIndex].dispose();
      (_chapters[chapterIndex]['lessons'] as List<dynamic>).removeAt(lessonIndex);
      _lessonControllers[chapterIndex].removeAt(lessonIndex);
    });
  }

  /// 显示格式示例
  void _showFormatExample() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Excel格式示例'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                '请按照以下格式准备Excel文件：',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                '| 章节名称 | 课程名称 |\n'
                '|---------|---------|\n'
                '| 第1章 课程介绍 | 1.1 Python环境搭建 |\n'
                '| 第1章 课程介绍 | 1.2 Python基本语法 |\n'
                '| 第2章 Web开发基础 | 2.1 HTML与CSS基础 |\n'
                '| 第2章 Web开发基础 | 2.2 JavaScript入门 |',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                '注意事项：\n'
                '1. 第一行必须是表头：章节名称、课程名称\n'
                '2. 相同章节名称的课程会自动归类\n'
                '3. 课程编号会自动生成\n'
                '4. 支持的格式：.xlsx、.xls',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[700],
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('知道了'),
          ),
        ],
      ),
    );
  }

  /// 确认导入
  void _confirmUpload() {
    if (_selectedMethod == 0 && _chapters.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('请先添加章节和课程')),
      );
      return;
    }

    // TODO: 实际上传逻辑
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('课程大纲导入成功！')),
    );
  }
}
